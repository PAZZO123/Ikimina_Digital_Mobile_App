import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_models.freezed.dart';
part 'app_models.g.dart';

/// Recursively converts Firestore [Timestamp] values to ISO-8601 strings
/// so that [json_serializable]-generated [fromJson] methods can parse them.
Map<String, dynamic> _fromFirestore(Map<String, dynamic> data) {
  return data.map((key, value) {
    if (value is Timestamp) {
      return MapEntry(key, value.toDate().toIso8601String());
    }
    if (value is Map<String, dynamic>) {
      return MapEntry(key, _fromFirestore(value));
    }
    return MapEntry(key, value);
  });
}

// ─────────────────────────── USER MODEL ───────────────────────────

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String fullName,
    required String email,
    required String phone,
    @Default('member') String role,
    String? profileImageUrl,
    @Default([]) List<String> groupIds,
    @Default(true) bool isActive,
    @Default(false) bool emailVerified,
    @Default(false) bool biometricEnabled,
    @Default('en') String preferredLanguage,
    @Default('light') String preferredTheme,
    DateTime? createdAt,
    DateTime? lastSeen,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return UserModel.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── GROUP MODEL ───────────────────────────

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String id,
    required String name,
    required String adminId,
    required double contributionAmount,
    required String contributionFrequency,
    required String description,
    @Default([]) List<String> memberIds,
    @Default([]) List<String> payoutOrder,
    @Default(0) int currentPayoutIndex,
    @Default(0.0) double totalBalance,
    @Default(0.0) double totalContributed,
    @Default(0.0) double totalLoaned,
    @Default('active') String status,
    String? groupImageUrl,
    String? inviteCode,
    DateTime? startDate,
    DateTime? nextContributionDate,
    DateTime? createdAt,
    // ── Loan & penalty rules ─────────────────────────────────────────────
    // All use @Default so existing Firestore docs load without errors.
    @Default(5.0) double defaultInterestRate,    // % applied to every loan
    @Default(12)  int    maxRepaymentMonths,      // longest allowed duration
    @Default(2.0) double loanPenaltyRate,         // % added per late period
    @Default(7)   int    loanPenaltyGraceDays,    // days before penalty kicks in
    @Default(3.0) double maxLoanMultiplier,       // savings × this = borrow limit
    @Default(1)   int    minContributionsForLoan, // min deposits before eligible
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return GroupModel.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── CONTRIBUTION MODEL ───────────────────────────

@freezed
class ContributionModel with _$ContributionModel {
  const factory ContributionModel({
    required String id,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required DateTime contributionDate,
    @Default('completed') String status,
    String? receiptUrl,
    String? notes,
    String? confirmedBy,
    DateTime? confirmedAt,
    DateTime? createdAt,
  }) = _ContributionModel;

  factory ContributionModel.fromJson(Map<String, dynamic> json) =>
      _$ContributionModelFromJson(json);

  factory ContributionModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return ContributionModel.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── LOAN MODEL ───────────────────────────

@freezed
class LoanModel with _$LoanModel {
  const factory LoanModel({
    required String id,
    required String groupId,
    required String borrowerId,
    required String borrowerName,
    required double amount,
    required double interestRate,
    required int durationMonths,
    required DateTime requestedAt,
    @Default('pending') String status,
    @Default(0.0) double amountRepaid,
    String? purpose,
    String? approvedBy,
    DateTime? approvedAt,
    DateTime? dueDate,
    DateTime? fullyRepaidAt,
  }) = _LoanModel;

  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);

  factory LoanModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return LoanModel.fromJson({...data, 'id': doc.id});
  }

  const LoanModel._();

  double get totalDue => amount + (amount * interestRate / 100);
  double get remainingBalance => totalDue - amountRepaid;
  double get repaymentProgress => amountRepaid / totalDue;
  bool get isFullyRepaid => amountRepaid >= totalDue;

  /// True when an approved loan has passed its due date without full repayment.
  bool get isOverdue {
    if (status != 'approved') return false;
    if (dueDate == null) return false;
    return DateTime.now().isAfter(dueDate!) && !isFullyRepaid;
  }
}

// ─────────────────────────── PAYOUT MODEL ───────────────────────────

@freezed
class PayoutModel with _$PayoutModel {
  const factory PayoutModel({
    required String id,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required int roundNumber,
    @Default('pending') String status,
    DateTime? scheduledDate,
    DateTime? paidAt,
    String? processedBy,
    String? notes,
  }) = _PayoutModel;

  factory PayoutModel.fromJson(Map<String, dynamic> json) =>
      _$PayoutModelFromJson(json);

  factory PayoutModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return PayoutModel.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── FINE MODEL ───────────────────────────

@freezed
class FineModel with _$FineModel {
  const factory FineModel({
    required String id,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required String reason,
    required DateTime issuedAt,
    @Default('unpaid') String status,
    DateTime? paidAt,
  }) = _FineModel;

  factory FineModel.fromJson(Map<String, dynamic> json) =>
      _$FineModelFromJson(json);

  factory FineModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return FineModel.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── NOTIFICATION MODEL ───────────────────────────

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required String title,
    required String body,
    required String type,
    @Default(false) bool isRead,
    String? groupId,
    String? actionId,
    DateTime? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  factory AppNotification.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return AppNotification.fromJson({...data, 'id': doc.id});
  }
}

// ─────────────────────────── INVITATION MODEL ───────────────────────────

@freezed
class InvitationModel with _$InvitationModel {
  const factory InvitationModel({
    required String id,
    required String groupId,
    required String groupName,
    required String invitedBy,
    required String inviteCode,
    @Default('pending') String status,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) = _InvitationModel;

  factory InvitationModel.fromJson(Map<String, dynamic> json) =>
      _$InvitationModelFromJson(json);
}

// ─────────────────────────── DASHBOARD STATS ───────────────────────────

@freezed
class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    @Default(0) int totalGroups,
    @Default(0.0) double totalSaved,
    @Default(0.0) double totalLoaned,
    @Default(0.0) double pendingFines,
    @Default(0.0) double nextPayoutAmount,
    DateTime? nextPayoutDate,
    @Default([]) List<ChartDataPoint> contributionTrend,
    @Default([]) List<ChartDataPoint> savingsTrend,
  }) = _DashboardStats;
}

@freezed
class ChartDataPoint with _$ChartDataPoint {
  const factory ChartDataPoint({
    required String label,
    required double value,
    DateTime? date,
  }) = _ChartDataPoint;

  factory ChartDataPoint.fromJson(Map<String, dynamic> json) =>
      _$ChartDataPointFromJson(json);
}

// ─────────────────────────── JOIN REQUEST MODEL ───────────────────────────

class JoinRequestModel {
  final String id;
  final String groupId;
  final String groupName;
  final String userId;
  final String userName;
  final String userEmail;
  final String status; // pending | approved | rejected
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;

  const JoinRequestModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.status = 'pending',
    this.createdAt,
    this.reviewedAt,
    this.reviewedBy,
  });

  factory JoinRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return JoinRequestModel(
      id: doc.id,
      groupId: data['groupId'] as String? ?? '',
      groupName: data['groupName'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      userName: data['userName'] as String? ?? '',
      userEmail: data['userEmail'] as String? ?? '',
      status: data['status'] as String? ?? 'pending',
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'] as String)
          : null,
      reviewedAt: data['reviewedAt'] != null
          ? DateTime.tryParse(data['reviewedAt'] as String)
          : null,
      reviewedBy: data['reviewedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'groupName': groupName,
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'reviewedAt': reviewedAt?.toIso8601String(),
        'reviewedBy': reviewedBy,
      };
}

// ─────────────────────── CONTRIBUTION REQUEST MODEL ──────────────────────
// Member submits a contribution; admin approves before money hits group balance.

class ContributionRequest {
  final String id;
  final String groupId;
  final String groupName;
  final String memberId;
  final String memberName;
  final double amount;
  final String status; // pending | approved | rejected
  final String? note;
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;

  const ContributionRequest({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.memberId,
    required this.memberName,
    required this.amount,
    this.status = 'pending',
    this.note,
    this.createdAt,
    this.reviewedAt,
    this.reviewedBy,
  });

  factory ContributionRequest.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return ContributionRequest(
      id: doc.id,
      groupId: data['groupId'] as String? ?? '',
      groupName: data['groupName'] as String? ?? '',
      memberId: data['memberId'] as String? ?? '',
      memberName: data['memberName'] as String? ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      status: data['status'] as String? ?? 'pending',
      note: data['note'] as String?,
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'] as String)
          : null,
      reviewedAt: data['reviewedAt'] != null
          ? DateTime.tryParse(data['reviewedAt'] as String)
          : null,
      reviewedBy: data['reviewedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'groupId': groupId,
        'groupName': groupName,
        'memberId': memberId,
        'memberName': memberName,
        'amount': amount,
        'status': status,
        'note': note,
        'createdAt': createdAt?.toIso8601String(),
        'reviewedAt': reviewedAt?.toIso8601String(),
        'reviewedBy': reviewedBy,
      };
}

// ─────────────────────── REPAYMENT REQUEST MODEL ─────────────────────────
// Member submits a loan repayment; admin approves before loan balance updates.

class RepaymentRequest {
  final String id;
  final String loanId;
  final String groupId;
  final String memberId;
  final String memberName;
  final double amount;
  final String status; // pending | approved | rejected
  final DateTime? createdAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;

  const RepaymentRequest({
    required this.id,
    required this.loanId,
    required this.groupId,
    required this.memberId,
    required this.memberName,
    required this.amount,
    this.status = 'pending',
    this.createdAt,
    this.reviewedAt,
    this.reviewedBy,
  });

  factory RepaymentRequest.fromFirestore(DocumentSnapshot doc) {
    final data = _fromFirestore(doc.data() as Map<String, dynamic>);
    return RepaymentRequest(
      id: doc.id,
      loanId: data['loanId'] as String? ?? '',
      groupId: data['groupId'] as String? ?? '',
      memberId: data['memberId'] as String? ?? '',
      memberName: data['memberName'] as String? ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
      status: data['status'] as String? ?? 'pending',
      createdAt: data['createdAt'] != null
          ? DateTime.tryParse(data['createdAt'] as String)
          : null,
      reviewedAt: data['reviewedAt'] != null
          ? DateTime.tryParse(data['reviewedAt'] as String)
          : null,
      reviewedBy: data['reviewedBy'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'loanId': loanId,
        'groupId': groupId,
        'memberId': memberId,
        'memberName': memberName,
        'amount': amount,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'reviewedAt': reviewedAt?.toIso8601String(),
        'reviewedBy': reviewedBy,
      };
}

// ─────────────────────── GROUP BROADCAST MODEL ───────────────────────────
// Admin sends a broadcast to all members of a group.
// `reactions` maps memberId → emoji string (e.g. '👍', '❤️', '😮', '😂').

@freezed
class GroupBroadcast with _$GroupBroadcast {
  const factory GroupBroadcast({
    required String id,
    required String groupId,
    required String groupName,
    required String title,
    required String message,
    required String senderId,
    required String senderName,
    @Default({}) Map<String, String> reactions,
    DateTime? createdAt,
  }) = _GroupBroadcast;

  factory GroupBroadcast.fromJson(Map<String, dynamic> json) =>
      _$GroupBroadcastFromJson(json);

  factory GroupBroadcast.fromFirestore(DocumentSnapshot doc) {
    final raw = doc.data() as Map<String, dynamic>;
    // Reactions map: keys are userIds, values are emoji strings
    final reactions = (raw['reactions'] as Map<String, dynamic>?)
            ?.map((k, v) => MapEntry(k, v.toString())) ??
        {};
    final data = _fromFirestore({...raw, 'reactions': reactions});
    return GroupBroadcast.fromJson({...data, 'id': doc.id});
  }
}
