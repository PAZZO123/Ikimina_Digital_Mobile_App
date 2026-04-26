// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  List<String> get groupIds => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  bool get biometricEnabled => throw _privateConstructorUsedError;
  String get preferredLanguage => throw _privateConstructorUsedError;
  String get preferredTheme => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String fullName,
      String email,
      String phone,
      String role,
      String? profileImageUrl,
      List<String> groupIds,
      bool isActive,
      bool emailVerified,
      bool biometricEnabled,
      String preferredLanguage,
      String preferredTheme,
      DateTime? createdAt,
      DateTime? lastSeen});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? role = null,
    Object? profileImageUrl = freezed,
    Object? groupIds = null,
    Object? isActive = null,
    Object? emailVerified = null,
    Object? biometricEnabled = null,
    Object? preferredLanguage = null,
    Object? preferredTheme = null,
    Object? createdAt = freezed,
    Object? lastSeen = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      groupIds: null == groupIds
          ? _value.groupIds
          : groupIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      biometricEnabled: null == biometricEnabled
          ? _value.biometricEnabled
          : biometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      preferredTheme: null == preferredTheme
          ? _value.preferredTheme
          : preferredTheme // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fullName,
      String email,
      String phone,
      String role,
      String? profileImageUrl,
      List<String> groupIds,
      bool isActive,
      bool emailVerified,
      bool biometricEnabled,
      String preferredLanguage,
      String preferredTheme,
      DateTime? createdAt,
      DateTime? lastSeen});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? role = null,
    Object? profileImageUrl = freezed,
    Object? groupIds = null,
    Object? isActive = null,
    Object? emailVerified = null,
    Object? biometricEnabled = null,
    Object? preferredLanguage = null,
    Object? preferredTheme = null,
    Object? createdAt = freezed,
    Object? lastSeen = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      groupIds: null == groupIds
          ? _value._groupIds
          : groupIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      biometricEnabled: null == biometricEnabled
          ? _value.biometricEnabled
          : biometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      preferredTheme: null == preferredTheme
          ? _value.preferredTheme
          : preferredTheme // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.phone,
      this.role = 'member',
      this.profileImageUrl,
      final List<String> groupIds = const [],
      this.isActive = true,
      this.emailVerified = false,
      this.biometricEnabled = false,
      this.preferredLanguage = 'en',
      this.preferredTheme = 'light',
      this.createdAt,
      this.lastSeen})
      : _groupIds = groupIds;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String phone;
  @override
  @JsonKey()
  final String role;
  @override
  final String? profileImageUrl;
  final List<String> _groupIds;
  @override
  @JsonKey()
  List<String> get groupIds {
    if (_groupIds is EqualUnmodifiableListView) return _groupIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupIds);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  @JsonKey()
  final bool biometricEnabled;
  @override
  @JsonKey()
  final String preferredLanguage;
  @override
  @JsonKey()
  final String preferredTheme;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, phone: $phone, role: $role, profileImageUrl: $profileImageUrl, groupIds: $groupIds, isActive: $isActive, emailVerified: $emailVerified, biometricEnabled: $biometricEnabled, preferredLanguage: $preferredLanguage, preferredTheme: $preferredTheme, createdAt: $createdAt, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality().equals(other._groupIds, _groupIds) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.biometricEnabled, biometricEnabled) ||
                other.biometricEnabled == biometricEnabled) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            (identical(other.preferredTheme, preferredTheme) ||
                other.preferredTheme == preferredTheme) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      email,
      phone,
      role,
      profileImageUrl,
      const DeepCollectionEquality().hash(_groupIds),
      isActive,
      emailVerified,
      biometricEnabled,
      preferredLanguage,
      preferredTheme,
      createdAt,
      lastSeen);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String fullName,
      required final String email,
      required final String phone,
      final String role,
      final String? profileImageUrl,
      final List<String> groupIds,
      final bool isActive,
      final bool emailVerified,
      final bool biometricEnabled,
      final String preferredLanguage,
      final String preferredTheme,
      final DateTime? createdAt,
      final DateTime? lastSeen}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get role;
  @override
  String? get profileImageUrl;
  @override
  List<String> get groupIds;
  @override
  bool get isActive;
  @override
  bool get emailVerified;
  @override
  bool get biometricEnabled;
  @override
  String get preferredLanguage;
  @override
  String get preferredTheme;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastSeen;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get adminId => throw _privateConstructorUsedError;
  double get contributionAmount => throw _privateConstructorUsedError;
  String get contributionFrequency => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError;
  List<String> get payoutOrder => throw _privateConstructorUsedError;
  int get currentPayoutIndex => throw _privateConstructorUsedError;
  double get totalBalance => throw _privateConstructorUsedError;
  double get totalContributed => throw _privateConstructorUsedError;
  double get totalLoaned => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get groupImageUrl => throw _privateConstructorUsedError;
  String? get inviteCode => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get nextContributionDate => throw _privateConstructorUsedError;
  DateTime? get createdAt =>
      throw _privateConstructorUsedError; // ── Loan & penalty rules ─────────────────────────────────────────────
// All use @Default so existing Firestore docs load without errors.
  double get defaultInterestRate =>
      throw _privateConstructorUsedError; // % applied to every loan
  int get maxRepaymentMonths =>
      throw _privateConstructorUsedError; // longest allowed duration
  double get loanPenaltyRate =>
      throw _privateConstructorUsedError; // % added per late period
  int get loanPenaltyGraceDays =>
      throw _privateConstructorUsedError; // days before penalty kicks in
  double get maxLoanMultiplier =>
      throw _privateConstructorUsedError; // savings × this = borrow limit
  int get minContributionsForLoan =>
      throw _privateConstructorUsedError; // min deposits before eligible
// ── Late-contribution fine rules ────────────────────────────────────────
  double get lateFineAmount =>
      throw _privateConstructorUsedError; // RWF charged per missed period
  int get fineGraceDays => throw _privateConstructorUsedError;

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String adminId,
      double contributionAmount,
      String contributionFrequency,
      String description,
      List<String> memberIds,
      List<String> payoutOrder,
      int currentPayoutIndex,
      double totalBalance,
      double totalContributed,
      double totalLoaned,
      String status,
      String? groupImageUrl,
      String? inviteCode,
      DateTime? startDate,
      DateTime? nextContributionDate,
      DateTime? createdAt,
      double defaultInterestRate,
      int maxRepaymentMonths,
      double loanPenaltyRate,
      int loanPenaltyGraceDays,
      double maxLoanMultiplier,
      int minContributionsForLoan,
      double lateFineAmount,
      int fineGraceDays});
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminId = null,
    Object? contributionAmount = null,
    Object? contributionFrequency = null,
    Object? description = null,
    Object? memberIds = null,
    Object? payoutOrder = null,
    Object? currentPayoutIndex = null,
    Object? totalBalance = null,
    Object? totalContributed = null,
    Object? totalLoaned = null,
    Object? status = null,
    Object? groupImageUrl = freezed,
    Object? inviteCode = freezed,
    Object? startDate = freezed,
    Object? nextContributionDate = freezed,
    Object? createdAt = freezed,
    Object? defaultInterestRate = null,
    Object? maxRepaymentMonths = null,
    Object? loanPenaltyRate = null,
    Object? loanPenaltyGraceDays = null,
    Object? maxLoanMultiplier = null,
    Object? minContributionsForLoan = null,
    Object? lateFineAmount = null,
    Object? fineGraceDays = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      contributionAmount: null == contributionAmount
          ? _value.contributionAmount
          : contributionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      contributionFrequency: null == contributionFrequency
          ? _value.contributionFrequency
          : contributionFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value.memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      payoutOrder: null == payoutOrder
          ? _value.payoutOrder
          : payoutOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPayoutIndex: null == currentPayoutIndex
          ? _value.currentPayoutIndex
          : currentPayoutIndex // ignore: cast_nullable_to_non_nullable
              as int,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributed: null == totalContributed
          ? _value.totalContributed
          : totalContributed // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoaned: null == totalLoaned
          ? _value.totalLoaned
          : totalLoaned // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      groupImageUrl: freezed == groupImageUrl
          ? _value.groupImageUrl
          : groupImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextContributionDate: freezed == nextContributionDate
          ? _value.nextContributionDate
          : nextContributionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultInterestRate: null == defaultInterestRate
          ? _value.defaultInterestRate
          : defaultInterestRate // ignore: cast_nullable_to_non_nullable
              as double,
      maxRepaymentMonths: null == maxRepaymentMonths
          ? _value.maxRepaymentMonths
          : maxRepaymentMonths // ignore: cast_nullable_to_non_nullable
              as int,
      loanPenaltyRate: null == loanPenaltyRate
          ? _value.loanPenaltyRate
          : loanPenaltyRate // ignore: cast_nullable_to_non_nullable
              as double,
      loanPenaltyGraceDays: null == loanPenaltyGraceDays
          ? _value.loanPenaltyGraceDays
          : loanPenaltyGraceDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxLoanMultiplier: null == maxLoanMultiplier
          ? _value.maxLoanMultiplier
          : maxLoanMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      minContributionsForLoan: null == minContributionsForLoan
          ? _value.minContributionsForLoan
          : minContributionsForLoan // ignore: cast_nullable_to_non_nullable
              as int,
      lateFineAmount: null == lateFineAmount
          ? _value.lateFineAmount
          : lateFineAmount // ignore: cast_nullable_to_non_nullable
              as double,
      fineGraceDays: null == fineGraceDays
          ? _value.fineGraceDays
          : fineGraceDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
          _$GroupModelImpl value, $Res Function(_$GroupModelImpl) then) =
      __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String adminId,
      double contributionAmount,
      String contributionFrequency,
      String description,
      List<String> memberIds,
      List<String> payoutOrder,
      int currentPayoutIndex,
      double totalBalance,
      double totalContributed,
      double totalLoaned,
      String status,
      String? groupImageUrl,
      String? inviteCode,
      DateTime? startDate,
      DateTime? nextContributionDate,
      DateTime? createdAt,
      double defaultInterestRate,
      int maxRepaymentMonths,
      double loanPenaltyRate,
      int loanPenaltyGraceDays,
      double maxLoanMultiplier,
      int minContributionsForLoan,
      double lateFineAmount,
      int fineGraceDays});
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
      _$GroupModelImpl _value, $Res Function(_$GroupModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? adminId = null,
    Object? contributionAmount = null,
    Object? contributionFrequency = null,
    Object? description = null,
    Object? memberIds = null,
    Object? payoutOrder = null,
    Object? currentPayoutIndex = null,
    Object? totalBalance = null,
    Object? totalContributed = null,
    Object? totalLoaned = null,
    Object? status = null,
    Object? groupImageUrl = freezed,
    Object? inviteCode = freezed,
    Object? startDate = freezed,
    Object? nextContributionDate = freezed,
    Object? createdAt = freezed,
    Object? defaultInterestRate = null,
    Object? maxRepaymentMonths = null,
    Object? loanPenaltyRate = null,
    Object? loanPenaltyGraceDays = null,
    Object? maxLoanMultiplier = null,
    Object? minContributionsForLoan = null,
    Object? lateFineAmount = null,
    Object? fineGraceDays = null,
  }) {
    return _then(_$GroupModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      contributionAmount: null == contributionAmount
          ? _value.contributionAmount
          : contributionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      contributionFrequency: null == contributionFrequency
          ? _value.contributionFrequency
          : contributionFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      memberIds: null == memberIds
          ? _value._memberIds
          : memberIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      payoutOrder: null == payoutOrder
          ? _value._payoutOrder
          : payoutOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPayoutIndex: null == currentPayoutIndex
          ? _value.currentPayoutIndex
          : currentPayoutIndex // ignore: cast_nullable_to_non_nullable
              as int,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      totalContributed: null == totalContributed
          ? _value.totalContributed
          : totalContributed // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoaned: null == totalLoaned
          ? _value.totalLoaned
          : totalLoaned // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      groupImageUrl: freezed == groupImageUrl
          ? _value.groupImageUrl
          : groupImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextContributionDate: freezed == nextContributionDate
          ? _value.nextContributionDate
          : nextContributionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      defaultInterestRate: null == defaultInterestRate
          ? _value.defaultInterestRate
          : defaultInterestRate // ignore: cast_nullable_to_non_nullable
              as double,
      maxRepaymentMonths: null == maxRepaymentMonths
          ? _value.maxRepaymentMonths
          : maxRepaymentMonths // ignore: cast_nullable_to_non_nullable
              as int,
      loanPenaltyRate: null == loanPenaltyRate
          ? _value.loanPenaltyRate
          : loanPenaltyRate // ignore: cast_nullable_to_non_nullable
              as double,
      loanPenaltyGraceDays: null == loanPenaltyGraceDays
          ? _value.loanPenaltyGraceDays
          : loanPenaltyGraceDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxLoanMultiplier: null == maxLoanMultiplier
          ? _value.maxLoanMultiplier
          : maxLoanMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      minContributionsForLoan: null == minContributionsForLoan
          ? _value.minContributionsForLoan
          : minContributionsForLoan // ignore: cast_nullable_to_non_nullable
              as int,
      lateFineAmount: null == lateFineAmount
          ? _value.lateFineAmount
          : lateFineAmount // ignore: cast_nullable_to_non_nullable
              as double,
      fineGraceDays: null == fineGraceDays
          ? _value.fineGraceDays
          : fineGraceDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl implements _GroupModel {
  const _$GroupModelImpl(
      {required this.id,
      required this.name,
      required this.adminId,
      required this.contributionAmount,
      required this.contributionFrequency,
      required this.description,
      final List<String> memberIds = const [],
      final List<String> payoutOrder = const [],
      this.currentPayoutIndex = 0,
      this.totalBalance = 0.0,
      this.totalContributed = 0.0,
      this.totalLoaned = 0.0,
      this.status = 'active',
      this.groupImageUrl,
      this.inviteCode,
      this.startDate,
      this.nextContributionDate,
      this.createdAt,
      this.defaultInterestRate = 5.0,
      this.maxRepaymentMonths = 12,
      this.loanPenaltyRate = 2.0,
      this.loanPenaltyGraceDays = 7,
      this.maxLoanMultiplier = 3.0,
      this.minContributionsForLoan = 1,
      this.lateFineAmount = 500.0,
      this.fineGraceDays = 3})
      : _memberIds = memberIds,
        _payoutOrder = payoutOrder;

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String adminId;
  @override
  final double contributionAmount;
  @override
  final String contributionFrequency;
  @override
  final String description;
  final List<String> _memberIds;
  @override
  @JsonKey()
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  final List<String> _payoutOrder;
  @override
  @JsonKey()
  List<String> get payoutOrder {
    if (_payoutOrder is EqualUnmodifiableListView) return _payoutOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payoutOrder);
  }

  @override
  @JsonKey()
  final int currentPayoutIndex;
  @override
  @JsonKey()
  final double totalBalance;
  @override
  @JsonKey()
  final double totalContributed;
  @override
  @JsonKey()
  final double totalLoaned;
  @override
  @JsonKey()
  final String status;
  @override
  final String? groupImageUrl;
  @override
  final String? inviteCode;
  @override
  final DateTime? startDate;
  @override
  final DateTime? nextContributionDate;
  @override
  final DateTime? createdAt;
// ── Loan & penalty rules ─────────────────────────────────────────────
// All use @Default so existing Firestore docs load without errors.
  @override
  @JsonKey()
  final double defaultInterestRate;
// % applied to every loan
  @override
  @JsonKey()
  final int maxRepaymentMonths;
// longest allowed duration
  @override
  @JsonKey()
  final double loanPenaltyRate;
// % added per late period
  @override
  @JsonKey()
  final int loanPenaltyGraceDays;
// days before penalty kicks in
  @override
  @JsonKey()
  final double maxLoanMultiplier;
// savings × this = borrow limit
  @override
  @JsonKey()
  final int minContributionsForLoan;
// min deposits before eligible
// ── Late-contribution fine rules ────────────────────────────────────────
  @override
  @JsonKey()
  final double lateFineAmount;
// RWF charged per missed period
  @override
  @JsonKey()
  final int fineGraceDays;

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, adminId: $adminId, contributionAmount: $contributionAmount, contributionFrequency: $contributionFrequency, description: $description, memberIds: $memberIds, payoutOrder: $payoutOrder, currentPayoutIndex: $currentPayoutIndex, totalBalance: $totalBalance, totalContributed: $totalContributed, totalLoaned: $totalLoaned, status: $status, groupImageUrl: $groupImageUrl, inviteCode: $inviteCode, startDate: $startDate, nextContributionDate: $nextContributionDate, createdAt: $createdAt, defaultInterestRate: $defaultInterestRate, maxRepaymentMonths: $maxRepaymentMonths, loanPenaltyRate: $loanPenaltyRate, loanPenaltyGraceDays: $loanPenaltyGraceDays, maxLoanMultiplier: $maxLoanMultiplier, minContributionsForLoan: $minContributionsForLoan, lateFineAmount: $lateFineAmount, fineGraceDays: $fineGraceDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.contributionAmount, contributionAmount) ||
                other.contributionAmount == contributionAmount) &&
            (identical(other.contributionFrequency, contributionFrequency) ||
                other.contributionFrequency == contributionFrequency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._memberIds, _memberIds) &&
            const DeepCollectionEquality()
                .equals(other._payoutOrder, _payoutOrder) &&
            (identical(other.currentPayoutIndex, currentPayoutIndex) ||
                other.currentPayoutIndex == currentPayoutIndex) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.totalContributed, totalContributed) ||
                other.totalContributed == totalContributed) &&
            (identical(other.totalLoaned, totalLoaned) ||
                other.totalLoaned == totalLoaned) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.groupImageUrl, groupImageUrl) ||
                other.groupImageUrl == groupImageUrl) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.nextContributionDate, nextContributionDate) ||
                other.nextContributionDate == nextContributionDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.defaultInterestRate, defaultInterestRate) ||
                other.defaultInterestRate == defaultInterestRate) &&
            (identical(other.maxRepaymentMonths, maxRepaymentMonths) ||
                other.maxRepaymentMonths == maxRepaymentMonths) &&
            (identical(other.loanPenaltyRate, loanPenaltyRate) ||
                other.loanPenaltyRate == loanPenaltyRate) &&
            (identical(other.loanPenaltyGraceDays, loanPenaltyGraceDays) ||
                other.loanPenaltyGraceDays == loanPenaltyGraceDays) &&
            (identical(other.maxLoanMultiplier, maxLoanMultiplier) ||
                other.maxLoanMultiplier == maxLoanMultiplier) &&
            (identical(
                    other.minContributionsForLoan, minContributionsForLoan) ||
                other.minContributionsForLoan == minContributionsForLoan) &&
            (identical(other.lateFineAmount, lateFineAmount) ||
                other.lateFineAmount == lateFineAmount) &&
            (identical(other.fineGraceDays, fineGraceDays) ||
                other.fineGraceDays == fineGraceDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        adminId,
        contributionAmount,
        contributionFrequency,
        description,
        const DeepCollectionEquality().hash(_memberIds),
        const DeepCollectionEquality().hash(_payoutOrder),
        currentPayoutIndex,
        totalBalance,
        totalContributed,
        totalLoaned,
        status,
        groupImageUrl,
        inviteCode,
        startDate,
        nextContributionDate,
        createdAt,
        defaultInterestRate,
        maxRepaymentMonths,
        loanPenaltyRate,
        loanPenaltyGraceDays,
        maxLoanMultiplier,
        minContributionsForLoan,
        lateFineAmount,
        fineGraceDays
      ]);

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(
      this,
    );
  }
}

abstract class _GroupModel implements GroupModel {
  const factory _GroupModel(
      {required final String id,
      required final String name,
      required final String adminId,
      required final double contributionAmount,
      required final String contributionFrequency,
      required final String description,
      final List<String> memberIds,
      final List<String> payoutOrder,
      final int currentPayoutIndex,
      final double totalBalance,
      final double totalContributed,
      final double totalLoaned,
      final String status,
      final String? groupImageUrl,
      final String? inviteCode,
      final DateTime? startDate,
      final DateTime? nextContributionDate,
      final DateTime? createdAt,
      final double defaultInterestRate,
      final int maxRepaymentMonths,
      final double loanPenaltyRate,
      final int loanPenaltyGraceDays,
      final double maxLoanMultiplier,
      final int minContributionsForLoan,
      final double lateFineAmount,
      final int fineGraceDays}) = _$GroupModelImpl;

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get adminId;
  @override
  double get contributionAmount;
  @override
  String get contributionFrequency;
  @override
  String get description;
  @override
  List<String> get memberIds;
  @override
  List<String> get payoutOrder;
  @override
  int get currentPayoutIndex;
  @override
  double get totalBalance;
  @override
  double get totalContributed;
  @override
  double get totalLoaned;
  @override
  String get status;
  @override
  String? get groupImageUrl;
  @override
  String? get inviteCode;
  @override
  DateTime? get startDate;
  @override
  DateTime? get nextContributionDate;
  @override
  DateTime?
      get createdAt; // ── Loan & penalty rules ─────────────────────────────────────────────
// All use @Default so existing Firestore docs load without errors.
  @override
  double get defaultInterestRate; // % applied to every loan
  @override
  int get maxRepaymentMonths; // longest allowed duration
  @override
  double get loanPenaltyRate; // % added per late period
  @override
  int get loanPenaltyGraceDays; // days before penalty kicks in
  @override
  double get maxLoanMultiplier; // savings × this = borrow limit
  @override
  int get minContributionsForLoan; // min deposits before eligible
// ── Late-contribution fine rules ────────────────────────────────────────
  @override
  double get lateFineAmount; // RWF charged per missed period
  @override
  int get fineGraceDays;

  /// Create a copy of GroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContributionModel _$ContributionModelFromJson(Map<String, dynamic> json) {
  return _ContributionModel.fromJson(json);
}

/// @nodoc
mixin _$ContributionModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get contributionDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get receiptUrl => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get confirmedBy => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ContributionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContributionModelCopyWith<ContributionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributionModelCopyWith<$Res> {
  factory $ContributionModelCopyWith(
          ContributionModel value, $Res Function(ContributionModel) then) =
      _$ContributionModelCopyWithImpl<$Res, ContributionModel>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      DateTime contributionDate,
      String status,
      String? receiptUrl,
      String? notes,
      String? confirmedBy,
      DateTime? confirmedAt,
      DateTime? createdAt});
}

/// @nodoc
class _$ContributionModelCopyWithImpl<$Res, $Val extends ContributionModel>
    implements $ContributionModelCopyWith<$Res> {
  _$ContributionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? contributionDate = null,
    Object? status = null,
    Object? receiptUrl = freezed,
    Object? notes = freezed,
    Object? confirmedBy = freezed,
    Object? confirmedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      contributionDate: null == contributionDate
          ? _value.contributionDate
          : contributionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBy: freezed == confirmedBy
          ? _value.confirmedBy
          : confirmedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContributionModelImplCopyWith<$Res>
    implements $ContributionModelCopyWith<$Res> {
  factory _$$ContributionModelImplCopyWith(_$ContributionModelImpl value,
          $Res Function(_$ContributionModelImpl) then) =
      __$$ContributionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      DateTime contributionDate,
      String status,
      String? receiptUrl,
      String? notes,
      String? confirmedBy,
      DateTime? confirmedAt,
      DateTime? createdAt});
}

/// @nodoc
class __$$ContributionModelImplCopyWithImpl<$Res>
    extends _$ContributionModelCopyWithImpl<$Res, _$ContributionModelImpl>
    implements _$$ContributionModelImplCopyWith<$Res> {
  __$$ContributionModelImplCopyWithImpl(_$ContributionModelImpl _value,
      $Res Function(_$ContributionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? contributionDate = null,
    Object? status = null,
    Object? receiptUrl = freezed,
    Object? notes = freezed,
    Object? confirmedBy = freezed,
    Object? confirmedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ContributionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      contributionDate: null == contributionDate
          ? _value.contributionDate
          : contributionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedBy: freezed == confirmedBy
          ? _value.confirmedBy
          : confirmedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContributionModelImpl implements _ContributionModel {
  const _$ContributionModelImpl(
      {required this.id,
      required this.groupId,
      required this.memberId,
      required this.memberName,
      required this.amount,
      required this.contributionDate,
      this.status = 'completed',
      this.receiptUrl,
      this.notes,
      this.confirmedBy,
      this.confirmedAt,
      this.createdAt});

  factory _$ContributionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContributionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final double amount;
  @override
  final DateTime contributionDate;
  @override
  @JsonKey()
  final String status;
  @override
  final String? receiptUrl;
  @override
  final String? notes;
  @override
  final String? confirmedBy;
  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ContributionModel(id: $id, groupId: $groupId, memberId: $memberId, memberName: $memberName, amount: $amount, contributionDate: $contributionDate, status: $status, receiptUrl: $receiptUrl, notes: $notes, confirmedBy: $confirmedBy, confirmedAt: $confirmedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContributionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.contributionDate, contributionDate) ||
                other.contributionDate == contributionDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.confirmedBy, confirmedBy) ||
                other.confirmedBy == confirmedBy) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      memberId,
      memberName,
      amount,
      contributionDate,
      status,
      receiptUrl,
      notes,
      confirmedBy,
      confirmedAt,
      createdAt);

  /// Create a copy of ContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContributionModelImplCopyWith<_$ContributionModelImpl> get copyWith =>
      __$$ContributionModelImplCopyWithImpl<_$ContributionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContributionModelImplToJson(
      this,
    );
  }
}

abstract class _ContributionModel implements ContributionModel {
  const factory _ContributionModel(
      {required final String id,
      required final String groupId,
      required final String memberId,
      required final String memberName,
      required final double amount,
      required final DateTime contributionDate,
      final String status,
      final String? receiptUrl,
      final String? notes,
      final String? confirmedBy,
      final DateTime? confirmedAt,
      final DateTime? createdAt}) = _$ContributionModelImpl;

  factory _ContributionModel.fromJson(Map<String, dynamic> json) =
      _$ContributionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get memberId;
  @override
  String get memberName;
  @override
  double get amount;
  @override
  DateTime get contributionDate;
  @override
  String get status;
  @override
  String? get receiptUrl;
  @override
  String? get notes;
  @override
  String? get confirmedBy;
  @override
  DateTime? get confirmedAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of ContributionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContributionModelImplCopyWith<_$ContributionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) {
  return _LoanModel.fromJson(json);
}

/// @nodoc
mixin _$LoanModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get borrowerId => throw _privateConstructorUsedError;
  String get borrowerName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get interestRate => throw _privateConstructorUsedError;
  int get durationMonths => throw _privateConstructorUsedError;
  DateTime get requestedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double get amountRepaid => throw _privateConstructorUsedError;
  String? get purpose => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get fullyRepaidAt => throw _privateConstructorUsedError;

  /// Serializes this LoanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoanModelCopyWith<LoanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanModelCopyWith<$Res> {
  factory $LoanModelCopyWith(LoanModel value, $Res Function(LoanModel) then) =
      _$LoanModelCopyWithImpl<$Res, LoanModel>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String borrowerId,
      String borrowerName,
      double amount,
      double interestRate,
      int durationMonths,
      DateTime requestedAt,
      String status,
      double amountRepaid,
      String? purpose,
      String? approvedBy,
      DateTime? approvedAt,
      DateTime? dueDate,
      DateTime? fullyRepaidAt});
}

/// @nodoc
class _$LoanModelCopyWithImpl<$Res, $Val extends LoanModel>
    implements $LoanModelCopyWith<$Res> {
  _$LoanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? borrowerId = null,
    Object? borrowerName = null,
    Object? amount = null,
    Object? interestRate = null,
    Object? durationMonths = null,
    Object? requestedAt = null,
    Object? status = null,
    Object? amountRepaid = null,
    Object? purpose = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? dueDate = freezed,
    Object? fullyRepaidAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      borrowerId: null == borrowerId
          ? _value.borrowerId
          : borrowerId // ignore: cast_nullable_to_non_nullable
              as String,
      borrowerName: null == borrowerName
          ? _value.borrowerName
          : borrowerName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      durationMonths: null == durationMonths
          ? _value.durationMonths
          : durationMonths // ignore: cast_nullable_to_non_nullable
              as int,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amountRepaid: null == amountRepaid
          ? _value.amountRepaid
          : amountRepaid // ignore: cast_nullable_to_non_nullable
              as double,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fullyRepaidAt: freezed == fullyRepaidAt
          ? _value.fullyRepaidAt
          : fullyRepaidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoanModelImplCopyWith<$Res>
    implements $LoanModelCopyWith<$Res> {
  factory _$$LoanModelImplCopyWith(
          _$LoanModelImpl value, $Res Function(_$LoanModelImpl) then) =
      __$$LoanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String borrowerId,
      String borrowerName,
      double amount,
      double interestRate,
      int durationMonths,
      DateTime requestedAt,
      String status,
      double amountRepaid,
      String? purpose,
      String? approvedBy,
      DateTime? approvedAt,
      DateTime? dueDate,
      DateTime? fullyRepaidAt});
}

/// @nodoc
class __$$LoanModelImplCopyWithImpl<$Res>
    extends _$LoanModelCopyWithImpl<$Res, _$LoanModelImpl>
    implements _$$LoanModelImplCopyWith<$Res> {
  __$$LoanModelImplCopyWithImpl(
      _$LoanModelImpl _value, $Res Function(_$LoanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? borrowerId = null,
    Object? borrowerName = null,
    Object? amount = null,
    Object? interestRate = null,
    Object? durationMonths = null,
    Object? requestedAt = null,
    Object? status = null,
    Object? amountRepaid = null,
    Object? purpose = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? dueDate = freezed,
    Object? fullyRepaidAt = freezed,
  }) {
    return _then(_$LoanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      borrowerId: null == borrowerId
          ? _value.borrowerId
          : borrowerId // ignore: cast_nullable_to_non_nullable
              as String,
      borrowerName: null == borrowerName
          ? _value.borrowerName
          : borrowerName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      durationMonths: null == durationMonths
          ? _value.durationMonths
          : durationMonths // ignore: cast_nullable_to_non_nullable
              as int,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      amountRepaid: null == amountRepaid
          ? _value.amountRepaid
          : amountRepaid // ignore: cast_nullable_to_non_nullable
              as double,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fullyRepaidAt: freezed == fullyRepaidAt
          ? _value.fullyRepaidAt
          : fullyRepaidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoanModelImpl extends _LoanModel {
  const _$LoanModelImpl(
      {required this.id,
      required this.groupId,
      required this.borrowerId,
      required this.borrowerName,
      required this.amount,
      required this.interestRate,
      required this.durationMonths,
      required this.requestedAt,
      this.status = 'pending',
      this.amountRepaid = 0.0,
      this.purpose,
      this.approvedBy,
      this.approvedAt,
      this.dueDate,
      this.fullyRepaidAt})
      : super._();

  factory _$LoanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoanModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String borrowerId;
  @override
  final String borrowerName;
  @override
  final double amount;
  @override
  final double interestRate;
  @override
  final int durationMonths;
  @override
  final DateTime requestedAt;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final double amountRepaid;
  @override
  final String? purpose;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? fullyRepaidAt;

  @override
  String toString() {
    return 'LoanModel(id: $id, groupId: $groupId, borrowerId: $borrowerId, borrowerName: $borrowerName, amount: $amount, interestRate: $interestRate, durationMonths: $durationMonths, requestedAt: $requestedAt, status: $status, amountRepaid: $amountRepaid, purpose: $purpose, approvedBy: $approvedBy, approvedAt: $approvedAt, dueDate: $dueDate, fullyRepaidAt: $fullyRepaidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.borrowerId, borrowerId) ||
                other.borrowerId == borrowerId) &&
            (identical(other.borrowerName, borrowerName) ||
                other.borrowerName == borrowerName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.durationMonths, durationMonths) ||
                other.durationMonths == durationMonths) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amountRepaid, amountRepaid) ||
                other.amountRepaid == amountRepaid) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.fullyRepaidAt, fullyRepaidAt) ||
                other.fullyRepaidAt == fullyRepaidAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      borrowerId,
      borrowerName,
      amount,
      interestRate,
      durationMonths,
      requestedAt,
      status,
      amountRepaid,
      purpose,
      approvedBy,
      approvedAt,
      dueDate,
      fullyRepaidAt);

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoanModelImplCopyWith<_$LoanModelImpl> get copyWith =>
      __$$LoanModelImplCopyWithImpl<_$LoanModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoanModelImplToJson(
      this,
    );
  }
}

abstract class _LoanModel extends LoanModel {
  const factory _LoanModel(
      {required final String id,
      required final String groupId,
      required final String borrowerId,
      required final String borrowerName,
      required final double amount,
      required final double interestRate,
      required final int durationMonths,
      required final DateTime requestedAt,
      final String status,
      final double amountRepaid,
      final String? purpose,
      final String? approvedBy,
      final DateTime? approvedAt,
      final DateTime? dueDate,
      final DateTime? fullyRepaidAt}) = _$LoanModelImpl;
  const _LoanModel._() : super._();

  factory _LoanModel.fromJson(Map<String, dynamic> json) =
      _$LoanModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get borrowerId;
  @override
  String get borrowerName;
  @override
  double get amount;
  @override
  double get interestRate;
  @override
  int get durationMonths;
  @override
  DateTime get requestedAt;
  @override
  String get status;
  @override
  double get amountRepaid;
  @override
  String? get purpose;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get fullyRepaidAt;

  /// Create a copy of LoanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoanModelImplCopyWith<_$LoanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayoutModel _$PayoutModelFromJson(Map<String, dynamic> json) {
  return _PayoutModel.fromJson(json);
}

/// @nodoc
mixin _$PayoutModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  int get roundNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get scheduledDate => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;
  String? get processedBy => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this PayoutModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayoutModelCopyWith<PayoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayoutModelCopyWith<$Res> {
  factory $PayoutModelCopyWith(
          PayoutModel value, $Res Function(PayoutModel) then) =
      _$PayoutModelCopyWithImpl<$Res, PayoutModel>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      int roundNumber,
      String status,
      DateTime? scheduledDate,
      DateTime? paidAt,
      String? processedBy,
      String? notes});
}

/// @nodoc
class _$PayoutModelCopyWithImpl<$Res, $Val extends PayoutModel>
    implements $PayoutModelCopyWith<$Res> {
  _$PayoutModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? roundNumber = null,
    Object? status = null,
    Object? scheduledDate = freezed,
    Object? paidAt = freezed,
    Object? processedBy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayoutModelImplCopyWith<$Res>
    implements $PayoutModelCopyWith<$Res> {
  factory _$$PayoutModelImplCopyWith(
          _$PayoutModelImpl value, $Res Function(_$PayoutModelImpl) then) =
      __$$PayoutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      int roundNumber,
      String status,
      DateTime? scheduledDate,
      DateTime? paidAt,
      String? processedBy,
      String? notes});
}

/// @nodoc
class __$$PayoutModelImplCopyWithImpl<$Res>
    extends _$PayoutModelCopyWithImpl<$Res, _$PayoutModelImpl>
    implements _$$PayoutModelImplCopyWith<$Res> {
  __$$PayoutModelImplCopyWithImpl(
      _$PayoutModelImpl _value, $Res Function(_$PayoutModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? roundNumber = null,
    Object? status = null,
    Object? scheduledDate = freezed,
    Object? paidAt = freezed,
    Object? processedBy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$PayoutModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      roundNumber: null == roundNumber
          ? _value.roundNumber
          : roundNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledDate: freezed == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayoutModelImpl implements _PayoutModel {
  const _$PayoutModelImpl(
      {required this.id,
      required this.groupId,
      required this.memberId,
      required this.memberName,
      required this.amount,
      required this.roundNumber,
      this.status = 'pending',
      this.scheduledDate,
      this.paidAt,
      this.processedBy,
      this.notes});

  factory _$PayoutModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayoutModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final double amount;
  @override
  final int roundNumber;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? scheduledDate;
  @override
  final DateTime? paidAt;
  @override
  final String? processedBy;
  @override
  final String? notes;

  @override
  String toString() {
    return 'PayoutModel(id: $id, groupId: $groupId, memberId: $memberId, memberName: $memberName, amount: $amount, roundNumber: $roundNumber, status: $status, scheduledDate: $scheduledDate, paidAt: $paidAt, processedBy: $processedBy, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayoutModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.processedBy, processedBy) ||
                other.processedBy == processedBy) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      memberId,
      memberName,
      amount,
      roundNumber,
      status,
      scheduledDate,
      paidAt,
      processedBy,
      notes);

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayoutModelImplCopyWith<_$PayoutModelImpl> get copyWith =>
      __$$PayoutModelImplCopyWithImpl<_$PayoutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayoutModelImplToJson(
      this,
    );
  }
}

abstract class _PayoutModel implements PayoutModel {
  const factory _PayoutModel(
      {required final String id,
      required final String groupId,
      required final String memberId,
      required final String memberName,
      required final double amount,
      required final int roundNumber,
      final String status,
      final DateTime? scheduledDate,
      final DateTime? paidAt,
      final String? processedBy,
      final String? notes}) = _$PayoutModelImpl;

  factory _PayoutModel.fromJson(Map<String, dynamic> json) =
      _$PayoutModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get memberId;
  @override
  String get memberName;
  @override
  double get amount;
  @override
  int get roundNumber;
  @override
  String get status;
  @override
  DateTime? get scheduledDate;
  @override
  DateTime? get paidAt;
  @override
  String? get processedBy;
  @override
  String? get notes;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayoutModelImplCopyWith<_$PayoutModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FineModel _$FineModelFromJson(Map<String, dynamic> json) {
  return _FineModel.fromJson(json);
}

/// @nodoc
mixin _$FineModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime get issuedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;

  /// Serializes this FineModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FineModelCopyWith<FineModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FineModelCopyWith<$Res> {
  factory $FineModelCopyWith(FineModel value, $Res Function(FineModel) then) =
      _$FineModelCopyWithImpl<$Res, FineModel>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      String reason,
      DateTime issuedAt,
      String status,
      DateTime? paidAt});
}

/// @nodoc
class _$FineModelCopyWithImpl<$Res, $Val extends FineModel>
    implements $FineModelCopyWith<$Res> {
  _$FineModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FineModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? reason = null,
    Object? issuedAt = null,
    Object? status = null,
    Object? paidAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FineModelImplCopyWith<$Res>
    implements $FineModelCopyWith<$Res> {
  factory _$$FineModelImplCopyWith(
          _$FineModelImpl value, $Res Function(_$FineModelImpl) then) =
      __$$FineModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String memberId,
      String memberName,
      double amount,
      String reason,
      DateTime issuedAt,
      String status,
      DateTime? paidAt});
}

/// @nodoc
class __$$FineModelImplCopyWithImpl<$Res>
    extends _$FineModelCopyWithImpl<$Res, _$FineModelImpl>
    implements _$$FineModelImplCopyWith<$Res> {
  __$$FineModelImplCopyWithImpl(
      _$FineModelImpl _value, $Res Function(_$FineModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FineModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? memberId = null,
    Object? memberName = null,
    Object? amount = null,
    Object? reason = null,
    Object? issuedAt = null,
    Object? status = null,
    Object? paidAt = freezed,
  }) {
    return _then(_$FineModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      memberName: null == memberName
          ? _value.memberName
          : memberName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FineModelImpl implements _FineModel {
  const _$FineModelImpl(
      {required this.id,
      required this.groupId,
      required this.memberId,
      required this.memberName,
      required this.amount,
      required this.reason,
      required this.issuedAt,
      this.status = 'unpaid',
      this.paidAt});

  factory _$FineModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FineModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String memberId;
  @override
  final String memberName;
  @override
  final double amount;
  @override
  final String reason;
  @override
  final DateTime issuedAt;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? paidAt;

  @override
  String toString() {
    return 'FineModel(id: $id, groupId: $groupId, memberId: $memberId, memberName: $memberName, amount: $amount, reason: $reason, issuedAt: $issuedAt, status: $status, paidAt: $paidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FineModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, memberId,
      memberName, amount, reason, issuedAt, status, paidAt);

  /// Create a copy of FineModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FineModelImplCopyWith<_$FineModelImpl> get copyWith =>
      __$$FineModelImplCopyWithImpl<_$FineModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FineModelImplToJson(
      this,
    );
  }
}

abstract class _FineModel implements FineModel {
  const factory _FineModel(
      {required final String id,
      required final String groupId,
      required final String memberId,
      required final String memberName,
      required final double amount,
      required final String reason,
      required final DateTime issuedAt,
      final String status,
      final DateTime? paidAt}) = _$FineModelImpl;

  factory _FineModel.fromJson(Map<String, dynamic> json) =
      _$FineModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get memberId;
  @override
  String get memberName;
  @override
  double get amount;
  @override
  String get reason;
  @override
  DateTime get issuedAt;
  @override
  String get status;
  @override
  DateTime? get paidAt;

  /// Create a copy of FineModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FineModelImplCopyWith<_$FineModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  String? get groupId => throw _privateConstructorUsedError;
  String? get actionId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) then) =
      _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      bool isRead,
      String? groupId,
      String? actionId,
      DateTime? createdAt});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? isRead = null,
    Object? groupId = freezed,
    Object? actionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      actionId: freezed == actionId
          ? _value.actionId
          : actionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(_$AppNotificationImpl value,
          $Res Function(_$AppNotificationImpl) then) =
      __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      bool isRead,
      String? groupId,
      String? actionId,
      DateTime? createdAt});
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
      _$AppNotificationImpl _value, $Res Function(_$AppNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? isRead = null,
    Object? groupId = freezed,
    Object? actionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AppNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      actionId: freezed == actionId
          ? _value.actionId
          : actionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.type,
      this.isRead = false,
      this.groupId,
      this.actionId,
      this.createdAt});

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final String? groupId;
  @override
  final String? actionId;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AppNotification(id: $id, userId: $userId, title: $title, body: $body, type: $type, isRead: $isRead, groupId: $groupId, actionId: $actionId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.actionId, actionId) ||
                other.actionId == actionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, title, body, type,
      isRead, groupId, actionId, createdAt);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(
      this,
    );
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification(
      {required final String id,
      required final String userId,
      required final String title,
      required final String body,
      required final String type,
      final bool isRead,
      final String? groupId,
      final String? actionId,
      final DateTime? createdAt}) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get body;
  @override
  String get type;
  @override
  bool get isRead;
  @override
  String? get groupId;
  @override
  String? get actionId;
  @override
  DateTime? get createdAt;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvitationModel _$InvitationModelFromJson(Map<String, dynamic> json) {
  return _InvitationModel.fromJson(json);
}

/// @nodoc
mixin _$InvitationModel {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  String get inviteCode => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this InvitationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationModelCopyWith<InvitationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationModelCopyWith<$Res> {
  factory $InvitationModelCopyWith(
          InvitationModel value, $Res Function(InvitationModel) then) =
      _$InvitationModelCopyWithImpl<$Res, InvitationModel>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String groupName,
      String invitedBy,
      String inviteCode,
      String status,
      DateTime? createdAt,
      DateTime? expiresAt});
}

/// @nodoc
class _$InvitationModelCopyWithImpl<$Res, $Val extends InvitationModel>
    implements $InvitationModelCopyWith<$Res> {
  _$InvitationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? groupName = null,
    Object? invitedBy = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationModelImplCopyWith<$Res>
    implements $InvitationModelCopyWith<$Res> {
  factory _$$InvitationModelImplCopyWith(_$InvitationModelImpl value,
          $Res Function(_$InvitationModelImpl) then) =
      __$$InvitationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String groupName,
      String invitedBy,
      String inviteCode,
      String status,
      DateTime? createdAt,
      DateTime? expiresAt});
}

/// @nodoc
class __$$InvitationModelImplCopyWithImpl<$Res>
    extends _$InvitationModelCopyWithImpl<$Res, _$InvitationModelImpl>
    implements _$$InvitationModelImplCopyWith<$Res> {
  __$$InvitationModelImplCopyWithImpl(
      _$InvitationModelImpl _value, $Res Function(_$InvitationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? groupName = null,
    Object? invitedBy = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$InvitationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      invitedBy: null == invitedBy
          ? _value.invitedBy
          : invitedBy // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationModelImpl implements _InvitationModel {
  const _$InvitationModelImpl(
      {required this.id,
      required this.groupId,
      required this.groupName,
      required this.invitedBy,
      required this.inviteCode,
      this.status = 'pending',
      this.createdAt,
      this.expiresAt});

  factory _$InvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String groupName;
  @override
  final String invitedBy;
  @override
  final String inviteCode;
  @override
  @JsonKey()
  final String status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'InvitationModel(id: $id, groupId: $groupId, groupName: $groupName, invitedBy: $invitedBy, inviteCode: $inviteCode, status: $status, createdAt: $createdAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, groupName,
      invitedBy, inviteCode, status, createdAt, expiresAt);

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      __$$InvitationModelImplCopyWithImpl<_$InvitationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationModelImplToJson(
      this,
    );
  }
}

abstract class _InvitationModel implements InvitationModel {
  const factory _InvitationModel(
      {required final String id,
      required final String groupId,
      required final String groupName,
      required final String invitedBy,
      required final String inviteCode,
      final String status,
      final DateTime? createdAt,
      final DateTime? expiresAt}) = _$InvitationModelImpl;

  factory _InvitationModel.fromJson(Map<String, dynamic> json) =
      _$InvitationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get groupName;
  @override
  String get invitedBy;
  @override
  String get inviteCode;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get expiresAt;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DashboardStats {
  int get totalGroups => throw _privateConstructorUsedError;
  double get totalSaved => throw _privateConstructorUsedError;
  double get totalLoaned => throw _privateConstructorUsedError;
  double get pendingFines => throw _privateConstructorUsedError;
  double get nextPayoutAmount => throw _privateConstructorUsedError;
  DateTime? get nextPayoutDate => throw _privateConstructorUsedError;
  List<ChartDataPoint> get contributionTrend =>
      throw _privateConstructorUsedError;
  List<ChartDataPoint> get savingsTrend => throw _privateConstructorUsedError;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStatsCopyWith<DashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsCopyWith<$Res> {
  factory $DashboardStatsCopyWith(
          DashboardStats value, $Res Function(DashboardStats) then) =
      _$DashboardStatsCopyWithImpl<$Res, DashboardStats>;
  @useResult
  $Res call(
      {int totalGroups,
      double totalSaved,
      double totalLoaned,
      double pendingFines,
      double nextPayoutAmount,
      DateTime? nextPayoutDate,
      List<ChartDataPoint> contributionTrend,
      List<ChartDataPoint> savingsTrend});
}

/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res, $Val extends DashboardStats>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGroups = null,
    Object? totalSaved = null,
    Object? totalLoaned = null,
    Object? pendingFines = null,
    Object? nextPayoutAmount = null,
    Object? nextPayoutDate = freezed,
    Object? contributionTrend = null,
    Object? savingsTrend = null,
  }) {
    return _then(_value.copyWith(
      totalGroups: null == totalGroups
          ? _value.totalGroups
          : totalGroups // ignore: cast_nullable_to_non_nullable
              as int,
      totalSaved: null == totalSaved
          ? _value.totalSaved
          : totalSaved // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoaned: null == totalLoaned
          ? _value.totalLoaned
          : totalLoaned // ignore: cast_nullable_to_non_nullable
              as double,
      pendingFines: null == pendingFines
          ? _value.pendingFines
          : pendingFines // ignore: cast_nullable_to_non_nullable
              as double,
      nextPayoutAmount: null == nextPayoutAmount
          ? _value.nextPayoutAmount
          : nextPayoutAmount // ignore: cast_nullable_to_non_nullable
              as double,
      nextPayoutDate: freezed == nextPayoutDate
          ? _value.nextPayoutDate
          : nextPayoutDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      contributionTrend: null == contributionTrend
          ? _value.contributionTrend
          : contributionTrend // ignore: cast_nullable_to_non_nullable
              as List<ChartDataPoint>,
      savingsTrend: null == savingsTrend
          ? _value.savingsTrend
          : savingsTrend // ignore: cast_nullable_to_non_nullable
              as List<ChartDataPoint>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStatsImplCopyWith<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  factory _$$DashboardStatsImplCopyWith(_$DashboardStatsImpl value,
          $Res Function(_$DashboardStatsImpl) then) =
      __$$DashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalGroups,
      double totalSaved,
      double totalLoaned,
      double pendingFines,
      double nextPayoutAmount,
      DateTime? nextPayoutDate,
      List<ChartDataPoint> contributionTrend,
      List<ChartDataPoint> savingsTrend});
}

/// @nodoc
class __$$DashboardStatsImplCopyWithImpl<$Res>
    extends _$DashboardStatsCopyWithImpl<$Res, _$DashboardStatsImpl>
    implements _$$DashboardStatsImplCopyWith<$Res> {
  __$$DashboardStatsImplCopyWithImpl(
      _$DashboardStatsImpl _value, $Res Function(_$DashboardStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalGroups = null,
    Object? totalSaved = null,
    Object? totalLoaned = null,
    Object? pendingFines = null,
    Object? nextPayoutAmount = null,
    Object? nextPayoutDate = freezed,
    Object? contributionTrend = null,
    Object? savingsTrend = null,
  }) {
    return _then(_$DashboardStatsImpl(
      totalGroups: null == totalGroups
          ? _value.totalGroups
          : totalGroups // ignore: cast_nullable_to_non_nullable
              as int,
      totalSaved: null == totalSaved
          ? _value.totalSaved
          : totalSaved // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoaned: null == totalLoaned
          ? _value.totalLoaned
          : totalLoaned // ignore: cast_nullable_to_non_nullable
              as double,
      pendingFines: null == pendingFines
          ? _value.pendingFines
          : pendingFines // ignore: cast_nullable_to_non_nullable
              as double,
      nextPayoutAmount: null == nextPayoutAmount
          ? _value.nextPayoutAmount
          : nextPayoutAmount // ignore: cast_nullable_to_non_nullable
              as double,
      nextPayoutDate: freezed == nextPayoutDate
          ? _value.nextPayoutDate
          : nextPayoutDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      contributionTrend: null == contributionTrend
          ? _value._contributionTrend
          : contributionTrend // ignore: cast_nullable_to_non_nullable
              as List<ChartDataPoint>,
      savingsTrend: null == savingsTrend
          ? _value._savingsTrend
          : savingsTrend // ignore: cast_nullable_to_non_nullable
              as List<ChartDataPoint>,
    ));
  }
}

/// @nodoc

class _$DashboardStatsImpl implements _DashboardStats {
  const _$DashboardStatsImpl(
      {this.totalGroups = 0,
      this.totalSaved = 0.0,
      this.totalLoaned = 0.0,
      this.pendingFines = 0.0,
      this.nextPayoutAmount = 0.0,
      this.nextPayoutDate,
      final List<ChartDataPoint> contributionTrend = const [],
      final List<ChartDataPoint> savingsTrend = const []})
      : _contributionTrend = contributionTrend,
        _savingsTrend = savingsTrend;

  @override
  @JsonKey()
  final int totalGroups;
  @override
  @JsonKey()
  final double totalSaved;
  @override
  @JsonKey()
  final double totalLoaned;
  @override
  @JsonKey()
  final double pendingFines;
  @override
  @JsonKey()
  final double nextPayoutAmount;
  @override
  final DateTime? nextPayoutDate;
  final List<ChartDataPoint> _contributionTrend;
  @override
  @JsonKey()
  List<ChartDataPoint> get contributionTrend {
    if (_contributionTrend is EqualUnmodifiableListView)
      return _contributionTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributionTrend);
  }

  final List<ChartDataPoint> _savingsTrend;
  @override
  @JsonKey()
  List<ChartDataPoint> get savingsTrend {
    if (_savingsTrend is EqualUnmodifiableListView) return _savingsTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savingsTrend);
  }

  @override
  String toString() {
    return 'DashboardStats(totalGroups: $totalGroups, totalSaved: $totalSaved, totalLoaned: $totalLoaned, pendingFines: $pendingFines, nextPayoutAmount: $nextPayoutAmount, nextPayoutDate: $nextPayoutDate, contributionTrend: $contributionTrend, savingsTrend: $savingsTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsImpl &&
            (identical(other.totalGroups, totalGroups) ||
                other.totalGroups == totalGroups) &&
            (identical(other.totalSaved, totalSaved) ||
                other.totalSaved == totalSaved) &&
            (identical(other.totalLoaned, totalLoaned) ||
                other.totalLoaned == totalLoaned) &&
            (identical(other.pendingFines, pendingFines) ||
                other.pendingFines == pendingFines) &&
            (identical(other.nextPayoutAmount, nextPayoutAmount) ||
                other.nextPayoutAmount == nextPayoutAmount) &&
            (identical(other.nextPayoutDate, nextPayoutDate) ||
                other.nextPayoutDate == nextPayoutDate) &&
            const DeepCollectionEquality()
                .equals(other._contributionTrend, _contributionTrend) &&
            const DeepCollectionEquality()
                .equals(other._savingsTrend, _savingsTrend));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalGroups,
      totalSaved,
      totalLoaned,
      pendingFines,
      nextPayoutAmount,
      nextPayoutDate,
      const DeepCollectionEquality().hash(_contributionTrend),
      const DeepCollectionEquality().hash(_savingsTrend));

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      __$$DashboardStatsImplCopyWithImpl<_$DashboardStatsImpl>(
          this, _$identity);
}

abstract class _DashboardStats implements DashboardStats {
  const factory _DashboardStats(
      {final int totalGroups,
      final double totalSaved,
      final double totalLoaned,
      final double pendingFines,
      final double nextPayoutAmount,
      final DateTime? nextPayoutDate,
      final List<ChartDataPoint> contributionTrend,
      final List<ChartDataPoint> savingsTrend}) = _$DashboardStatsImpl;

  @override
  int get totalGroups;
  @override
  double get totalSaved;
  @override
  double get totalLoaned;
  @override
  double get pendingFines;
  @override
  double get nextPayoutAmount;
  @override
  DateTime? get nextPayoutDate;
  @override
  List<ChartDataPoint> get contributionTrend;
  @override
  List<ChartDataPoint> get savingsTrend;

  /// Create a copy of DashboardStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChartDataPoint _$ChartDataPointFromJson(Map<String, dynamic> json) {
  return _ChartDataPoint.fromJson(json);
}

/// @nodoc
mixin _$ChartDataPoint {
  String get label => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Serializes this ChartDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartDataPointCopyWith<ChartDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataPointCopyWith<$Res> {
  factory $ChartDataPointCopyWith(
          ChartDataPoint value, $Res Function(ChartDataPoint) then) =
      _$ChartDataPointCopyWithImpl<$Res, ChartDataPoint>;
  @useResult
  $Res call({String label, double value, DateTime? date});
}

/// @nodoc
class _$ChartDataPointCopyWithImpl<$Res, $Val extends ChartDataPoint>
    implements $ChartDataPointCopyWith<$Res> {
  _$ChartDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartDataPointImplCopyWith<$Res>
    implements $ChartDataPointCopyWith<$Res> {
  factory _$$ChartDataPointImplCopyWith(_$ChartDataPointImpl value,
          $Res Function(_$ChartDataPointImpl) then) =
      __$$ChartDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, double value, DateTime? date});
}

/// @nodoc
class __$$ChartDataPointImplCopyWithImpl<$Res>
    extends _$ChartDataPointCopyWithImpl<$Res, _$ChartDataPointImpl>
    implements _$$ChartDataPointImplCopyWith<$Res> {
  __$$ChartDataPointImplCopyWithImpl(
      _$ChartDataPointImpl _value, $Res Function(_$ChartDataPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? value = null,
    Object? date = freezed,
  }) {
    return _then(_$ChartDataPointImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartDataPointImpl implements _ChartDataPoint {
  const _$ChartDataPointImpl(
      {required this.label, required this.value, this.date});

  factory _$ChartDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartDataPointImplFromJson(json);

  @override
  final String label;
  @override
  final double value;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'ChartDataPoint(label: $label, value: $value, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataPointImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, value, date);

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataPointImplCopyWith<_$ChartDataPointImpl> get copyWith =>
      __$$ChartDataPointImplCopyWithImpl<_$ChartDataPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartDataPointImplToJson(
      this,
    );
  }
}

abstract class _ChartDataPoint implements ChartDataPoint {
  const factory _ChartDataPoint(
      {required final String label,
      required final double value,
      final DateTime? date}) = _$ChartDataPointImpl;

  factory _ChartDataPoint.fromJson(Map<String, dynamic> json) =
      _$ChartDataPointImpl.fromJson;

  @override
  String get label;
  @override
  double get value;
  @override
  DateTime? get date;

  /// Create a copy of ChartDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataPointImplCopyWith<_$ChartDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupBroadcast _$GroupBroadcastFromJson(Map<String, dynamic> json) {
  return _GroupBroadcast.fromJson(json);
}

/// @nodoc
mixin _$GroupBroadcast {
  String get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  Map<String, String> get reactions => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GroupBroadcast to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupBroadcast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupBroadcastCopyWith<GroupBroadcast> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupBroadcastCopyWith<$Res> {
  factory $GroupBroadcastCopyWith(
          GroupBroadcast value, $Res Function(GroupBroadcast) then) =
      _$GroupBroadcastCopyWithImpl<$Res, GroupBroadcast>;
  @useResult
  $Res call(
      {String id,
      String groupId,
      String groupName,
      String title,
      String message,
      String senderId,
      String senderName,
      Map<String, String> reactions,
      DateTime? createdAt});
}

/// @nodoc
class _$GroupBroadcastCopyWithImpl<$Res, $Val extends GroupBroadcast>
    implements $GroupBroadcastCopyWith<$Res> {
  _$GroupBroadcastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupBroadcast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? groupName = null,
    Object? title = null,
    Object? message = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? reactions = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupBroadcastImplCopyWith<$Res>
    implements $GroupBroadcastCopyWith<$Res> {
  factory _$$GroupBroadcastImplCopyWith(_$GroupBroadcastImpl value,
          $Res Function(_$GroupBroadcastImpl) then) =
      __$$GroupBroadcastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String groupId,
      String groupName,
      String title,
      String message,
      String senderId,
      String senderName,
      Map<String, String> reactions,
      DateTime? createdAt});
}

/// @nodoc
class __$$GroupBroadcastImplCopyWithImpl<$Res>
    extends _$GroupBroadcastCopyWithImpl<$Res, _$GroupBroadcastImpl>
    implements _$$GroupBroadcastImplCopyWith<$Res> {
  __$$GroupBroadcastImplCopyWithImpl(
      _$GroupBroadcastImpl _value, $Res Function(_$GroupBroadcastImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupBroadcast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? groupName = null,
    Object? title = null,
    Object? message = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? reactions = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$GroupBroadcastImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupBroadcastImpl implements _GroupBroadcast {
  const _$GroupBroadcastImpl(
      {required this.id,
      required this.groupId,
      required this.groupName,
      required this.title,
      required this.message,
      required this.senderId,
      required this.senderName,
      final Map<String, String> reactions = const {},
      this.createdAt})
      : _reactions = reactions;

  factory _$GroupBroadcastImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupBroadcastImplFromJson(json);

  @override
  final String id;
  @override
  final String groupId;
  @override
  final String groupName;
  @override
  final String title;
  @override
  final String message;
  @override
  final String senderId;
  @override
  final String senderName;
  final Map<String, String> _reactions;
  @override
  @JsonKey()
  Map<String, String> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GroupBroadcast(id: $id, groupId: $groupId, groupName: $groupName, title: $title, message: $message, senderId: $senderId, senderName: $senderName, reactions: $reactions, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupBroadcastImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      groupId,
      groupName,
      title,
      message,
      senderId,
      senderName,
      const DeepCollectionEquality().hash(_reactions),
      createdAt);

  /// Create a copy of GroupBroadcast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupBroadcastImplCopyWith<_$GroupBroadcastImpl> get copyWith =>
      __$$GroupBroadcastImplCopyWithImpl<_$GroupBroadcastImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupBroadcastImplToJson(
      this,
    );
  }
}

abstract class _GroupBroadcast implements GroupBroadcast {
  const factory _GroupBroadcast(
      {required final String id,
      required final String groupId,
      required final String groupName,
      required final String title,
      required final String message,
      required final String senderId,
      required final String senderName,
      final Map<String, String> reactions,
      final DateTime? createdAt}) = _$GroupBroadcastImpl;

  factory _GroupBroadcast.fromJson(Map<String, dynamic> json) =
      _$GroupBroadcastImpl.fromJson;

  @override
  String get id;
  @override
  String get groupId;
  @override
  String get groupName;
  @override
  String get title;
  @override
  String get message;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  Map<String, String> get reactions;
  @override
  DateTime? get createdAt;

  /// Create a copy of GroupBroadcast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupBroadcastImplCopyWith<_$GroupBroadcastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
