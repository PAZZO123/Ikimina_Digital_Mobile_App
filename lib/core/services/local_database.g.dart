// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $LocalGroupsTable extends LocalGroups
    with TableInfo<$LocalGroupsTable, LocalGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _adminIdMeta =
      const VerificationMeta('adminId');
  @override
  late final GeneratedColumn<String> adminId = GeneratedColumn<String>(
      'admin_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contributionAmountMeta =
      const VerificationMeta('contributionAmount');
  @override
  late final GeneratedColumn<double> contributionAmount =
      GeneratedColumn<double>('contribution_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _contributionFrequencyMeta =
      const VerificationMeta('contributionFrequency');
  @override
  late final GeneratedColumn<String> contributionFrequency =
      GeneratedColumn<String>('contribution_frequency', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalBalanceMeta =
      const VerificationMeta('totalBalance');
  @override
  late final GeneratedColumn<double> totalBalance = GeneratedColumn<double>(
      'total_balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalContributedMeta =
      const VerificationMeta('totalContributed');
  @override
  late final GeneratedColumn<double> totalContributed = GeneratedColumn<double>(
      'total_contributed', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalLoanedMeta =
      const VerificationMeta('totalLoaned');
  @override
  late final GeneratedColumn<double> totalLoaned = GeneratedColumn<double>(
      'total_loaned', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _memberIdsMeta =
      const VerificationMeta('memberIds');
  @override
  late final GeneratedColumn<String> memberIds = GeneratedColumn<String>(
      'member_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payoutOrderMeta =
      const VerificationMeta('payoutOrder');
  @override
  late final GeneratedColumn<String> payoutOrder = GeneratedColumn<String>(
      'payout_order', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPayoutIndexMeta =
      const VerificationMeta('currentPayoutIndex');
  @override
  late final GeneratedColumn<int> currentPayoutIndex = GeneratedColumn<int>(
      'current_payout_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _inviteCodeMeta =
      const VerificationMeta('inviteCode');
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
      'invite_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        adminId,
        description,
        contributionAmount,
        contributionFrequency,
        status,
        totalBalance,
        totalContributed,
        totalLoaned,
        memberIds,
        payoutOrder,
        currentPayoutIndex,
        inviteCode,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_groups';
  @override
  VerificationContext validateIntegrity(Insertable<LocalGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('admin_id')) {
      context.handle(_adminIdMeta,
          adminId.isAcceptableOrUnknown(data['admin_id']!, _adminIdMeta));
    } else if (isInserting) {
      context.missing(_adminIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('contribution_amount')) {
      context.handle(
          _contributionAmountMeta,
          contributionAmount.isAcceptableOrUnknown(
              data['contribution_amount']!, _contributionAmountMeta));
    } else if (isInserting) {
      context.missing(_contributionAmountMeta);
    }
    if (data.containsKey('contribution_frequency')) {
      context.handle(
          _contributionFrequencyMeta,
          contributionFrequency.isAcceptableOrUnknown(
              data['contribution_frequency']!, _contributionFrequencyMeta));
    } else if (isInserting) {
      context.missing(_contributionFrequencyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('total_balance')) {
      context.handle(
          _totalBalanceMeta,
          totalBalance.isAcceptableOrUnknown(
              data['total_balance']!, _totalBalanceMeta));
    }
    if (data.containsKey('total_contributed')) {
      context.handle(
          _totalContributedMeta,
          totalContributed.isAcceptableOrUnknown(
              data['total_contributed']!, _totalContributedMeta));
    }
    if (data.containsKey('total_loaned')) {
      context.handle(
          _totalLoanedMeta,
          totalLoaned.isAcceptableOrUnknown(
              data['total_loaned']!, _totalLoanedMeta));
    }
    if (data.containsKey('member_ids')) {
      context.handle(_memberIdsMeta,
          memberIds.isAcceptableOrUnknown(data['member_ids']!, _memberIdsMeta));
    } else if (isInserting) {
      context.missing(_memberIdsMeta);
    }
    if (data.containsKey('payout_order')) {
      context.handle(
          _payoutOrderMeta,
          payoutOrder.isAcceptableOrUnknown(
              data['payout_order']!, _payoutOrderMeta));
    } else if (isInserting) {
      context.missing(_payoutOrderMeta);
    }
    if (data.containsKey('current_payout_index')) {
      context.handle(
          _currentPayoutIndexMeta,
          currentPayoutIndex.isAcceptableOrUnknown(
              data['current_payout_index']!, _currentPayoutIndexMeta));
    }
    if (data.containsKey('invite_code')) {
      context.handle(
          _inviteCodeMeta,
          inviteCode.isAcceptableOrUnknown(
              data['invite_code']!, _inviteCodeMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      adminId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}admin_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      contributionAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}contribution_amount'])!,
      contributionFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}contribution_frequency'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      totalBalance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_balance'])!,
      totalContributed: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_contributed'])!,
      totalLoaned: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_loaned'])!,
      memberIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_ids'])!,
      payoutOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payout_order'])!,
      currentPayoutIndex: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_payout_index'])!,
      inviteCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invite_code']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalGroupsTable createAlias(String alias) {
    return $LocalGroupsTable(attachedDatabase, alias);
  }
}

class LocalGroup extends DataClass implements Insertable<LocalGroup> {
  final String id;
  final String name;
  final String adminId;
  final String description;
  final double contributionAmount;
  final String contributionFrequency;
  final String status;
  final double totalBalance;
  final double totalContributed;
  final double totalLoaned;
  final String memberIds;
  final String payoutOrder;
  final int currentPayoutIndex;
  final String? inviteCode;
  final int updatedAt;
  const LocalGroup(
      {required this.id,
      required this.name,
      required this.adminId,
      required this.description,
      required this.contributionAmount,
      required this.contributionFrequency,
      required this.status,
      required this.totalBalance,
      required this.totalContributed,
      required this.totalLoaned,
      required this.memberIds,
      required this.payoutOrder,
      required this.currentPayoutIndex,
      this.inviteCode,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['admin_id'] = Variable<String>(adminId);
    map['description'] = Variable<String>(description);
    map['contribution_amount'] = Variable<double>(contributionAmount);
    map['contribution_frequency'] = Variable<String>(contributionFrequency);
    map['status'] = Variable<String>(status);
    map['total_balance'] = Variable<double>(totalBalance);
    map['total_contributed'] = Variable<double>(totalContributed);
    map['total_loaned'] = Variable<double>(totalLoaned);
    map['member_ids'] = Variable<String>(memberIds);
    map['payout_order'] = Variable<String>(payoutOrder);
    map['current_payout_index'] = Variable<int>(currentPayoutIndex);
    if (!nullToAbsent || inviteCode != null) {
      map['invite_code'] = Variable<String>(inviteCode);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  LocalGroupsCompanion toCompanion(bool nullToAbsent) {
    return LocalGroupsCompanion(
      id: Value(id),
      name: Value(name),
      adminId: Value(adminId),
      description: Value(description),
      contributionAmount: Value(contributionAmount),
      contributionFrequency: Value(contributionFrequency),
      status: Value(status),
      totalBalance: Value(totalBalance),
      totalContributed: Value(totalContributed),
      totalLoaned: Value(totalLoaned),
      memberIds: Value(memberIds),
      payoutOrder: Value(payoutOrder),
      currentPayoutIndex: Value(currentPayoutIndex),
      inviteCode: inviteCode == null && nullToAbsent
          ? const Value.absent()
          : Value(inviteCode),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalGroup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      adminId: serializer.fromJson<String>(json['adminId']),
      description: serializer.fromJson<String>(json['description']),
      contributionAmount:
          serializer.fromJson<double>(json['contributionAmount']),
      contributionFrequency:
          serializer.fromJson<String>(json['contributionFrequency']),
      status: serializer.fromJson<String>(json['status']),
      totalBalance: serializer.fromJson<double>(json['totalBalance']),
      totalContributed: serializer.fromJson<double>(json['totalContributed']),
      totalLoaned: serializer.fromJson<double>(json['totalLoaned']),
      memberIds: serializer.fromJson<String>(json['memberIds']),
      payoutOrder: serializer.fromJson<String>(json['payoutOrder']),
      currentPayoutIndex: serializer.fromJson<int>(json['currentPayoutIndex']),
      inviteCode: serializer.fromJson<String?>(json['inviteCode']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'adminId': serializer.toJson<String>(adminId),
      'description': serializer.toJson<String>(description),
      'contributionAmount': serializer.toJson<double>(contributionAmount),
      'contributionFrequency': serializer.toJson<String>(contributionFrequency),
      'status': serializer.toJson<String>(status),
      'totalBalance': serializer.toJson<double>(totalBalance),
      'totalContributed': serializer.toJson<double>(totalContributed),
      'totalLoaned': serializer.toJson<double>(totalLoaned),
      'memberIds': serializer.toJson<String>(memberIds),
      'payoutOrder': serializer.toJson<String>(payoutOrder),
      'currentPayoutIndex': serializer.toJson<int>(currentPayoutIndex),
      'inviteCode': serializer.toJson<String?>(inviteCode),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  LocalGroup copyWith(
          {String? id,
          String? name,
          String? adminId,
          String? description,
          double? contributionAmount,
          String? contributionFrequency,
          String? status,
          double? totalBalance,
          double? totalContributed,
          double? totalLoaned,
          String? memberIds,
          String? payoutOrder,
          int? currentPayoutIndex,
          Value<String?> inviteCode = const Value.absent(),
          int? updatedAt}) =>
      LocalGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        adminId: adminId ?? this.adminId,
        description: description ?? this.description,
        contributionAmount: contributionAmount ?? this.contributionAmount,
        contributionFrequency:
            contributionFrequency ?? this.contributionFrequency,
        status: status ?? this.status,
        totalBalance: totalBalance ?? this.totalBalance,
        totalContributed: totalContributed ?? this.totalContributed,
        totalLoaned: totalLoaned ?? this.totalLoaned,
        memberIds: memberIds ?? this.memberIds,
        payoutOrder: payoutOrder ?? this.payoutOrder,
        currentPayoutIndex: currentPayoutIndex ?? this.currentPayoutIndex,
        inviteCode: inviteCode.present ? inviteCode.value : this.inviteCode,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalGroup copyWithCompanion(LocalGroupsCompanion data) {
    return LocalGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      adminId: data.adminId.present ? data.adminId.value : this.adminId,
      description:
          data.description.present ? data.description.value : this.description,
      contributionAmount: data.contributionAmount.present
          ? data.contributionAmount.value
          : this.contributionAmount,
      contributionFrequency: data.contributionFrequency.present
          ? data.contributionFrequency.value
          : this.contributionFrequency,
      status: data.status.present ? data.status.value : this.status,
      totalBalance: data.totalBalance.present
          ? data.totalBalance.value
          : this.totalBalance,
      totalContributed: data.totalContributed.present
          ? data.totalContributed.value
          : this.totalContributed,
      totalLoaned:
          data.totalLoaned.present ? data.totalLoaned.value : this.totalLoaned,
      memberIds: data.memberIds.present ? data.memberIds.value : this.memberIds,
      payoutOrder:
          data.payoutOrder.present ? data.payoutOrder.value : this.payoutOrder,
      currentPayoutIndex: data.currentPayoutIndex.present
          ? data.currentPayoutIndex.value
          : this.currentPayoutIndex,
      inviteCode:
          data.inviteCode.present ? data.inviteCode.value : this.inviteCode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('adminId: $adminId, ')
          ..write('description: $description, ')
          ..write('contributionAmount: $contributionAmount, ')
          ..write('contributionFrequency: $contributionFrequency, ')
          ..write('status: $status, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('totalContributed: $totalContributed, ')
          ..write('totalLoaned: $totalLoaned, ')
          ..write('memberIds: $memberIds, ')
          ..write('payoutOrder: $payoutOrder, ')
          ..write('currentPayoutIndex: $currentPayoutIndex, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      adminId,
      description,
      contributionAmount,
      contributionFrequency,
      status,
      totalBalance,
      totalContributed,
      totalLoaned,
      memberIds,
      payoutOrder,
      currentPayoutIndex,
      inviteCode,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.adminId == this.adminId &&
          other.description == this.description &&
          other.contributionAmount == this.contributionAmount &&
          other.contributionFrequency == this.contributionFrequency &&
          other.status == this.status &&
          other.totalBalance == this.totalBalance &&
          other.totalContributed == this.totalContributed &&
          other.totalLoaned == this.totalLoaned &&
          other.memberIds == this.memberIds &&
          other.payoutOrder == this.payoutOrder &&
          other.currentPayoutIndex == this.currentPayoutIndex &&
          other.inviteCode == this.inviteCode &&
          other.updatedAt == this.updatedAt);
}

class LocalGroupsCompanion extends UpdateCompanion<LocalGroup> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> adminId;
  final Value<String> description;
  final Value<double> contributionAmount;
  final Value<String> contributionFrequency;
  final Value<String> status;
  final Value<double> totalBalance;
  final Value<double> totalContributed;
  final Value<double> totalLoaned;
  final Value<String> memberIds;
  final Value<String> payoutOrder;
  final Value<int> currentPayoutIndex;
  final Value<String?> inviteCode;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const LocalGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.adminId = const Value.absent(),
    this.description = const Value.absent(),
    this.contributionAmount = const Value.absent(),
    this.contributionFrequency = const Value.absent(),
    this.status = const Value.absent(),
    this.totalBalance = const Value.absent(),
    this.totalContributed = const Value.absent(),
    this.totalLoaned = const Value.absent(),
    this.memberIds = const Value.absent(),
    this.payoutOrder = const Value.absent(),
    this.currentPayoutIndex = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalGroupsCompanion.insert({
    required String id,
    required String name,
    required String adminId,
    required String description,
    required double contributionAmount,
    required String contributionFrequency,
    required String status,
    this.totalBalance = const Value.absent(),
    this.totalContributed = const Value.absent(),
    this.totalLoaned = const Value.absent(),
    required String memberIds,
    required String payoutOrder,
    this.currentPayoutIndex = const Value.absent(),
    this.inviteCode = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        adminId = Value(adminId),
        description = Value(description),
        contributionAmount = Value(contributionAmount),
        contributionFrequency = Value(contributionFrequency),
        status = Value(status),
        memberIds = Value(memberIds),
        payoutOrder = Value(payoutOrder),
        updatedAt = Value(updatedAt);
  static Insertable<LocalGroup> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? adminId,
    Expression<String>? description,
    Expression<double>? contributionAmount,
    Expression<String>? contributionFrequency,
    Expression<String>? status,
    Expression<double>? totalBalance,
    Expression<double>? totalContributed,
    Expression<double>? totalLoaned,
    Expression<String>? memberIds,
    Expression<String>? payoutOrder,
    Expression<int>? currentPayoutIndex,
    Expression<String>? inviteCode,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (adminId != null) 'admin_id': adminId,
      if (description != null) 'description': description,
      if (contributionAmount != null) 'contribution_amount': contributionAmount,
      if (contributionFrequency != null)
        'contribution_frequency': contributionFrequency,
      if (status != null) 'status': status,
      if (totalBalance != null) 'total_balance': totalBalance,
      if (totalContributed != null) 'total_contributed': totalContributed,
      if (totalLoaned != null) 'total_loaned': totalLoaned,
      if (memberIds != null) 'member_ids': memberIds,
      if (payoutOrder != null) 'payout_order': payoutOrder,
      if (currentPayoutIndex != null)
        'current_payout_index': currentPayoutIndex,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalGroupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? adminId,
      Value<String>? description,
      Value<double>? contributionAmount,
      Value<String>? contributionFrequency,
      Value<String>? status,
      Value<double>? totalBalance,
      Value<double>? totalContributed,
      Value<double>? totalLoaned,
      Value<String>? memberIds,
      Value<String>? payoutOrder,
      Value<int>? currentPayoutIndex,
      Value<String?>? inviteCode,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return LocalGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      adminId: adminId ?? this.adminId,
      description: description ?? this.description,
      contributionAmount: contributionAmount ?? this.contributionAmount,
      contributionFrequency:
          contributionFrequency ?? this.contributionFrequency,
      status: status ?? this.status,
      totalBalance: totalBalance ?? this.totalBalance,
      totalContributed: totalContributed ?? this.totalContributed,
      totalLoaned: totalLoaned ?? this.totalLoaned,
      memberIds: memberIds ?? this.memberIds,
      payoutOrder: payoutOrder ?? this.payoutOrder,
      currentPayoutIndex: currentPayoutIndex ?? this.currentPayoutIndex,
      inviteCode: inviteCode ?? this.inviteCode,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (adminId.present) {
      map['admin_id'] = Variable<String>(adminId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (contributionAmount.present) {
      map['contribution_amount'] = Variable<double>(contributionAmount.value);
    }
    if (contributionFrequency.present) {
      map['contribution_frequency'] =
          Variable<String>(contributionFrequency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalBalance.present) {
      map['total_balance'] = Variable<double>(totalBalance.value);
    }
    if (totalContributed.present) {
      map['total_contributed'] = Variable<double>(totalContributed.value);
    }
    if (totalLoaned.present) {
      map['total_loaned'] = Variable<double>(totalLoaned.value);
    }
    if (memberIds.present) {
      map['member_ids'] = Variable<String>(memberIds.value);
    }
    if (payoutOrder.present) {
      map['payout_order'] = Variable<String>(payoutOrder.value);
    }
    if (currentPayoutIndex.present) {
      map['current_payout_index'] = Variable<int>(currentPayoutIndex.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('adminId: $adminId, ')
          ..write('description: $description, ')
          ..write('contributionAmount: $contributionAmount, ')
          ..write('contributionFrequency: $contributionFrequency, ')
          ..write('status: $status, ')
          ..write('totalBalance: $totalBalance, ')
          ..write('totalContributed: $totalContributed, ')
          ..write('totalLoaned: $totalLoaned, ')
          ..write('memberIds: $memberIds, ')
          ..write('payoutOrder: $payoutOrder, ')
          ..write('currentPayoutIndex: $currentPayoutIndex, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalContributionsTable extends LocalContributions
    with TableInfo<$LocalContributionsTable, LocalContribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memberIdMeta =
      const VerificationMeta('memberId');
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
      'member_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memberNameMeta =
      const VerificationMeta('memberName');
  @override
  late final GeneratedColumn<String> memberName = GeneratedColumn<String>(
      'member_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _contributionDateMeta =
      const VerificationMeta('contributionDate');
  @override
  late final GeneratedColumn<int> contributionDate = GeneratedColumn<int>(
      'contribution_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        memberId,
        memberName,
        amount,
        contributionDate,
        status,
        notes,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_contributions';
  @override
  VerificationContext validateIntegrity(Insertable<LocalContribution> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(_memberIdMeta,
          memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta));
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('member_name')) {
      context.handle(
          _memberNameMeta,
          memberName.isAcceptableOrUnknown(
              data['member_name']!, _memberNameMeta));
    } else if (isInserting) {
      context.missing(_memberNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('contribution_date')) {
      context.handle(
          _contributionDateMeta,
          contributionDate.isAcceptableOrUnknown(
              data['contribution_date']!, _contributionDateMeta));
    } else if (isInserting) {
      context.missing(_contributionDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalContribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalContribution(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      memberId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_id'])!,
      memberName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      contributionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contribution_date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalContributionsTable createAlias(String alias) {
    return $LocalContributionsTable(attachedDatabase, alias);
  }
}

class LocalContribution extends DataClass
    implements Insertable<LocalContribution> {
  final String id;
  final String groupId;
  final String memberId;
  final String memberName;
  final double amount;
  final int contributionDate;
  final String status;
  final String? notes;
  final int updatedAt;
  const LocalContribution(
      {required this.id,
      required this.groupId,
      required this.memberId,
      required this.memberName,
      required this.amount,
      required this.contributionDate,
      required this.status,
      this.notes,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['member_id'] = Variable<String>(memberId);
    map['member_name'] = Variable<String>(memberName);
    map['amount'] = Variable<double>(amount);
    map['contribution_date'] = Variable<int>(contributionDate);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  LocalContributionsCompanion toCompanion(bool nullToAbsent) {
    return LocalContributionsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      memberId: Value(memberId),
      memberName: Value(memberName),
      amount: Value(amount),
      contributionDate: Value(contributionDate),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalContribution.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalContribution(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      memberName: serializer.fromJson<String>(json['memberName']),
      amount: serializer.fromJson<double>(json['amount']),
      contributionDate: serializer.fromJson<int>(json['contributionDate']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'memberId': serializer.toJson<String>(memberId),
      'memberName': serializer.toJson<String>(memberName),
      'amount': serializer.toJson<double>(amount),
      'contributionDate': serializer.toJson<int>(contributionDate),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  LocalContribution copyWith(
          {String? id,
          String? groupId,
          String? memberId,
          String? memberName,
          double? amount,
          int? contributionDate,
          String? status,
          Value<String?> notes = const Value.absent(),
          int? updatedAt}) =>
      LocalContribution(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        memberId: memberId ?? this.memberId,
        memberName: memberName ?? this.memberName,
        amount: amount ?? this.amount,
        contributionDate: contributionDate ?? this.contributionDate,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalContribution copyWithCompanion(LocalContributionsCompanion data) {
    return LocalContribution(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      memberName:
          data.memberName.present ? data.memberName.value : this.memberName,
      amount: data.amount.present ? data.amount.value : this.amount,
      contributionDate: data.contributionDate.present
          ? data.contributionDate.value
          : this.contributionDate,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalContribution(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('memberId: $memberId, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('contributionDate: $contributionDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, memberId, memberName, amount,
      contributionDate, status, notes, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalContribution &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.memberId == this.memberId &&
          other.memberName == this.memberName &&
          other.amount == this.amount &&
          other.contributionDate == this.contributionDate &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.updatedAt == this.updatedAt);
}

class LocalContributionsCompanion extends UpdateCompanion<LocalContribution> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> memberId;
  final Value<String> memberName;
  final Value<double> amount;
  final Value<int> contributionDate;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const LocalContributionsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.memberName = const Value.absent(),
    this.amount = const Value.absent(),
    this.contributionDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalContributionsCompanion.insert({
    required String id,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required int contributionDate,
    required String status,
    this.notes = const Value.absent(),
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        memberId = Value(memberId),
        memberName = Value(memberName),
        amount = Value(amount),
        contributionDate = Value(contributionDate),
        status = Value(status),
        updatedAt = Value(updatedAt);
  static Insertable<LocalContribution> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? memberId,
    Expression<String>? memberName,
    Expression<double>? amount,
    Expression<int>? contributionDate,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (memberId != null) 'member_id': memberId,
      if (memberName != null) 'member_name': memberName,
      if (amount != null) 'amount': amount,
      if (contributionDate != null) 'contribution_date': contributionDate,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalContributionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? memberId,
      Value<String>? memberName,
      Value<double>? amount,
      Value<int>? contributionDate,
      Value<String>? status,
      Value<String?>? notes,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return LocalContributionsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      amount: amount ?? this.amount,
      contributionDate: contributionDate ?? this.contributionDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (memberName.present) {
      map['member_name'] = Variable<String>(memberName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (contributionDate.present) {
      map['contribution_date'] = Variable<int>(contributionDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalContributionsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('memberId: $memberId, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('contributionDate: $contributionDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalLoansTable extends LocalLoans
    with TableInfo<$LocalLoansTable, LocalLoan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalLoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _borrowerIdMeta =
      const VerificationMeta('borrowerId');
  @override
  late final GeneratedColumn<String> borrowerId = GeneratedColumn<String>(
      'borrower_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _borrowerNameMeta =
      const VerificationMeta('borrowerName');
  @override
  late final GeneratedColumn<String> borrowerName = GeneratedColumn<String>(
      'borrower_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _interestRateMeta =
      const VerificationMeta('interestRate');
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
      'interest_rate', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _durationMonthsMeta =
      const VerificationMeta('durationMonths');
  @override
  late final GeneratedColumn<int> durationMonths = GeneratedColumn<int>(
      'duration_months', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountRepaidMeta =
      const VerificationMeta('amountRepaid');
  @override
  late final GeneratedColumn<double> amountRepaid = GeneratedColumn<double>(
      'amount_repaid', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _purposeMeta =
      const VerificationMeta('purpose');
  @override
  late final GeneratedColumn<String> purpose = GeneratedColumn<String>(
      'purpose', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requestedAtMeta =
      const VerificationMeta('requestedAt');
  @override
  late final GeneratedColumn<int> requestedAt = GeneratedColumn<int>(
      'requested_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        borrowerId,
        borrowerName,
        amount,
        interestRate,
        durationMonths,
        status,
        amountRepaid,
        purpose,
        requestedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_loans';
  @override
  VerificationContext validateIntegrity(Insertable<LocalLoan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('borrower_id')) {
      context.handle(
          _borrowerIdMeta,
          borrowerId.isAcceptableOrUnknown(
              data['borrower_id']!, _borrowerIdMeta));
    } else if (isInserting) {
      context.missing(_borrowerIdMeta);
    }
    if (data.containsKey('borrower_name')) {
      context.handle(
          _borrowerNameMeta,
          borrowerName.isAcceptableOrUnknown(
              data['borrower_name']!, _borrowerNameMeta));
    } else if (isInserting) {
      context.missing(_borrowerNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
          _interestRateMeta,
          interestRate.isAcceptableOrUnknown(
              data['interest_rate']!, _interestRateMeta));
    } else if (isInserting) {
      context.missing(_interestRateMeta);
    }
    if (data.containsKey('duration_months')) {
      context.handle(
          _durationMonthsMeta,
          durationMonths.isAcceptableOrUnknown(
              data['duration_months']!, _durationMonthsMeta));
    } else if (isInserting) {
      context.missing(_durationMonthsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('amount_repaid')) {
      context.handle(
          _amountRepaidMeta,
          amountRepaid.isAcceptableOrUnknown(
              data['amount_repaid']!, _amountRepaidMeta));
    }
    if (data.containsKey('purpose')) {
      context.handle(_purposeMeta,
          purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta));
    }
    if (data.containsKey('requested_at')) {
      context.handle(
          _requestedAtMeta,
          requestedAt.isAcceptableOrUnknown(
              data['requested_at']!, _requestedAtMeta));
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalLoan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalLoan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      borrowerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}borrower_id'])!,
      borrowerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}borrower_name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      interestRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}interest_rate'])!,
      durationMonths: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_months'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      amountRepaid: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_repaid'])!,
      purpose: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purpose']),
      requestedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}requested_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalLoansTable createAlias(String alias) {
    return $LocalLoansTable(attachedDatabase, alias);
  }
}

class LocalLoan extends DataClass implements Insertable<LocalLoan> {
  final String id;
  final String groupId;
  final String borrowerId;
  final String borrowerName;
  final double amount;
  final double interestRate;
  final int durationMonths;
  final String status;
  final double amountRepaid;
  final String? purpose;
  final int requestedAt;
  final int updatedAt;
  const LocalLoan(
      {required this.id,
      required this.groupId,
      required this.borrowerId,
      required this.borrowerName,
      required this.amount,
      required this.interestRate,
      required this.durationMonths,
      required this.status,
      required this.amountRepaid,
      this.purpose,
      required this.requestedAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['borrower_id'] = Variable<String>(borrowerId);
    map['borrower_name'] = Variable<String>(borrowerName);
    map['amount'] = Variable<double>(amount);
    map['interest_rate'] = Variable<double>(interestRate);
    map['duration_months'] = Variable<int>(durationMonths);
    map['status'] = Variable<String>(status);
    map['amount_repaid'] = Variable<double>(amountRepaid);
    if (!nullToAbsent || purpose != null) {
      map['purpose'] = Variable<String>(purpose);
    }
    map['requested_at'] = Variable<int>(requestedAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  LocalLoansCompanion toCompanion(bool nullToAbsent) {
    return LocalLoansCompanion(
      id: Value(id),
      groupId: Value(groupId),
      borrowerId: Value(borrowerId),
      borrowerName: Value(borrowerName),
      amount: Value(amount),
      interestRate: Value(interestRate),
      durationMonths: Value(durationMonths),
      status: Value(status),
      amountRepaid: Value(amountRepaid),
      purpose: purpose == null && nullToAbsent
          ? const Value.absent()
          : Value(purpose),
      requestedAt: Value(requestedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalLoan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalLoan(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      borrowerId: serializer.fromJson<String>(json['borrowerId']),
      borrowerName: serializer.fromJson<String>(json['borrowerName']),
      amount: serializer.fromJson<double>(json['amount']),
      interestRate: serializer.fromJson<double>(json['interestRate']),
      durationMonths: serializer.fromJson<int>(json['durationMonths']),
      status: serializer.fromJson<String>(json['status']),
      amountRepaid: serializer.fromJson<double>(json['amountRepaid']),
      purpose: serializer.fromJson<String?>(json['purpose']),
      requestedAt: serializer.fromJson<int>(json['requestedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'borrowerId': serializer.toJson<String>(borrowerId),
      'borrowerName': serializer.toJson<String>(borrowerName),
      'amount': serializer.toJson<double>(amount),
      'interestRate': serializer.toJson<double>(interestRate),
      'durationMonths': serializer.toJson<int>(durationMonths),
      'status': serializer.toJson<String>(status),
      'amountRepaid': serializer.toJson<double>(amountRepaid),
      'purpose': serializer.toJson<String?>(purpose),
      'requestedAt': serializer.toJson<int>(requestedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  LocalLoan copyWith(
          {String? id,
          String? groupId,
          String? borrowerId,
          String? borrowerName,
          double? amount,
          double? interestRate,
          int? durationMonths,
          String? status,
          double? amountRepaid,
          Value<String?> purpose = const Value.absent(),
          int? requestedAt,
          int? updatedAt}) =>
      LocalLoan(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        borrowerId: borrowerId ?? this.borrowerId,
        borrowerName: borrowerName ?? this.borrowerName,
        amount: amount ?? this.amount,
        interestRate: interestRate ?? this.interestRate,
        durationMonths: durationMonths ?? this.durationMonths,
        status: status ?? this.status,
        amountRepaid: amountRepaid ?? this.amountRepaid,
        purpose: purpose.present ? purpose.value : this.purpose,
        requestedAt: requestedAt ?? this.requestedAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalLoan copyWithCompanion(LocalLoansCompanion data) {
    return LocalLoan(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      borrowerId:
          data.borrowerId.present ? data.borrowerId.value : this.borrowerId,
      borrowerName: data.borrowerName.present
          ? data.borrowerName.value
          : this.borrowerName,
      amount: data.amount.present ? data.amount.value : this.amount,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      durationMonths: data.durationMonths.present
          ? data.durationMonths.value
          : this.durationMonths,
      status: data.status.present ? data.status.value : this.status,
      amountRepaid: data.amountRepaid.present
          ? data.amountRepaid.value
          : this.amountRepaid,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      requestedAt:
          data.requestedAt.present ? data.requestedAt.value : this.requestedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalLoan(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('borrowerId: $borrowerId, ')
          ..write('borrowerName: $borrowerName, ')
          ..write('amount: $amount, ')
          ..write('interestRate: $interestRate, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('status: $status, ')
          ..write('amountRepaid: $amountRepaid, ')
          ..write('purpose: $purpose, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      groupId,
      borrowerId,
      borrowerName,
      amount,
      interestRate,
      durationMonths,
      status,
      amountRepaid,
      purpose,
      requestedAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalLoan &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.borrowerId == this.borrowerId &&
          other.borrowerName == this.borrowerName &&
          other.amount == this.amount &&
          other.interestRate == this.interestRate &&
          other.durationMonths == this.durationMonths &&
          other.status == this.status &&
          other.amountRepaid == this.amountRepaid &&
          other.purpose == this.purpose &&
          other.requestedAt == this.requestedAt &&
          other.updatedAt == this.updatedAt);
}

class LocalLoansCompanion extends UpdateCompanion<LocalLoan> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> borrowerId;
  final Value<String> borrowerName;
  final Value<double> amount;
  final Value<double> interestRate;
  final Value<int> durationMonths;
  final Value<String> status;
  final Value<double> amountRepaid;
  final Value<String?> purpose;
  final Value<int> requestedAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const LocalLoansCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.borrowerId = const Value.absent(),
    this.borrowerName = const Value.absent(),
    this.amount = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.durationMonths = const Value.absent(),
    this.status = const Value.absent(),
    this.amountRepaid = const Value.absent(),
    this.purpose = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalLoansCompanion.insert({
    required String id,
    required String groupId,
    required String borrowerId,
    required String borrowerName,
    required double amount,
    required double interestRate,
    required int durationMonths,
    required String status,
    this.amountRepaid = const Value.absent(),
    this.purpose = const Value.absent(),
    required int requestedAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        borrowerId = Value(borrowerId),
        borrowerName = Value(borrowerName),
        amount = Value(amount),
        interestRate = Value(interestRate),
        durationMonths = Value(durationMonths),
        status = Value(status),
        requestedAt = Value(requestedAt),
        updatedAt = Value(updatedAt);
  static Insertable<LocalLoan> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? borrowerId,
    Expression<String>? borrowerName,
    Expression<double>? amount,
    Expression<double>? interestRate,
    Expression<int>? durationMonths,
    Expression<String>? status,
    Expression<double>? amountRepaid,
    Expression<String>? purpose,
    Expression<int>? requestedAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (borrowerId != null) 'borrower_id': borrowerId,
      if (borrowerName != null) 'borrower_name': borrowerName,
      if (amount != null) 'amount': amount,
      if (interestRate != null) 'interest_rate': interestRate,
      if (durationMonths != null) 'duration_months': durationMonths,
      if (status != null) 'status': status,
      if (amountRepaid != null) 'amount_repaid': amountRepaid,
      if (purpose != null) 'purpose': purpose,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalLoansCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? borrowerId,
      Value<String>? borrowerName,
      Value<double>? amount,
      Value<double>? interestRate,
      Value<int>? durationMonths,
      Value<String>? status,
      Value<double>? amountRepaid,
      Value<String?>? purpose,
      Value<int>? requestedAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return LocalLoansCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      borrowerId: borrowerId ?? this.borrowerId,
      borrowerName: borrowerName ?? this.borrowerName,
      amount: amount ?? this.amount,
      interestRate: interestRate ?? this.interestRate,
      durationMonths: durationMonths ?? this.durationMonths,
      status: status ?? this.status,
      amountRepaid: amountRepaid ?? this.amountRepaid,
      purpose: purpose ?? this.purpose,
      requestedAt: requestedAt ?? this.requestedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (borrowerId.present) {
      map['borrower_id'] = Variable<String>(borrowerId.value);
    }
    if (borrowerName.present) {
      map['borrower_name'] = Variable<String>(borrowerName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (durationMonths.present) {
      map['duration_months'] = Variable<int>(durationMonths.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (amountRepaid.present) {
      map['amount_repaid'] = Variable<double>(amountRepaid.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<int>(requestedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalLoansCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('borrowerId: $borrowerId, ')
          ..write('borrowerName: $borrowerName, ')
          ..write('amount: $amount, ')
          ..write('interestRate: $interestRate, ')
          ..write('durationMonths: $durationMonths, ')
          ..write('status: $status, ')
          ..write('amountRepaid: $amountRepaid, ')
          ..write('purpose: $purpose, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalFinesTable extends LocalFines
    with TableInfo<$LocalFinesTable, LocalFine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalFinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memberIdMeta =
      const VerificationMeta('memberId');
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
      'member_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _memberNameMeta =
      const VerificationMeta('memberName');
  @override
  late final GeneratedColumn<String> memberName = GeneratedColumn<String>(
      'member_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _issuedAtMeta =
      const VerificationMeta('issuedAt');
  @override
  late final GeneratedColumn<int> issuedAt = GeneratedColumn<int>(
      'issued_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        memberId,
        memberName,
        amount,
        reason,
        status,
        issuedAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_fines';
  @override
  VerificationContext validateIntegrity(Insertable<LocalFine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(_memberIdMeta,
          memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta));
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('member_name')) {
      context.handle(
          _memberNameMeta,
          memberName.isAcceptableOrUnknown(
              data['member_name']!, _memberNameMeta));
    } else if (isInserting) {
      context.missing(_memberNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(_issuedAtMeta,
          issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta));
    } else if (isInserting) {
      context.missing(_issuedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalFine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalFine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      memberId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_id'])!,
      memberName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}member_name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      issuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}issued_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalFinesTable createAlias(String alias) {
    return $LocalFinesTable(attachedDatabase, alias);
  }
}

class LocalFine extends DataClass implements Insertable<LocalFine> {
  final String id;
  final String groupId;
  final String memberId;
  final String memberName;
  final double amount;
  final String reason;
  final String status;
  final int issuedAt;
  final int updatedAt;
  const LocalFine(
      {required this.id,
      required this.groupId,
      required this.memberId,
      required this.memberName,
      required this.amount,
      required this.reason,
      required this.status,
      required this.issuedAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['member_id'] = Variable<String>(memberId);
    map['member_name'] = Variable<String>(memberName);
    map['amount'] = Variable<double>(amount);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    map['issued_at'] = Variable<int>(issuedAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  LocalFinesCompanion toCompanion(bool nullToAbsent) {
    return LocalFinesCompanion(
      id: Value(id),
      groupId: Value(groupId),
      memberId: Value(memberId),
      memberName: Value(memberName),
      amount: Value(amount),
      reason: Value(reason),
      status: Value(status),
      issuedAt: Value(issuedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalFine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalFine(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      memberName: serializer.fromJson<String>(json['memberName']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      issuedAt: serializer.fromJson<int>(json['issuedAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'memberId': serializer.toJson<String>(memberId),
      'memberName': serializer.toJson<String>(memberName),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'issuedAt': serializer.toJson<int>(issuedAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  LocalFine copyWith(
          {String? id,
          String? groupId,
          String? memberId,
          String? memberName,
          double? amount,
          String? reason,
          String? status,
          int? issuedAt,
          int? updatedAt}) =>
      LocalFine(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        memberId: memberId ?? this.memberId,
        memberName: memberName ?? this.memberName,
        amount: amount ?? this.amount,
        reason: reason ?? this.reason,
        status: status ?? this.status,
        issuedAt: issuedAt ?? this.issuedAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalFine copyWithCompanion(LocalFinesCompanion data) {
    return LocalFine(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      memberName:
          data.memberName.present ? data.memberName.value : this.memberName,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalFine(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('memberId: $memberId, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, memberId, memberName, amount,
      reason, status, issuedAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalFine &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.memberId == this.memberId &&
          other.memberName == this.memberName &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.issuedAt == this.issuedAt &&
          other.updatedAt == this.updatedAt);
}

class LocalFinesCompanion extends UpdateCompanion<LocalFine> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> memberId;
  final Value<String> memberName;
  final Value<double> amount;
  final Value<String> reason;
  final Value<String> status;
  final Value<int> issuedAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const LocalFinesCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.memberName = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalFinesCompanion.insert({
    required String id,
    required String groupId,
    required String memberId,
    required String memberName,
    required double amount,
    required String reason,
    required String status,
    required int issuedAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        groupId = Value(groupId),
        memberId = Value(memberId),
        memberName = Value(memberName),
        amount = Value(amount),
        reason = Value(reason),
        status = Value(status),
        issuedAt = Value(issuedAt),
        updatedAt = Value(updatedAt);
  static Insertable<LocalFine> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? memberId,
    Expression<String>? memberName,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<int>? issuedAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (memberId != null) 'member_id': memberId,
      if (memberName != null) 'member_name': memberName,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalFinesCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? memberId,
      Value<String>? memberName,
      Value<double>? amount,
      Value<String>? reason,
      Value<String>? status,
      Value<int>? issuedAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return LocalFinesCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      memberId: memberId ?? this.memberId,
      memberName: memberName ?? this.memberName,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (memberName.present) {
      map['member_name'] = Variable<String>(memberName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<int>(issuedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalFinesCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('memberId: $memberId, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingSyncTable extends PendingSync
    with TableInfo<$PendingSyncTable, PendingSyncData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSyncTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _collectionMeta =
      const VerificationMeta('collection');
  @override
  late final GeneratedColumn<String> collection = GeneratedColumn<String>(
      'collection', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _documentIdMeta =
      const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, collection, documentId, operation, data, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_sync';
  @override
  VerificationContext validateIntegrity(Insertable<PendingSyncData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection')) {
      context.handle(
          _collectionMeta,
          collection.isAcceptableOrUnknown(
              data['collection']!, _collectionMeta));
    } else if (isInserting) {
      context.missing(_collectionMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingSyncData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSyncData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      collection: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}collection'])!,
      documentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PendingSyncTable createAlias(String alias) {
    return $PendingSyncTable(attachedDatabase, alias);
  }
}

class PendingSyncData extends DataClass implements Insertable<PendingSyncData> {
  final int id;
  final String collection;
  final String documentId;
  final String operation;
  final String data;
  final int createdAt;
  const PendingSyncData(
      {required this.id,
      required this.collection,
      required this.documentId,
      required this.operation,
      required this.data,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection'] = Variable<String>(collection);
    map['document_id'] = Variable<String>(documentId);
    map['operation'] = Variable<String>(operation);
    map['data'] = Variable<String>(data);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  PendingSyncCompanion toCompanion(bool nullToAbsent) {
    return PendingSyncCompanion(
      id: Value(id),
      collection: Value(collection),
      documentId: Value(documentId),
      operation: Value(operation),
      data: Value(data),
      createdAt: Value(createdAt),
    );
  }

  factory PendingSyncData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSyncData(
      id: serializer.fromJson<int>(json['id']),
      collection: serializer.fromJson<String>(json['collection']),
      documentId: serializer.fromJson<String>(json['documentId']),
      operation: serializer.fromJson<String>(json['operation']),
      data: serializer.fromJson<String>(json['data']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collection': serializer.toJson<String>(collection),
      'documentId': serializer.toJson<String>(documentId),
      'operation': serializer.toJson<String>(operation),
      'data': serializer.toJson<String>(data),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  PendingSyncData copyWith(
          {int? id,
          String? collection,
          String? documentId,
          String? operation,
          String? data,
          int? createdAt}) =>
      PendingSyncData(
        id: id ?? this.id,
        collection: collection ?? this.collection,
        documentId: documentId ?? this.documentId,
        operation: operation ?? this.operation,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
      );
  PendingSyncData copyWithCompanion(PendingSyncCompanion data) {
    return PendingSyncData(
      id: data.id.present ? data.id.value : this.id,
      collection:
          data.collection.present ? data.collection.value : this.collection,
      documentId:
          data.documentId.present ? data.documentId.value : this.documentId,
      operation: data.operation.present ? data.operation.value : this.operation,
      data: data.data.present ? data.data.value : this.data,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncData(')
          ..write('id: $id, ')
          ..write('collection: $collection, ')
          ..write('documentId: $documentId, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, collection, documentId, operation, data, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSyncData &&
          other.id == this.id &&
          other.collection == this.collection &&
          other.documentId == this.documentId &&
          other.operation == this.operation &&
          other.data == this.data &&
          other.createdAt == this.createdAt);
}

class PendingSyncCompanion extends UpdateCompanion<PendingSyncData> {
  final Value<int> id;
  final Value<String> collection;
  final Value<String> documentId;
  final Value<String> operation;
  final Value<String> data;
  final Value<int> createdAt;
  const PendingSyncCompanion({
    this.id = const Value.absent(),
    this.collection = const Value.absent(),
    this.documentId = const Value.absent(),
    this.operation = const Value.absent(),
    this.data = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PendingSyncCompanion.insert({
    this.id = const Value.absent(),
    required String collection,
    required String documentId,
    required String operation,
    required String data,
    required int createdAt,
  })  : collection = Value(collection),
        documentId = Value(documentId),
        operation = Value(operation),
        data = Value(data),
        createdAt = Value(createdAt);
  static Insertable<PendingSyncData> custom({
    Expression<int>? id,
    Expression<String>? collection,
    Expression<String>? documentId,
    Expression<String>? operation,
    Expression<String>? data,
    Expression<int>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collection != null) 'collection': collection,
      if (documentId != null) 'document_id': documentId,
      if (operation != null) 'operation': operation,
      if (data != null) 'data': data,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PendingSyncCompanion copyWith(
      {Value<int>? id,
      Value<String>? collection,
      Value<String>? documentId,
      Value<String>? operation,
      Value<String>? data,
      Value<int>? createdAt}) {
    return PendingSyncCompanion(
      id: id ?? this.id,
      collection: collection ?? this.collection,
      documentId: documentId ?? this.documentId,
      operation: operation ?? this.operation,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collection.present) {
      map['collection'] = Variable<String>(collection.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncCompanion(')
          ..write('id: $id, ')
          ..write('collection: $collection, ')
          ..write('documentId: $documentId, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $LocalGroupsTable localGroups = $LocalGroupsTable(this);
  late final $LocalContributionsTable localContributions =
      $LocalContributionsTable(this);
  late final $LocalLoansTable localLoans = $LocalLoansTable(this);
  late final $LocalFinesTable localFines = $LocalFinesTable(this);
  late final $PendingSyncTable pendingSync = $PendingSyncTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [localGroups, localContributions, localLoans, localFines, pendingSync];
}

typedef $$LocalGroupsTableCreateCompanionBuilder = LocalGroupsCompanion
    Function({
  required String id,
  required String name,
  required String adminId,
  required String description,
  required double contributionAmount,
  required String contributionFrequency,
  required String status,
  Value<double> totalBalance,
  Value<double> totalContributed,
  Value<double> totalLoaned,
  required String memberIds,
  required String payoutOrder,
  Value<int> currentPayoutIndex,
  Value<String?> inviteCode,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$LocalGroupsTableUpdateCompanionBuilder = LocalGroupsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> adminId,
  Value<String> description,
  Value<double> contributionAmount,
  Value<String> contributionFrequency,
  Value<String> status,
  Value<double> totalBalance,
  Value<double> totalContributed,
  Value<double> totalLoaned,
  Value<String> memberIds,
  Value<String> payoutOrder,
  Value<int> currentPayoutIndex,
  Value<String?> inviteCode,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$LocalGroupsTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalGroupsTable> {
  $$LocalGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get adminId => $composableBuilder(
      column: $table.adminId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get contributionAmount => $composableBuilder(
      column: $table.contributionAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contributionFrequency => $composableBuilder(
      column: $table.contributionFrequency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalBalance => $composableBuilder(
      column: $table.totalBalance, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalContributed => $composableBuilder(
      column: $table.totalContributed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalLoaned => $composableBuilder(
      column: $table.totalLoaned, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberIds => $composableBuilder(
      column: $table.memberIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payoutOrder => $composableBuilder(
      column: $table.payoutOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentPayoutIndex => $composableBuilder(
      column: $table.currentPayoutIndex,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inviteCode => $composableBuilder(
      column: $table.inviteCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalGroupsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalGroupsTable> {
  $$LocalGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get adminId => $composableBuilder(
      column: $table.adminId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get contributionAmount => $composableBuilder(
      column: $table.contributionAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contributionFrequency => $composableBuilder(
      column: $table.contributionFrequency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalBalance => $composableBuilder(
      column: $table.totalBalance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalContributed => $composableBuilder(
      column: $table.totalContributed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalLoaned => $composableBuilder(
      column: $table.totalLoaned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberIds => $composableBuilder(
      column: $table.memberIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payoutOrder => $composableBuilder(
      column: $table.payoutOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentPayoutIndex => $composableBuilder(
      column: $table.currentPayoutIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inviteCode => $composableBuilder(
      column: $table.inviteCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalGroupsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalGroupsTable> {
  $$LocalGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get adminId =>
      $composableBuilder(column: $table.adminId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get contributionAmount => $composableBuilder(
      column: $table.contributionAmount, builder: (column) => column);

  GeneratedColumn<String> get contributionFrequency => $composableBuilder(
      column: $table.contributionFrequency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get totalBalance => $composableBuilder(
      column: $table.totalBalance, builder: (column) => column);

  GeneratedColumn<double> get totalContributed => $composableBuilder(
      column: $table.totalContributed, builder: (column) => column);

  GeneratedColumn<double> get totalLoaned => $composableBuilder(
      column: $table.totalLoaned, builder: (column) => column);

  GeneratedColumn<String> get memberIds =>
      $composableBuilder(column: $table.memberIds, builder: (column) => column);

  GeneratedColumn<String> get payoutOrder => $composableBuilder(
      column: $table.payoutOrder, builder: (column) => column);

  GeneratedColumn<int> get currentPayoutIndex => $composableBuilder(
      column: $table.currentPayoutIndex, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
      column: $table.inviteCode, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalGroupsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalGroupsTable,
    LocalGroup,
    $$LocalGroupsTableFilterComposer,
    $$LocalGroupsTableOrderingComposer,
    $$LocalGroupsTableAnnotationComposer,
    $$LocalGroupsTableCreateCompanionBuilder,
    $$LocalGroupsTableUpdateCompanionBuilder,
    (
      LocalGroup,
      BaseReferences<_$LocalDatabase, $LocalGroupsTable, LocalGroup>
    ),
    LocalGroup,
    PrefetchHooks Function()> {
  $$LocalGroupsTableTableManager(_$LocalDatabase db, $LocalGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> adminId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> contributionAmount = const Value.absent(),
            Value<String> contributionFrequency = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> totalBalance = const Value.absent(),
            Value<double> totalContributed = const Value.absent(),
            Value<double> totalLoaned = const Value.absent(),
            Value<String> memberIds = const Value.absent(),
            Value<String> payoutOrder = const Value.absent(),
            Value<int> currentPayoutIndex = const Value.absent(),
            Value<String?> inviteCode = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGroupsCompanion(
            id: id,
            name: name,
            adminId: adminId,
            description: description,
            contributionAmount: contributionAmount,
            contributionFrequency: contributionFrequency,
            status: status,
            totalBalance: totalBalance,
            totalContributed: totalContributed,
            totalLoaned: totalLoaned,
            memberIds: memberIds,
            payoutOrder: payoutOrder,
            currentPayoutIndex: currentPayoutIndex,
            inviteCode: inviteCode,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String adminId,
            required String description,
            required double contributionAmount,
            required String contributionFrequency,
            required String status,
            Value<double> totalBalance = const Value.absent(),
            Value<double> totalContributed = const Value.absent(),
            Value<double> totalLoaned = const Value.absent(),
            required String memberIds,
            required String payoutOrder,
            Value<int> currentPayoutIndex = const Value.absent(),
            Value<String?> inviteCode = const Value.absent(),
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalGroupsCompanion.insert(
            id: id,
            name: name,
            adminId: adminId,
            description: description,
            contributionAmount: contributionAmount,
            contributionFrequency: contributionFrequency,
            status: status,
            totalBalance: totalBalance,
            totalContributed: totalContributed,
            totalLoaned: totalLoaned,
            memberIds: memberIds,
            payoutOrder: payoutOrder,
            currentPayoutIndex: currentPayoutIndex,
            inviteCode: inviteCode,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalGroupsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalGroupsTable,
    LocalGroup,
    $$LocalGroupsTableFilterComposer,
    $$LocalGroupsTableOrderingComposer,
    $$LocalGroupsTableAnnotationComposer,
    $$LocalGroupsTableCreateCompanionBuilder,
    $$LocalGroupsTableUpdateCompanionBuilder,
    (
      LocalGroup,
      BaseReferences<_$LocalDatabase, $LocalGroupsTable, LocalGroup>
    ),
    LocalGroup,
    PrefetchHooks Function()>;
typedef $$LocalContributionsTableCreateCompanionBuilder
    = LocalContributionsCompanion Function({
  required String id,
  required String groupId,
  required String memberId,
  required String memberName,
  required double amount,
  required int contributionDate,
  required String status,
  Value<String?> notes,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$LocalContributionsTableUpdateCompanionBuilder
    = LocalContributionsCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> memberId,
  Value<String> memberName,
  Value<double> amount,
  Value<int> contributionDate,
  Value<String> status,
  Value<String?> notes,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$LocalContributionsTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalContributionsTable> {
  $$LocalContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get contributionDate => $composableBuilder(
      column: $table.contributionDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalContributionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalContributionsTable> {
  $$LocalContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get contributionDate => $composableBuilder(
      column: $table.contributionDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalContributionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalContributionsTable> {
  $$LocalContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get contributionDate => $composableBuilder(
      column: $table.contributionDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalContributionsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalContributionsTable,
    LocalContribution,
    $$LocalContributionsTableFilterComposer,
    $$LocalContributionsTableOrderingComposer,
    $$LocalContributionsTableAnnotationComposer,
    $$LocalContributionsTableCreateCompanionBuilder,
    $$LocalContributionsTableUpdateCompanionBuilder,
    (
      LocalContribution,
      BaseReferences<_$LocalDatabase, $LocalContributionsTable,
          LocalContribution>
    ),
    LocalContribution,
    PrefetchHooks Function()> {
  $$LocalContributionsTableTableManager(
      _$LocalDatabase db, $LocalContributionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalContributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalContributionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> memberId = const Value.absent(),
            Value<String> memberName = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> contributionDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalContributionsCompanion(
            id: id,
            groupId: groupId,
            memberId: memberId,
            memberName: memberName,
            amount: amount,
            contributionDate: contributionDate,
            status: status,
            notes: notes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String memberId,
            required String memberName,
            required double amount,
            required int contributionDate,
            required String status,
            Value<String?> notes = const Value.absent(),
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalContributionsCompanion.insert(
            id: id,
            groupId: groupId,
            memberId: memberId,
            memberName: memberName,
            amount: amount,
            contributionDate: contributionDate,
            status: status,
            notes: notes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalContributionsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalContributionsTable,
    LocalContribution,
    $$LocalContributionsTableFilterComposer,
    $$LocalContributionsTableOrderingComposer,
    $$LocalContributionsTableAnnotationComposer,
    $$LocalContributionsTableCreateCompanionBuilder,
    $$LocalContributionsTableUpdateCompanionBuilder,
    (
      LocalContribution,
      BaseReferences<_$LocalDatabase, $LocalContributionsTable,
          LocalContribution>
    ),
    LocalContribution,
    PrefetchHooks Function()>;
typedef $$LocalLoansTableCreateCompanionBuilder = LocalLoansCompanion Function({
  required String id,
  required String groupId,
  required String borrowerId,
  required String borrowerName,
  required double amount,
  required double interestRate,
  required int durationMonths,
  required String status,
  Value<double> amountRepaid,
  Value<String?> purpose,
  required int requestedAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$LocalLoansTableUpdateCompanionBuilder = LocalLoansCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> borrowerId,
  Value<String> borrowerName,
  Value<double> amount,
  Value<double> interestRate,
  Value<int> durationMonths,
  Value<String> status,
  Value<double> amountRepaid,
  Value<String?> purpose,
  Value<int> requestedAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$LocalLoansTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalLoansTable> {
  $$LocalLoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get borrowerId => $composableBuilder(
      column: $table.borrowerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get borrowerName => $composableBuilder(
      column: $table.borrowerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMonths => $composableBuilder(
      column: $table.durationMonths,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountRepaid => $composableBuilder(
      column: $table.amountRepaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get purpose => $composableBuilder(
      column: $table.purpose, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalLoansTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalLoansTable> {
  $$LocalLoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get borrowerId => $composableBuilder(
      column: $table.borrowerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get borrowerName => $composableBuilder(
      column: $table.borrowerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get interestRate => $composableBuilder(
      column: $table.interestRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMonths => $composableBuilder(
      column: $table.durationMonths,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountRepaid => $composableBuilder(
      column: $table.amountRepaid,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purpose => $composableBuilder(
      column: $table.purpose, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalLoansTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalLoansTable> {
  $$LocalLoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get borrowerId => $composableBuilder(
      column: $table.borrowerId, builder: (column) => column);

  GeneratedColumn<String> get borrowerName => $composableBuilder(
      column: $table.borrowerName, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get interestRate => $composableBuilder(
      column: $table.interestRate, builder: (column) => column);

  GeneratedColumn<int> get durationMonths => $composableBuilder(
      column: $table.durationMonths, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get amountRepaid => $composableBuilder(
      column: $table.amountRepaid, builder: (column) => column);

  GeneratedColumn<String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<int> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalLoansTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalLoansTable,
    LocalLoan,
    $$LocalLoansTableFilterComposer,
    $$LocalLoansTableOrderingComposer,
    $$LocalLoansTableAnnotationComposer,
    $$LocalLoansTableCreateCompanionBuilder,
    $$LocalLoansTableUpdateCompanionBuilder,
    (LocalLoan, BaseReferences<_$LocalDatabase, $LocalLoansTable, LocalLoan>),
    LocalLoan,
    PrefetchHooks Function()> {
  $$LocalLoansTableTableManager(_$LocalDatabase db, $LocalLoansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalLoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalLoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalLoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> borrowerId = const Value.absent(),
            Value<String> borrowerName = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<double> interestRate = const Value.absent(),
            Value<int> durationMonths = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<double> amountRepaid = const Value.absent(),
            Value<String?> purpose = const Value.absent(),
            Value<int> requestedAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalLoansCompanion(
            id: id,
            groupId: groupId,
            borrowerId: borrowerId,
            borrowerName: borrowerName,
            amount: amount,
            interestRate: interestRate,
            durationMonths: durationMonths,
            status: status,
            amountRepaid: amountRepaid,
            purpose: purpose,
            requestedAt: requestedAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String borrowerId,
            required String borrowerName,
            required double amount,
            required double interestRate,
            required int durationMonths,
            required String status,
            Value<double> amountRepaid = const Value.absent(),
            Value<String?> purpose = const Value.absent(),
            required int requestedAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalLoansCompanion.insert(
            id: id,
            groupId: groupId,
            borrowerId: borrowerId,
            borrowerName: borrowerName,
            amount: amount,
            interestRate: interestRate,
            durationMonths: durationMonths,
            status: status,
            amountRepaid: amountRepaid,
            purpose: purpose,
            requestedAt: requestedAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalLoansTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalLoansTable,
    LocalLoan,
    $$LocalLoansTableFilterComposer,
    $$LocalLoansTableOrderingComposer,
    $$LocalLoansTableAnnotationComposer,
    $$LocalLoansTableCreateCompanionBuilder,
    $$LocalLoansTableUpdateCompanionBuilder,
    (LocalLoan, BaseReferences<_$LocalDatabase, $LocalLoansTable, LocalLoan>),
    LocalLoan,
    PrefetchHooks Function()>;
typedef $$LocalFinesTableCreateCompanionBuilder = LocalFinesCompanion Function({
  required String id,
  required String groupId,
  required String memberId,
  required String memberName,
  required double amount,
  required String reason,
  required String status,
  required int issuedAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$LocalFinesTableUpdateCompanionBuilder = LocalFinesCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> memberId,
  Value<String> memberName,
  Value<double> amount,
  Value<String> reason,
  Value<String> status,
  Value<int> issuedAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$LocalFinesTableFilterComposer
    extends Composer<_$LocalDatabase, $LocalFinesTable> {
  $$LocalFinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalFinesTableOrderingComposer
    extends Composer<_$LocalDatabase, $LocalFinesTable> {
  $$LocalFinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberId => $composableBuilder(
      column: $table.memberId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get issuedAt => $composableBuilder(
      column: $table.issuedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalFinesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $LocalFinesTable> {
  $$LocalFinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get memberName => $composableBuilder(
      column: $table.memberName, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalFinesTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $LocalFinesTable,
    LocalFine,
    $$LocalFinesTableFilterComposer,
    $$LocalFinesTableOrderingComposer,
    $$LocalFinesTableAnnotationComposer,
    $$LocalFinesTableCreateCompanionBuilder,
    $$LocalFinesTableUpdateCompanionBuilder,
    (LocalFine, BaseReferences<_$LocalDatabase, $LocalFinesTable, LocalFine>),
    LocalFine,
    PrefetchHooks Function()> {
  $$LocalFinesTableTableManager(_$LocalDatabase db, $LocalFinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalFinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalFinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalFinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> memberId = const Value.absent(),
            Value<String> memberName = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> reason = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> issuedAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalFinesCompanion(
            id: id,
            groupId: groupId,
            memberId: memberId,
            memberName: memberName,
            amount: amount,
            reason: reason,
            status: status,
            issuedAt: issuedAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String groupId,
            required String memberId,
            required String memberName,
            required double amount,
            required String reason,
            required String status,
            required int issuedAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalFinesCompanion.insert(
            id: id,
            groupId: groupId,
            memberId: memberId,
            memberName: memberName,
            amount: amount,
            reason: reason,
            status: status,
            issuedAt: issuedAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalFinesTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $LocalFinesTable,
    LocalFine,
    $$LocalFinesTableFilterComposer,
    $$LocalFinesTableOrderingComposer,
    $$LocalFinesTableAnnotationComposer,
    $$LocalFinesTableCreateCompanionBuilder,
    $$LocalFinesTableUpdateCompanionBuilder,
    (LocalFine, BaseReferences<_$LocalDatabase, $LocalFinesTable, LocalFine>),
    LocalFine,
    PrefetchHooks Function()>;
typedef $$PendingSyncTableCreateCompanionBuilder = PendingSyncCompanion
    Function({
  Value<int> id,
  required String collection,
  required String documentId,
  required String operation,
  required String data,
  required int createdAt,
});
typedef $$PendingSyncTableUpdateCompanionBuilder = PendingSyncCompanion
    Function({
  Value<int> id,
  Value<String> collection,
  Value<String> documentId,
  Value<String> operation,
  Value<String> data,
  Value<int> createdAt,
});

class $$PendingSyncTableFilterComposer
    extends Composer<_$LocalDatabase, $PendingSyncTable> {
  $$PendingSyncTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get collection => $composableBuilder(
      column: $table.collection, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$PendingSyncTableOrderingComposer
    extends Composer<_$LocalDatabase, $PendingSyncTable> {
  $$PendingSyncTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get collection => $composableBuilder(
      column: $table.collection, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingSyncTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PendingSyncTable> {
  $$PendingSyncTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collection => $composableBuilder(
      column: $table.collection, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PendingSyncTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $PendingSyncTable,
    PendingSyncData,
    $$PendingSyncTableFilterComposer,
    $$PendingSyncTableOrderingComposer,
    $$PendingSyncTableAnnotationComposer,
    $$PendingSyncTableCreateCompanionBuilder,
    $$PendingSyncTableUpdateCompanionBuilder,
    (
      PendingSyncData,
      BaseReferences<_$LocalDatabase, $PendingSyncTable, PendingSyncData>
    ),
    PendingSyncData,
    PrefetchHooks Function()> {
  $$PendingSyncTableTableManager(_$LocalDatabase db, $PendingSyncTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSyncTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingSyncTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingSyncTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> collection = const Value.absent(),
            Value<String> documentId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
          }) =>
              PendingSyncCompanion(
            id: id,
            collection: collection,
            documentId: documentId,
            operation: operation,
            data: data,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String collection,
            required String documentId,
            required String operation,
            required String data,
            required int createdAt,
          }) =>
              PendingSyncCompanion.insert(
            id: id,
            collection: collection,
            documentId: documentId,
            operation: operation,
            data: data,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingSyncTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $PendingSyncTable,
    PendingSyncData,
    $$PendingSyncTableFilterComposer,
    $$PendingSyncTableOrderingComposer,
    $$PendingSyncTableAnnotationComposer,
    $$PendingSyncTableCreateCompanionBuilder,
    $$PendingSyncTableUpdateCompanionBuilder,
    (
      PendingSyncData,
      BaseReferences<_$LocalDatabase, $PendingSyncTable, PendingSyncData>
    ),
    PendingSyncData,
    PrefetchHooks Function()>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$LocalGroupsTableTableManager get localGroups =>
      $$LocalGroupsTableTableManager(_db, _db.localGroups);
  $$LocalContributionsTableTableManager get localContributions =>
      $$LocalContributionsTableTableManager(_db, _db.localContributions);
  $$LocalLoansTableTableManager get localLoans =>
      $$LocalLoansTableTableManager(_db, _db.localLoans);
  $$LocalFinesTableTableManager get localFines =>
      $$LocalFinesTableTableManager(_db, _db.localFines);
  $$PendingSyncTableTableManager get pendingSync =>
      $$PendingSyncTableTableManager(_db, _db.pendingSync);
}
