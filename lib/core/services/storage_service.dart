import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static final _picker = ImagePicker();
  static final _storage = FirebaseStorage.instance;

  /// Show gallery/camera picker and return the selected file.
  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    int maxWidthPx = 800,
    int quality = 85,
  }) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: maxWidthPx.toDouble(),
      imageQuality: quality,
    );
    if (picked == null) return null;
    return File(picked.path);
  }

  /// Upload profile picture to Firebase Storage and return the download URL.
  static Future<String> uploadProfilePicture(File file, String userId) async {
    final ref = _storage
        .ref()
        .child('users')
        .child(userId)
        .child('profile.jpg');

    return _uploadAndGetUrl(file, ref);
  }

  /// Upload group cover image — returns download URL.
  static Future<String> uploadGroupImage(File file, String groupId) async {
    final ref = _storage
        .ref()
        .child('group_images')
        .child('$groupId.jpg');

    return _uploadAndGetUrl(file, ref);
  }

  /// Upload contribution receipt — returns download URL.
  static Future<String> uploadReceipt(File file, String contributionId) async {
    final ref = _storage
        .ref()
        .child('receipts')
        .child('$contributionId.jpg');

    return _uploadAndGetUrl(file, ref);
  }

  /// Internal helper: uploads [file] to [ref] and returns the download URL.
  /// Validates the TaskSnapshot state so a silent failure never triggers
  /// a misleading `object-not-found` error from getDownloadURL().
  static Future<String> _uploadAndGetUrl(File file, Reference ref) async {
    try {
      final uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final snapshot = await uploadTask;

      if (snapshot.state != TaskState.success) {
        throw Exception('Upload did not complete (state: ${snapshot.state}). '
            'Please check your internet connection and try again.');
      }

      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('StorageService upload error: ${e.code} — ${e.message}');
      if (e.code == 'permission-denied') {
        throw Exception('Permission denied. Make sure you are signed in and '
            'have the right to upload this file.');
      }
      if (e.code == 'object-not-found') {
        throw Exception('Upload may have failed. Please check your internet '
            'connection and try again.');
      }
      rethrow;
    }
  }

  /// Delete a file from Firebase Storage by its download URL.
  static Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (_) {
      // Ignore — file may already be deleted or URL invalid
    }
  }
}
