import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/models/app_models.dart';
import '../constants/app_constants.dart';
import 'auth_service.dart';

final groupServiceProvider = Provider<GroupService>((ref) {
  return GroupService(ref.read(authServiceProvider));
});

// ─── Stream helpers ──────────────────────────────────────────────────────────
//
// `.handleError((_) {})` silently consumes errors without emitting a
// replacement value.  If a Firestore permission/network error fires *before*
// the first data snapshot, the StreamProvider never exits `loading` — causing
// the endless spinner on the Dashboard, Groups, and Loans screens.
//
// These helpers use a StreamTransformer that converts errors into safe empty
// values so the UI can always render (even if the data is temporarily missing).

Stream<List<T>> _safeList<T>(Stream<List<T>> source) =>
    source.transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) => sink.add(data),
      handleError: (_, __, sink) => sink.add(<T>[]),
    ));

Stream<T?> _safeNullable<T>(Stream<T?> source) =>
    source.transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) => sink.add(data),
      handleError: (_, __, sink) => sink.add(null),
    ));

// ─────────────────────────────────────────────────────────────────────────────

/// Streams the list of groups a user belongs to.
final userGroupsProvider =
    StreamProvider.family<List<GroupModel>, String>((ref, userId) {
  return _safeList(
      ref.read(groupServiceProvider).streamUserGroups(userId));
});

/// Streams the list of loans for a given group.
final groupLoansProvider =
    StreamProvider.family<List<LoanModel>, String>((ref, groupId) {
  return _safeList(
      ref.read(groupServiceProvider).streamGroupLoans(groupId));
});

/// Streams the contributions for a given group.
final groupContributionsProvider =
    StreamProvider.family<List<ContributionModel>, String>((ref, groupId) {
  return _safeList(
      ref.read(groupServiceProvider).streamContributions(groupId));
});

/// Streams a single loan document by its ID.
final loanProvider =
    StreamProvider.family<LoanModel?, String>((ref, loanId) {
  return _safeNullable(
      ref.read(groupServiceProvider).streamLoan(loanId));
});

/// Streams a single group document by its ID.
final groupStreamProvider =
    StreamProvider.family<GroupModel?, String>((ref, groupId) {
  return _safeNullable(
      ref.read(groupServiceProvider).streamGroup(groupId));
});

/// Streams pending join requests for a group (admin only).
final groupJoinRequestsProvider =
    StreamProvider.family<List<JoinRequestModel>, String>((ref, groupId) {
  return _safeList(
      ref.read(groupServiceProvider).streamJoinRequests(groupId));
});

/// Fetches the UserModel list for all members of a group.
final groupMembersProvider =
    FutureProvider.family<List<UserModel>, String>((ref, groupId) async {
  final group =
      await ref.read(groupServiceProvider).streamGroup(groupId).first;
  if (group == null) return [];
  return ref.read(groupServiceProvider).getUsersByIds(group.memberIds);
});

/// Total amount a specific member has contributed to a group (savings history).
/// Uses a Dart 3 Record `(groupId, memberId)` as the family key.
final memberSavingsProvider =
    FutureProvider.family<double, (String, String)>((ref, params) async {
  return ref
      .read(groupServiceProvider)
      .getMemberTotalContributions(params.$1, params.$2);
});

/// Number of contributions a member has made in a group.
final memberContributionCountProvider =
    FutureProvider.family<int, (String, String)>((ref, params) async {
  return ref
      .read(groupServiceProvider)
      .getMemberContributionCount(params.$1, params.$2);
});

/// Streams all broadcasts for a group, newest first.
final groupBroadcastsProvider =
    StreamProvider.family<List<GroupBroadcast>, String>((ref, groupId) {
  return _safeList(
      ref.read(groupServiceProvider).streamGroupBroadcasts(groupId));
});

class GroupService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth;

  GroupService(this._auth);

  // ─── Create Group ───
  Future<GroupModel> createGroup({
    required String name,
    required String description,
    required double contributionAmount,
    required String frequency,
    required DateTime startDate,
    String? imageUrl,
    // Loan rules — optional with sensible defaults
    double defaultInterestRate = 5.0,
    int maxRepaymentMonths = 12,
    double loanPenaltyRate = 2.0,
    int loanPenaltyGraceDays = 7,
    double maxLoanMultiplier = 3.0,
    int minContributionsForLoan = 1,
  }) async {
    final adminId = _auth.currentUserId!;
    final docRef = _db.collection(AppConstants.groupsCollection).doc();
    final inviteCode = _generateInviteCode();

    final group = GroupModel(
      id: docRef.id,
      name: name,
      adminId: adminId,
      description: description,
      contributionAmount: contributionAmount,
      contributionFrequency: frequency,
      startDate: startDate,
      memberIds: [adminId],
      payoutOrder: [adminId],
      inviteCode: inviteCode,
      status: AppConstants.statusActive,
      groupImageUrl: imageUrl,
      createdAt: DateTime.now(),
      nextContributionDate: _computeNextDate(startDate, frequency),
      defaultInterestRate: defaultInterestRate,
      maxRepaymentMonths: maxRepaymentMonths,
      loanPenaltyRate: loanPenaltyRate,
      loanPenaltyGraceDays: loanPenaltyGraceDays,
      maxLoanMultiplier: maxLoanMultiplier,
      minContributionsForLoan: minContributionsForLoan,
    );

    final batch = _db.batch();
    batch.set(docRef, group.toJson());
    batch.update(
      _db.collection(AppConstants.usersCollection).doc(adminId),
      {'groupIds': FieldValue.arrayUnion([docRef.id])},
    );
    await batch.commit();

    return group;
  }

  // ─── Get Group ───
  Future<GroupModel?> getGroup(String groupId) async {
    final doc = await _db
        .collection(AppConstants.groupsCollection)
        .doc(groupId)
        .get();
    if (!doc.exists) return null;
    return GroupModel.fromFirestore(doc);
  }

  // ─── Stream Group ───
  Stream<GroupModel?> streamGroup(String groupId) {
    return _db
        .collection(AppConstants.groupsCollection)
        .doc(groupId)
        .snapshots()
        .map((doc) => doc.exists ? GroupModel.fromFirestore(doc) : null);
  }

  // ─── Stream User Groups ───
  Stream<List<GroupModel>> streamUserGroups(String userId) {
    return _db
        .collection(AppConstants.groupsCollection)
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snap) {
          final groups = snap.docs.map(GroupModel.fromFirestore).toList();
          groups.sort((a, b) {
            final aDate = a.createdAt ?? DateTime(2000);
            final bDate = b.createdAt ?? DateTime(2000);
            return bDate.compareTo(aDate);
          });
          return groups;
        });
  }

  // ─── Submit Join Request (sends to admin for approval) ───
  Future<void> submitJoinRequest({
    required String inviteCode,
    required UserModel user,
  }) async {
    final snap = await _db
        .collection(AppConstants.groupsCollection)
        .where('inviteCode', isEqualTo: inviteCode.toUpperCase())
        .limit(1)
        .get();

    if (snap.docs.isEmpty) {
      throw 'Invalid invite code. Please check and try again.';
    }

    final group = GroupModel.fromFirestore(snap.docs.first);

    if (group.status != AppConstants.statusActive) {
      throw 'This group is no longer active.';
    }
    if (group.memberIds.contains(user.id)) {
      throw 'You are already a member of this group.';
    }
    if (group.memberIds.length >= AppConstants.maxGroupSize) {
      throw 'This group has reached its maximum capacity.';
    }

    // Prevent duplicate pending requests — query by 2 fields only (no
    // composite index needed), then filter status in Dart.
    final existing = await _db
        .collection(AppConstants.joinRequestsCollection)
        .where('groupId', isEqualTo: group.id)
        .where('userId', isEqualTo: user.id)
        .get();

    final hasPending = existing.docs.any((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data['status'] == AppConstants.statusPending;
    });
    if (hasPending) {
      throw 'You already have a pending request to join "${group.name}". Please wait for the admin to review it.';
    }

    final docRef =
        _db.collection(AppConstants.joinRequestsCollection).doc();
    final request = JoinRequestModel(
      id: docRef.id,
      groupId: group.id,
      groupName: group.name,
      userId: user.id,
      userName: user.fullName,
      userEmail: user.email,
      status: AppConstants.statusPending,
      createdAt: DateTime.now(),
    );

    await docRef.set(request.toJson());

    // Notify the group admin about the new request
    await _sendNotification(
      userId: group.adminId,
      title: '👤 New Join Request',
      body: '${user.fullName} wants to join "${group.name}". Tap to review.',
      type: 'join_request',
      groupId: group.id,
      actionId: docRef.id,
    );
  }

  // ─── Stream Join Requests for Admin ───
  // Query by groupId only (single field = no composite index needed),
  // then filter pending status in Dart.
  Stream<List<JoinRequestModel>> streamJoinRequests(String groupId) {
    return _db
        .collection(AppConstants.joinRequestsCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snap) => snap.docs
            .map(JoinRequestModel.fromFirestore)
            .where((r) => r.status == AppConstants.statusPending)
            .toList());
  }

  // ─── Approve Join Request ───
  Future<void> approveJoinRequest(JoinRequestModel request) async {
    final batch = _db.batch();

    // Add user to group's memberIds + payoutOrder
    batch.update(
      _db.collection(AppConstants.groupsCollection).doc(request.groupId),
      {
        'memberIds': FieldValue.arrayUnion([request.userId]),
        'payoutOrder': FieldValue.arrayUnion([request.userId]),
      },
    );

    // NOTE: We intentionally do NOT update the user's groupIds here.
    // The Firestore rule `allow update: if isOwner(userId)` prevents the admin
    // from writing to another user's document.  The groups screen already queries
    // groups by memberIds arrayContains userId, so the user will see the group
    // in their list automatically once memberIds is updated above.

    // Mark request as approved
    batch.update(
      _db.collection(AppConstants.joinRequestsCollection).doc(request.id),
      {
        'status': AppConstants.statusApproved,
        'reviewedAt': Timestamp.now(),
        'reviewedBy': _auth.currentUserId,
      },
    );

    await batch.commit();

    // Notify the approved user
    await _sendNotification(
      userId: request.userId,
      title: '🎉 Join Request Approved',
      body: 'You have been approved to join "${request.groupName}". Welcome!',
      type: 'join_request',
      groupId: request.groupId,
      actionId: request.id,
    );
  }

  // ─── Reject Join Request ───
  Future<void> rejectJoinRequest(JoinRequestModel request) async {
    await _db
        .collection(AppConstants.joinRequestsCollection)
        .doc(request.id)
        .update({
      'status': AppConstants.statusRejected,
      'reviewedAt': Timestamp.now(),
      'reviewedBy': _auth.currentUserId,
    });

    // Notify the rejected user
    await _sendNotification(
      userId: request.userId,
      title: '❌ Join Request Rejected',
      body: 'Your request to join "${request.groupName}" was not approved by the admin.',
      type: 'join_request',
      groupId: request.groupId,
      actionId: request.id,
    );
  }

  // ─── Record Contribution ───
  Future<ContributionModel> recordContribution({
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    String? notes,
    String? receiptUrl,
  }) async {
    final docRef = _db.collection(AppConstants.contributionsCollection).doc();
    final contribution = ContributionModel(
      id: docRef.id,
      groupId: groupId,
      memberId: memberId,
      memberName: memberName,
      amount: amount,
      contributionDate: DateTime.now(),
      status: AppConstants.statusCompleted,
      confirmedBy: _auth.currentUserId,
      confirmedAt: DateTime.now(),
      notes: notes,
      receiptUrl: receiptUrl,
      createdAt: DateTime.now(),
    );

    final batch = _db.batch();
    batch.set(docRef, contribution.toJson());
    batch.update(
      _db.collection(AppConstants.groupsCollection).doc(groupId),
      {
        'totalBalance': FieldValue.increment(amount),
        'totalContributed': FieldValue.increment(amount),
      },
    );
    await batch.commit();

    return contribution;
  }

  // ─── Stream Group Contributions ───
  Stream<List<ContributionModel>> streamContributions(String groupId) {
    return _db
        .collection(AppConstants.contributionsCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map(ContributionModel.fromFirestore).toList();
          list.sort((a, b) => b.contributionDate.compareTo(a.contributionDate));
          return list;
        });
  }

  // ─── Stream Member Contributions ───
  Stream<List<ContributionModel>> streamMemberContributions(
      String groupId, String memberId) {
    return _db
        .collection(AppConstants.contributionsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('memberId', isEqualTo: memberId)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map(ContributionModel.fromFirestore).toList();
          list.sort((a, b) => b.contributionDate.compareTo(a.contributionDate));
          return list;
        });
  }

  // ─── Request Loan ───
  Future<LoanModel> requestLoan({
    required String groupId,
    required String borrowerId,
    required String borrowerName,
    required double amount,
    required double interestRate,
    required int durationMonths,
    required String purpose,
  }) async {
    final docRef = _db.collection(AppConstants.loansCollection).doc();
    final loan = LoanModel(
      id: docRef.id,
      groupId: groupId,
      borrowerId: borrowerId,
      borrowerName: borrowerName,
      amount: amount,
      interestRate: interestRate,
      durationMonths: durationMonths,
      purpose: purpose,
      status: AppConstants.statusPending,
      requestedAt: DateTime.now(),
    );

    await docRef.set(loan.toJson());

    // Notify all group members (excluding the borrower themselves)
    final group = await getGroup(groupId);
    if (group != null) {
      await _notifyMembers(
        memberIds: group.memberIds,
        excludeUserId: borrowerId,
        title: '💰 New Loan Request',
        body: '$borrowerName requested a loan of ${_formatAmount(amount)} in "${group.name}".',
        type: 'loan',
        groupId: groupId,
        actionId: docRef.id,
      );
    }

    return loan;
  }

  // ─── Approve / Reject Loan ───
  Future<void> updateLoanStatus(
      String loanId, String status, String adminId) async {
    final loanDoc =
        await _db.collection(AppConstants.loansCollection).doc(loanId).get();
    final loan = LoanModel.fromFirestore(loanDoc);

    final updates = <String, dynamic>{
      'status': status,
      'approvedBy': adminId,
      'approvedAt': Timestamp.now(),
    };

    if (status == AppConstants.statusApproved) {
      updates['dueDate'] = Timestamp.fromDate(
        DateTime.now().add(Duration(days: loan.durationMonths * 30)),
      );

      await _db
          .collection(AppConstants.groupsCollection)
          .doc(loan.groupId)
          .update({
        'totalBalance': FieldValue.increment(-loan.amount),
        'totalLoaned': FieldValue.increment(loan.amount),
      });
    }

    await _db
        .collection(AppConstants.loansCollection)
        .doc(loanId)
        .update(updates);

    // Notify the borrower of the decision
    if (status == AppConstants.statusApproved) {
      await _sendNotification(
        userId: loan.borrowerId,
        title: '✅ Loan Approved',
        body: 'Your loan of ${_formatAmount(loan.amount)} has been approved! Check your Loans tab.',
        type: 'loan',
        groupId: loan.groupId,
        actionId: loanId,
      );
    } else if (status == AppConstants.statusRejected) {
      await _sendNotification(
        userId: loan.borrowerId,
        title: '❌ Loan Rejected',
        body: 'Your loan request of ${_formatAmount(loan.amount)} was not approved by the admin.',
        type: 'loan',
        groupId: loan.groupId,
        actionId: loanId,
      );
    }
  }

  // ─── Repay Loan ───
  Future<void> repayLoan(String loanId, double repaymentAmount) async {
    final loanDoc =
        await _db.collection(AppConstants.loansCollection).doc(loanId).get();
    final loan = LoanModel.fromFirestore(loanDoc);

    final newRepaid = loan.amountRepaid + repaymentAmount;
    final isFullyRepaid = newRepaid >= loan.totalDue;

    final updates = <String, dynamic>{
      'amountRepaid': newRepaid,
      'status': isFullyRepaid
          ? AppConstants.statusCompleted
          : AppConstants.statusApproved,
    };

    if (isFullyRepaid) {
      updates['fullyRepaidAt'] = Timestamp.now();
    }

    final batch = _db.batch();
    batch.update(
        _db.collection(AppConstants.loansCollection).doc(loanId), updates);
    batch.update(
      _db.collection(AppConstants.groupsCollection).doc(loan.groupId),
      {'totalBalance': FieldValue.increment(repaymentAmount)},
    );
    await batch.commit();
  }

  // ─── Stream Single Loan ───
  Stream<LoanModel?> streamLoan(String loanId) {
    return _db
        .collection(AppConstants.loansCollection)
        .doc(loanId)
        .snapshots()
        .map((doc) => doc.exists ? LoanModel.fromFirestore(doc) : null);
  }

  // ─── Fetch Users by IDs ───
  Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    final results = <UserModel>[];
    // Firestore whereIn supports up to 30 items per query
    for (var i = 0; i < ids.length; i += 30) {
      final chunk = ids.sublist(i, (i + 30).clamp(0, ids.length));
      final snap = await _db
          .collection(AppConstants.usersCollection)
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      results.addAll(snap.docs.map(UserModel.fromFirestore));
    }
    return results;
  }

  // ─── Stream Loans ───
  Stream<List<LoanModel>> streamGroupLoans(String groupId) {
    return _db
        .collection(AppConstants.loansCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map(LoanModel.fromFirestore).toList();
          list.sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
          return list;
        });
  }

  // ─── Issue Fine ───
  Future<void> issueFine({
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required String reason,
  }) async {
    final docRef = _db.collection(AppConstants.finesCollection).doc();
    final fine = FineModel(
      id: docRef.id,
      groupId: groupId,
      memberId: memberId,
      memberName: memberName,
      amount: amount,
      reason: reason,
      issuedAt: DateTime.now(),
    );

    await docRef.set(fine.toJson());
  }

  // ─── Stream Fines ───
  Stream<List<FineModel>> streamGroupFines(String groupId) {
    return _db
        .collection(AppConstants.finesCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snap) {
          final list = snap.docs.map(FineModel.fromFirestore).toList();
          list.sort((a, b) => b.issuedAt.compareTo(a.issuedAt));
          return list;
        });
  }

  // ─── Process Payout ───
  Future<void> processPayout(String groupId) async {
    final group = await getGroup(groupId);
    if (group == null) throw 'Group not found';
    if (group.currentPayoutIndex >= group.payoutOrder.length) {
      throw 'All payouts completed for this cycle.';
    }

    final recipientId = group.payoutOrder[group.currentPayoutIndex];
    final recipientDoc = await _db
        .collection(AppConstants.usersCollection)
        .doc(recipientId)
        .get();
    final recipientName =
        (recipientDoc.data() as Map<String, dynamic>)['fullName'] ?? 'Member';

    final payoutAmount = group.contributionAmount * group.memberIds.length;
    final docRef = _db.collection(AppConstants.payoutsCollection).doc();

    final payout = PayoutModel(
      id: docRef.id,
      groupId: groupId,
      memberId: recipientId,
      memberName: recipientName,
      amount: payoutAmount,
      roundNumber: group.currentPayoutIndex + 1,
      status: AppConstants.statusCompleted,
      scheduledDate: group.nextContributionDate,
      paidAt: DateTime.now(),
      processedBy: _auth.currentUserId,
    );

    final batch = _db.batch();
    batch.set(docRef, payout.toJson());
    batch.update(
      _db.collection(AppConstants.groupsCollection).doc(groupId),
      {
        'totalBalance': FieldValue.increment(-payoutAmount),
        'currentPayoutIndex': FieldValue.increment(1),
        'nextContributionDate': Timestamp.fromDate(
          _computeNextDate(
              group.nextContributionDate ?? DateTime.now(),
              group.contributionFrequency),
        ),
      },
    );
    await batch.commit();
  }

  // ─── Notification Helpers ───

  /// Writes a single in-app notification document to Firestore.
  /// Failures are swallowed — notifications are non-fatal.
  Future<void> _sendNotification({
    required String userId,
    required String title,
    required String body,
    required String type,
    String? groupId,
    String? actionId,
  }) async {
    try {
      final docRef =
          _db.collection(AppConstants.notificationsCollection).doc();
      await docRef.set({
        'id': docRef.id,
        'userId': userId,
        'title': title,
        'body': body,
        'type': type,
        'isRead': false,
        'groupId': groupId,
        'actionId': actionId,
        'createdAt': Timestamp.now(),
      });
    } catch (_) {
      // Non-fatal: never let a notification error break the main action
    }
  }

  /// Sends the same notification to every member in [memberIds].
  /// Pass [excludeUserId] to skip the actor (e.g. borrower notifying themselves).
  Future<void> _notifyMembers({
    required List<String> memberIds,
    required String title,
    required String body,
    required String type,
    String? groupId,
    String? actionId,
    String? excludeUserId,
  }) async {
    try {
      final targets = memberIds
          .where((id) => excludeUserId == null || id != excludeUserId)
          .toList();
      if (targets.isEmpty) return;

      // Use a batch write — max 500 ops, groups have max 50 members
      final batch = _db.batch();
      for (final userId in targets) {
        final docRef =
            _db.collection(AppConstants.notificationsCollection).doc();
        batch.set(docRef, {
          'id': docRef.id,
          'userId': userId,
          'title': title,
          'body': body,
          'type': type,
          'isRead': false,
          'groupId': groupId,
          'actionId': actionId,
          'createdAt': Timestamp.now(),
        });
      }
      await batch.commit();
    } catch (_) {
      // Non-fatal
    }
  }

  /// Formats an amount for use in notification body text.
  String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return 'RWF ${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return 'RWF ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'RWF ${amount.toStringAsFixed(0)}';
  }

  // ─── Member Savings & Eligibility ────────────────────────────────────────

  /// Returns the total amount [memberId] has contributed to [groupId].
  Future<double> getMemberTotalContributions(
      String groupId, String memberId) async {
    final snap = await _db
        .collection(AppConstants.contributionsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('memberId', isEqualTo: memberId)
        .get();
    return snap.docs.fold<double>(0.0, (sum, doc) {
      final data = doc.data() as Map<String, dynamic>;
      return sum + ((data['amount'] as num?)?.toDouble() ?? 0.0);
    });
  }

  /// Returns the number of contributions [memberId] has made in [groupId].
  Future<int> getMemberContributionCount(
      String groupId, String memberId) async {
    final snap = await _db
        .collection(AppConstants.contributionsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('memberId', isEqualTo: memberId)
        .get();
    return snap.docs.length;
  }

  // ─── Contribution Requests ───────────────────────────────────────────────

  /// Stream pending contribution requests for [groupId] (admin view).
  Stream<List<ContributionRequest>> streamContributionRequests(String groupId) {
    return _db
        .collection(AppConstants.contributionRequestsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((s) => s.docs.map(ContributionRequest.fromFirestore).toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime(2000);
            final bDate = b.createdAt ?? DateTime(2000);
            return bDate.compareTo(aDate);
          }));
  }

  /// Stream a member's own contribution requests (all statuses) in [groupId].
  Stream<List<ContributionRequest>> streamMemberContributionRequests(
      String groupId, String memberId) {
    return _db
        .collection(AppConstants.contributionRequestsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('memberId', isEqualTo: memberId)
        .snapshots()
        .map((s) => s.docs.map(ContributionRequest.fromFirestore).toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime(2000);
            final bDate = b.createdAt ?? DateTime(2000);
            return bDate.compareTo(aDate);
          }));
  }

  /// Member submits a contribution request — admin must approve it.
  Future<void> submitContributionRequest({
    required String groupId,
    required String groupName,
    required String memberId,
    required String memberName,
    required double amount,
    String? note,
    required String adminId,
  }) async {
    final ref =
        _db.collection(AppConstants.contributionRequestsCollection).doc();
    await ref.set({
      'groupId': groupId,
      'groupName': groupName,
      'memberId': memberId,
      'memberName': memberName,
      'amount': amount,
      'status': 'pending',
      'note': note,
      'createdAt': Timestamp.now(),
      'reviewedAt': null,
      'reviewedBy': null,
    });
    // Notify admin
    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': adminId,
      'title': 'Contribution Request',
      'body':
          '$memberName submitted ${_formatAmount(amount)} for $groupName — awaiting your approval.',
      'type': 'contribution_request',
      'isRead': false,
      'groupId': groupId,
      'actionId': ref.id,
      'createdAt': Timestamp.now(),
    });
  }

  /// Admin approves a contribution request → creates Contribution, updates group balance.
  Future<void> approveContributionRequest({
    required String requestId,
    required String adminId,
    required String adminName,
  }) async {
    final reqRef = _db
        .collection(AppConstants.contributionRequestsCollection)
        .doc(requestId);
    final reqSnap = await reqRef.get();
    final req = ContributionRequest.fromFirestore(reqSnap);

    final batch = _db.batch();
    batch.update(reqRef, {
      'status': 'approved',
      'reviewedAt': Timestamp.now(),
      'reviewedBy': adminId,
    });

    final contribRef =
        _db.collection(AppConstants.contributionsCollection).doc();
    batch.set(contribRef, {
      'groupId': req.groupId,
      'memberId': req.memberId,
      'memberName': req.memberName,
      'amount': req.amount,
      'contributionDate': Timestamp.now(),
      'status': 'completed',
      'confirmedBy': adminId,
      'confirmedAt': Timestamp.now(),
      'notes': req.note,
      'createdAt': Timestamp.now(),
    });

    final groupRef =
        _db.collection(AppConstants.groupsCollection).doc(req.groupId);
    batch.update(groupRef, {
      'totalBalance': FieldValue.increment(req.amount),
      'totalContributed': FieldValue.increment(req.amount),
    });

    await batch.commit();

    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': req.memberId,
      'title': 'Contribution Approved ✅',
      'body':
          'Your contribution of ${_formatAmount(req.amount)} to ${req.groupName} was approved by $adminName.',
      'type': 'contribution',
      'isRead': false,
      'groupId': req.groupId,
      'actionId': contribRef.id,
      'createdAt': Timestamp.now(),
    });
  }

  /// Admin rejects a contribution request.
  Future<void> rejectContributionRequest({
    required String requestId,
    required String adminId,
    required String adminName,
    String? reason,
  }) async {
    final reqRef = _db
        .collection(AppConstants.contributionRequestsCollection)
        .doc(requestId);
    final reqSnap = await reqRef.get();
    final req = ContributionRequest.fromFirestore(reqSnap);

    await reqRef.update({
      'status': 'rejected',
      'reviewedAt': Timestamp.now(),
      'reviewedBy': adminId,
    });

    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': req.memberId,
      'title': 'Contribution Not Approved',
      'body':
          'Your contribution of ${_formatAmount(req.amount)} to ${req.groupName} was not approved. ${reason ?? ''}',
      'type': 'contribution',
      'isRead': false,
      'groupId': req.groupId,
      'actionId': requestId,
      'createdAt': Timestamp.now(),
    });
  }

  // ─── Repayment Requests ──────────────────────────────────────────────────

  /// Stream pending repayment requests for [groupId] (admin view).
  Stream<List<RepaymentRequest>> streamRepaymentRequests(String groupId) {
    return _db
        .collection(AppConstants.repaymentRequestsCollection)
        .where('groupId', isEqualTo: groupId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((s) => s.docs.map(RepaymentRequest.fromFirestore).toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime(2000);
            final bDate = b.createdAt ?? DateTime(2000);
            return bDate.compareTo(aDate);
          }));
  }

  /// Member submits a loan repayment request — admin must approve it.
  Future<void> submitRepaymentRequest({
    required String loanId,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required String adminId,
    required String groupName,
  }) async {
    final ref =
        _db.collection(AppConstants.repaymentRequestsCollection).doc();
    await ref.set({
      'loanId': loanId,
      'groupId': groupId,
      'memberId': memberId,
      'memberName': memberName,
      'amount': amount,
      'status': 'pending',
      'createdAt': Timestamp.now(),
      'reviewedAt': null,
      'reviewedBy': null,
    });
    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': adminId,
      'title': 'Loan Repayment Submitted',
      'body':
          '$memberName submitted ${_formatAmount(amount)} repayment for a loan in $groupName — awaiting your approval.',
      'type': 'loan',
      'isRead': false,
      'groupId': groupId,
      'actionId': ref.id,
      'createdAt': Timestamp.now(),
    });
  }

  /// Admin approves a repayment → updates loan balance.
  Future<void> approveRepaymentRequest({
    required String requestId,
    required String adminId,
    required String adminName,
  }) async {
    final reqRef = _db
        .collection(AppConstants.repaymentRequestsCollection)
        .doc(requestId);
    final reqSnap = await reqRef.get();
    final req = RepaymentRequest.fromFirestore(reqSnap);

    final batch = _db.batch();
    batch.update(reqRef, {
      'status': 'approved',
      'reviewedAt': Timestamp.now(),
      'reviewedBy': adminId,
    });

    final loanSnap = await _db
        .collection(AppConstants.loansCollection)
        .doc(req.loanId)
        .get();
    final loanData = loanSnap.data() as Map<String, dynamic>? ?? {};
    final principal = (loanData['amount'] as num?)?.toDouble() ?? 0.0;
    final rate = (loanData['interestRate'] as num?)?.toDouble() ?? 0.0;
    final totalDue = principal + (principal * rate / 100);
    final alreadyRepaid =
        (loanData['amountRepaid'] as num?)?.toDouble() ?? 0.0;
    final newRepaid = alreadyRepaid + req.amount;
    final isFullyRepaid = newRepaid >= totalDue;

    final loanRef =
        _db.collection(AppConstants.loansCollection).doc(req.loanId);
    batch.update(loanRef, {
      'amountRepaid': newRepaid,
      if (isFullyRepaid) 'status': 'completed',
      if (isFullyRepaid) 'fullyRepaidAt': Timestamp.now(),
    });

    // Returned repayment goes back into group balance
    final groupRef =
        _db.collection(AppConstants.groupsCollection).doc(req.groupId);
    batch.update(groupRef, {
      'totalBalance': FieldValue.increment(req.amount),
    });

    await batch.commit();

    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': req.memberId,
      'title': isFullyRepaid ? 'Loan Fully Repaid 🎉' : 'Repayment Approved ✅',
      'body': isFullyRepaid
          ? 'Your loan is now fully repaid! ${_formatAmount(req.amount)} confirmed by $adminName.'
          : 'Your repayment of ${_formatAmount(req.amount)} was approved by $adminName.',
      'type': 'loan',
      'isRead': false,
      'groupId': req.groupId,
      'actionId': req.loanId,
      'createdAt': Timestamp.now(),
    });
  }

  /// Admin rejects a repayment request.
  Future<void> rejectRepaymentRequest({
    required String requestId,
    required String adminId,
    String? reason,
  }) async {
    final reqRef = _db
        .collection(AppConstants.repaymentRequestsCollection)
        .doc(requestId);
    final reqSnap = await reqRef.get();
    final req = RepaymentRequest.fromFirestore(reqSnap);

    await reqRef.update({
      'status': 'rejected',
      'reviewedAt': Timestamp.now(),
      'reviewedBy': adminId,
    });

    await _db.collection(AppConstants.notificationsCollection).add({
      'userId': req.memberId,
      'title': 'Repayment Not Approved',
      'body':
          'Your repayment of ${_formatAmount(req.amount)} was not approved. ${reason ?? ''}',
      'type': 'loan',
      'isRead': false,
      'groupId': req.groupId,
      'actionId': requestId,
      'createdAt': Timestamp.now(),
    });
  }

  // ─── Group Broadcasts ────────────────────────────────────────────────────

  /// Streams all broadcasts for [groupId], ordered newest-first in Dart.
  Stream<List<GroupBroadcast>> streamGroupBroadcasts(String groupId) {
    return _db
        .collection(AppConstants.groupBroadcastsCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snap) {
      final list = snap.docs
          .map((d) => GroupBroadcast.fromFirestore(d))
          .toList()
        ..sort((a, b) {
          final aDate = a.createdAt ?? DateTime(2000);
          final bDate = b.createdAt ?? DateTime(2000);
          return bDate.compareTo(aDate);
        });
      return list;
    });
  }

  /// Admin sends a broadcast message to all group members.
  /// Creates the broadcast doc + one notification per member.
  Future<void> sendBroadcast({
    required String groupId,
    required String groupName,
    required String title,
    required String message,
    required String senderId,
    required String senderName,
    required List<String> memberIds,
  }) async {
    final broadcastRef =
        _db.collection(AppConstants.groupBroadcastsCollection).doc();

    await broadcastRef.set({
      'groupId': groupId,
      'groupName': groupName,
      'title': title,
      'message': message,
      'senderId': senderId,
      'senderName': senderName,
      'reactions': {},
      'createdAt': Timestamp.now(),
    });

    // Notify every member except the sender
    await _notifyMembers(
      memberIds: memberIds,
      title: title,
      body: message,
      type: 'broadcast',
      groupId: groupId,
      actionId: broadcastRef.id,
      excludeUserId: senderId,
    );
  }

  /// Toggles [emoji] reaction by [userId] on a broadcast.
  /// Tapping the same emoji again removes the reaction.
  Future<void> reactToBroadcast({
    required String broadcastId,
    required String userId,
    required String emoji,
  }) async {
    final ref = _db
        .collection(AppConstants.groupBroadcastsCollection)
        .doc(broadcastId);

    // Read current reaction to decide add vs remove
    final snap = await ref.get();
    final reactions =
        Map<String, String>.from(snap.data()?['reactions'] as Map? ?? {});
    if (reactions[userId] == emoji) {
      reactions.remove(userId); // tap same emoji = remove
    } else {
      reactions[userId] = emoji;
    }
    await ref.update({'reactions': reactions});
  }

  // ─── Helpers ───
  String _generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();
  }

  DateTime _computeNextDate(DateTime from, String frequency) {
    switch (frequency) {
      case AppConstants.freqWeekly:
        return from.add(const Duration(days: 7));
      case AppConstants.freqBiweekly:
        return from.add(const Duration(days: 14));
      case AppConstants.freqMonthly:
      default:
        return DateTime(from.year, from.month + 1, from.day);
    }
  }
}