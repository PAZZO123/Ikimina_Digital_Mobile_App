import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../shared/models/app_models.dart';
import '../constants/app_constants.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Streams the current user's Firestore document so the UI always stays
/// in sync (language preference, profile updates, etc.).
///
/// Uses [asyncExpand] directly on [authStateChanges] so the stream always
/// emits at least one value as soon as Firebase Auth resolves — avoiding the
/// `Stream.empty()` dead-lock that kept StreamProviders in loading forever.
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final firestore = FirebaseFirestore.instance;
  final service = ref.read(authServiceProvider);

  return FirebaseAuth.instance.authStateChanges().asyncExpand((authUser) {
    // Not signed-in → emit null immediately so the router can redirect.
    if (authUser == null) return Stream.value(null);

    return firestore
        .collection(AppConstants.usersCollection)
        .doc(authUser.uid)
        .snapshots()
        .asyncMap((doc) async {
          if (!doc.exists) {
            // Auth exists but Firestore doc missing — create it now.
            final newUser = UserModel(
              id: authUser.uid,
              fullName: authUser.displayName ?? authUser.email!.split('@')[0],
              email: authUser.email!,
              phone: '',
              role: AppConstants.roleMember,
              createdAt: DateTime.now(),
            );
            await service.createUserDoc(newUser);
            return newUser;
          }
          return UserModel.fromFirestore(doc);
        })
        // Swallow transient Firestore errors (e.g. permission-denied during
        // an offline batch write) so the stream stays open and resumes on
        // the next Firestore snapshot — the dashboard never crashes.
        .handleError((_) {});
  });
});

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;

  // ─── Register ───
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: credential.user!.uid,
        fullName: fullName,
        email: email,
        phone: phone,
        role: AppConstants.roleMember,
        createdAt: DateTime.now(),
      );

      try {
        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(user.id)
            .set(user.toJson());
      } catch (firestoreError) {
        // Auth succeeded but Firestore write failed — retry once
        await Future.delayed(const Duration(seconds: 1));
        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(user.id)
            .set(user.toJson());
      }

      await credential.user!.updateDisplayName(fullName);
      try {
        await credential.user!.sendEmailVerification();
      } catch (_) {
        // Email verification failure is non-fatal
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── Login ───
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        // User exists in Auth but not Firestore — create the document now
        final user = UserModel(
          id: uid,
          fullName: credential.user!.displayName ??
              email.split('@')[0],
          email: email,
          phone: '',
          role: AppConstants.roleMember,
          createdAt: DateTime.now(),
        );
        await _firestore
            .collection(AppConstants.usersCollection)
            .doc(uid)
            .set(user.toJson());
        return user;
      }

      // Update last seen using set+merge so it never fails on missing doc
      _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .set({'lastSeen': FieldValue.serverTimestamp()}, SetOptions(merge: true));

      return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── Google Sign-In ───
  /// Returns null when the user dismisses the account picker (cancelled).
  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // user cancelled

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user!;
      final uid = firebaseUser.uid;

      final userDoc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        // First-time Google sign-in — create the Firestore profile.
        final newUser = UserModel(
          id: uid,
          fullName: firebaseUser.displayName ??
              (firebaseUser.email ?? '').split('@')[0],
          email: firebaseUser.email ?? '',
          phone: '',
          role: AppConstants.roleMember,
          createdAt: DateTime.now(),
        );
        await createUserDoc(newUser);
        return newUser;
      }

      // Touch lastSeen for returning users (fire-and-forget).
      _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .set({'lastSeen': FieldValue.serverTimestamp()}, SetOptions(merge: true));

      return UserModel.fromFirestore(userDoc);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('sign_in_canceled') || msg.contains('canceled')) {
        return null; // treat as cancellation
      }
      throw 'Google sign-in failed. Please try again.';
    }
  }

  // ─── Logout ───
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ─── Password Reset ───
  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ─── Create User Document ───
  Future<void> createUserDoc(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.id)
        .set(user.toJson());
  }

  // ─── Get User ───
  Future<UserModel?> getUserById(String userId) async {
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  // ─── Update Profile ───
  Future<void> updateProfile(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.id)
        .update(user.toJson());
  }

  // ─── Update FCM Token ───
  Future<void> updateFcmToken(String token) async {
    final userId = currentUserId;
    if (userId == null) return;
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .update({'fcmToken': token});
  }

  // ─── Stream User ───
  Stream<UserModel?> streamCurrentUser() {
    final userId = currentUserId;
    if (userId == null) return const Stream.empty();
    return _firestore
        .collection(AppConstants.usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);
  }

  // ─── Error Handler ───
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak. Use at least 8 characters.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
