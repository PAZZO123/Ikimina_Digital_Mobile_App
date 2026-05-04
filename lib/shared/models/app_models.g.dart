// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String? ?? 'member',
      profileImageUrl: json['profileImageUrl'] as String?,
      groupIds: (json['groupIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      emailVerified: json['emailVerified'] as bool? ?? false,
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      preferredLanguage: json['preferredLanguage'] as String? ?? 'en',
      preferredTheme: json['preferredTheme'] as String? ?? 'light',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'profileImageUrl': instance.profileImageUrl,
      'groupIds': instance.groupIds,
      'isActive': instance.isActive,
      'emailVerified': instance.emailVerified,
      'biometricEnabled': instance.biometricEnabled,
      'preferredLanguage': instance.preferredLanguage,
      'preferredTheme': instance.preferredTheme,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastSeen': instance.lastSeen?.toIso8601String(),
    };

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      adminId: json['adminId'] as String,
      contributionAmount: (json['contributionAmount'] as num).toDouble(),
      contributionFrequency: json['contributionFrequency'] as String,
      description: json['description'] as String,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      payoutOrder: (json['payoutOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentPayoutIndex: (json['currentPayoutIndex'] as num?)?.toInt() ?? 0,
      totalBalance: (json['totalBalance'] as num?)?.toDouble() ?? 0.0,
      totalContributed: (json['totalContributed'] as num?)?.toDouble() ?? 0.0,
      totalLoaned: (json['totalLoaned'] as num?)?.toDouble() ?? 0.0,
      groupProfitBalance:
          (json['groupProfitBalance'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'active',
      groupImageUrl: json['groupImageUrl'] as String?,
      inviteCode: json['inviteCode'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      nextContributionDate: json['nextContributionDate'] == null
          ? null
          : DateTime.parse(json['nextContributionDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      defaultInterestRate:
          (json['defaultInterestRate'] as num?)?.toDouble() ?? 5.0,
      maxRepaymentMonths: (json['maxRepaymentMonths'] as num?)?.toInt() ?? 12,
      loanPenaltyRate: (json['loanPenaltyRate'] as num?)?.toDouble() ?? 2.0,
      loanPenaltyGraceDays:
          (json['loanPenaltyGraceDays'] as num?)?.toInt() ?? 7,
      maxLoanMultiplier: (json['maxLoanMultiplier'] as num?)?.toDouble() ?? 3.0,
      minContributionsForLoan:
          (json['minContributionsForLoan'] as num?)?.toInt() ?? 1,
      lateFineAmount: (json['lateFineAmount'] as num?)?.toDouble() ?? 500.0,
      fineGraceDays: (json['fineGraceDays'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'adminId': instance.adminId,
      'contributionAmount': instance.contributionAmount,
      'contributionFrequency': instance.contributionFrequency,
      'description': instance.description,
      'memberIds': instance.memberIds,
      'payoutOrder': instance.payoutOrder,
      'currentPayoutIndex': instance.currentPayoutIndex,
      'totalBalance': instance.totalBalance,
      'totalContributed': instance.totalContributed,
      'totalLoaned': instance.totalLoaned,
      'groupProfitBalance': instance.groupProfitBalance,
      'status': instance.status,
      'groupImageUrl': instance.groupImageUrl,
      'inviteCode': instance.inviteCode,
      'startDate': instance.startDate?.toIso8601String(),
      'nextContributionDate': instance.nextContributionDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'defaultInterestRate': instance.defaultInterestRate,
      'maxRepaymentMonths': instance.maxRepaymentMonths,
      'loanPenaltyRate': instance.loanPenaltyRate,
      'loanPenaltyGraceDays': instance.loanPenaltyGraceDays,
      'maxLoanMultiplier': instance.maxLoanMultiplier,
      'minContributionsForLoan': instance.minContributionsForLoan,
      'lateFineAmount': instance.lateFineAmount,
      'fineGraceDays': instance.fineGraceDays,
    };

_$ContributionModelImpl _$$ContributionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ContributionModelImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      memberId: json['memberId'] as String,
      memberName: json['memberName'] as String,
      amount: (json['amount'] as num).toDouble(),
      contributionDate: DateTime.parse(json['contributionDate'] as String),
      status: json['status'] as String? ?? 'completed',
      receiptUrl: json['receiptUrl'] as String?,
      notes: json['notes'] as String?,
      confirmedBy: json['confirmedBy'] as String?,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ContributionModelImplToJson(
        _$ContributionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'amount': instance.amount,
      'contributionDate': instance.contributionDate.toIso8601String(),
      'status': instance.status,
      'receiptUrl': instance.receiptUrl,
      'notes': instance.notes,
      'confirmedBy': instance.confirmedBy,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$LoanModelImpl _$$LoanModelImplFromJson(Map<String, dynamic> json) =>
    _$LoanModelImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      borrowerId: json['borrowerId'] as String,
      borrowerName: json['borrowerName'] as String,
      amount: (json['amount'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      durationMonths: (json['durationMonths'] as num).toInt(),
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      status: json['status'] as String? ?? 'pending',
      amountRepaid: (json['amountRepaid'] as num?)?.toDouble() ?? 0.0,
      purpose: json['purpose'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      fullyRepaidAt: json['fullyRepaidAt'] == null
          ? null
          : DateTime.parse(json['fullyRepaidAt'] as String),
    );

Map<String, dynamic> _$$LoanModelImplToJson(_$LoanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'borrowerId': instance.borrowerId,
      'borrowerName': instance.borrowerName,
      'amount': instance.amount,
      'interestRate': instance.interestRate,
      'durationMonths': instance.durationMonths,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'status': instance.status,
      'amountRepaid': instance.amountRepaid,
      'purpose': instance.purpose,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'fullyRepaidAt': instance.fullyRepaidAt?.toIso8601String(),
    };

_$PayoutModelImpl _$$PayoutModelImplFromJson(Map<String, dynamic> json) =>
    _$PayoutModelImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      memberId: json['memberId'] as String,
      memberName: json['memberName'] as String,
      amount: (json['amount'] as num).toDouble(),
      roundNumber: (json['roundNumber'] as num).toInt(),
      status: json['status'] as String? ?? 'pending',
      scheduledDate: json['scheduledDate'] == null
          ? null
          : DateTime.parse(json['scheduledDate'] as String),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      processedBy: json['processedBy'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PayoutModelImplToJson(_$PayoutModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'amount': instance.amount,
      'roundNumber': instance.roundNumber,
      'status': instance.status,
      'scheduledDate': instance.scheduledDate?.toIso8601String(),
      'paidAt': instance.paidAt?.toIso8601String(),
      'processedBy': instance.processedBy,
      'notes': instance.notes,
    };

_$FineModelImpl _$$FineModelImplFromJson(Map<String, dynamic> json) =>
    _$FineModelImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      memberId: json['memberId'] as String,
      memberName: json['memberName'] as String,
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      status: json['status'] as String? ?? 'unpaid',
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
    );

Map<String, dynamic> _$$FineModelImplToJson(_$FineModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'amount': instance.amount,
      'reason': instance.reason,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'status': instance.status,
      'paidAt': instance.paidAt?.toIso8601String(),
    };

_$AppNotificationImpl _$$AppNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AppNotificationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      isRead: json['isRead'] as bool? ?? false,
      groupId: json['groupId'] as String?,
      actionId: json['actionId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AppNotificationImplToJson(
        _$AppNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'isRead': instance.isRead,
      'groupId': instance.groupId,
      'actionId': instance.actionId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$InvitationModelImpl _$$InvitationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationModelImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      groupName: json['groupName'] as String,
      invitedBy: json['invitedBy'] as String,
      inviteCode: json['inviteCode'] as String,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$InvitationModelImplToJson(
        _$InvitationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'invitedBy': instance.invitedBy,
      'inviteCode': instance.inviteCode,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

_$ChartDataPointImpl _$$ChartDataPointImplFromJson(Map<String, dynamic> json) =>
    _$ChartDataPointImpl(
      label: json['label'] as String,
      value: (json['value'] as num).toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ChartDataPointImplToJson(
        _$ChartDataPointImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'date': instance.date?.toIso8601String(),
    };

_$GroupBroadcastImpl _$$GroupBroadcastImplFromJson(Map<String, dynamic> json) =>
    _$GroupBroadcastImpl(
      id: json['id'] as String,
      groupId: json['groupId'] as String,
      groupName: json['groupName'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      reactions: (json['reactions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$GroupBroadcastImplToJson(
        _$GroupBroadcastImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'title': instance.title,
      'message': instance.message,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'reactions': instance.reactions,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
