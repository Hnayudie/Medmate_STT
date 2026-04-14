// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get hypothesisType => throw _privateConstructorUsedError;
  UserPermissions get permissions => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String role,
      String hypothesisType,
      UserPermissions permissions});

  $UserPermissionsCopyWith<$Res> get permissions;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? role = null,
    Object? hypothesisType = null,
    Object? permissions = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      hypothesisType: null == hypothesisType
          ? _value.hypothesisType
          : hypothesisType // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as UserPermissions,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPermissionsCopyWith<$Res> get permissions {
    return $UserPermissionsCopyWith<$Res>(_value.permissions, (value) {
      return _then(_value.copyWith(permissions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      String role,
      String hypothesisType,
      UserPermissions permissions});

  @override
  $UserPermissionsCopyWith<$Res> get permissions;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? role = null,
    Object? hypothesisType = null,
    Object? permissions = null,
  }) {
    return _then(_$UserProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      hypothesisType: null == hypothesisType
          ? _value.hypothesisType
          : hypothesisType // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as UserPermissions,
    ));
  }
}

/// @nodoc

class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {this.id = '',
      this.email = '',
      this.name = '',
      this.role = '',
      this.hypothesisType = '',
      this.permissions = const UserPermissions()});

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey()
  final String hypothesisType;
  @override
  @JsonKey()
  final UserPermissions permissions;

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, name: $name, role: $role, hypothesisType: $hypothesisType, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.hypothesisType, hypothesisType) ||
                other.hypothesisType == hypothesisType) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, name, role, hypothesisType, permissions);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {final String id,
      final String email,
      final String name,
      final String role,
      final String hypothesisType,
      final UserPermissions permissions}) = _$UserProfileImpl;

  @override
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  String get role;
  @override
  String get hypothesisType;
  @override
  UserPermissions get permissions;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserPermissions {
  bool get canViewDashboard => throw _privateConstructorUsedError;
  bool get canUseAi => throw _privateConstructorUsedError;
  bool get canCreateCase => throw _privateConstructorUsedError;
  bool get canShareLibrary => throw _privateConstructorUsedError;
  bool get canAccessShared => throw _privateConstructorUsedError;
  bool get canViewSoapNote => throw _privateConstructorUsedError;
  bool get canViewCaseLibrary => throw _privateConstructorUsedError;
  bool get canUseVoiceToText => throw _privateConstructorUsedError;
  bool get canUseHypothesisSttReplaceAll => throw _privateConstructorUsedError;

  /// Create a copy of UserPermissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPermissionsCopyWith<UserPermissions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPermissionsCopyWith<$Res> {
  factory $UserPermissionsCopyWith(
          UserPermissions value, $Res Function(UserPermissions) then) =
      _$UserPermissionsCopyWithImpl<$Res, UserPermissions>;
  @useResult
  $Res call(
      {bool canViewDashboard,
      bool canUseAi,
      bool canCreateCase,
      bool canShareLibrary,
      bool canAccessShared,
      bool canViewSoapNote,
      bool canViewCaseLibrary,
      bool canUseVoiceToText,
      bool canUseHypothesisSttReplaceAll});
}

/// @nodoc
class _$UserPermissionsCopyWithImpl<$Res, $Val extends UserPermissions>
    implements $UserPermissionsCopyWith<$Res> {
  _$UserPermissionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPermissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canViewDashboard = null,
    Object? canUseAi = null,
    Object? canCreateCase = null,
    Object? canShareLibrary = null,
    Object? canAccessShared = null,
    Object? canViewSoapNote = null,
    Object? canViewCaseLibrary = null,
    Object? canUseVoiceToText = null,
    Object? canUseHypothesisSttReplaceAll = null,
  }) {
    return _then(_value.copyWith(
      canViewDashboard: null == canViewDashboard
          ? _value.canViewDashboard
          : canViewDashboard // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseAi: null == canUseAi
          ? _value.canUseAi
          : canUseAi // ignore: cast_nullable_to_non_nullable
              as bool,
      canCreateCase: null == canCreateCase
          ? _value.canCreateCase
          : canCreateCase // ignore: cast_nullable_to_non_nullable
              as bool,
      canShareLibrary: null == canShareLibrary
          ? _value.canShareLibrary
          : canShareLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      canAccessShared: null == canAccessShared
          ? _value.canAccessShared
          : canAccessShared // ignore: cast_nullable_to_non_nullable
              as bool,
      canViewSoapNote: null == canViewSoapNote
          ? _value.canViewSoapNote
          : canViewSoapNote // ignore: cast_nullable_to_non_nullable
              as bool,
      canViewCaseLibrary: null == canViewCaseLibrary
          ? _value.canViewCaseLibrary
          : canViewCaseLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseVoiceToText: null == canUseVoiceToText
          ? _value.canUseVoiceToText
          : canUseVoiceToText // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseHypothesisSttReplaceAll: null == canUseHypothesisSttReplaceAll
          ? _value.canUseHypothesisSttReplaceAll
          : canUseHypothesisSttReplaceAll // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPermissionsImplCopyWith<$Res>
    implements $UserPermissionsCopyWith<$Res> {
  factory _$$UserPermissionsImplCopyWith(_$UserPermissionsImpl value,
          $Res Function(_$UserPermissionsImpl) then) =
      __$$UserPermissionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool canViewDashboard,
      bool canUseAi,
      bool canCreateCase,
      bool canShareLibrary,
      bool canAccessShared,
      bool canViewSoapNote,
      bool canViewCaseLibrary,
      bool canUseVoiceToText,
      bool canUseHypothesisSttReplaceAll});
}

/// @nodoc
class __$$UserPermissionsImplCopyWithImpl<$Res>
    extends _$UserPermissionsCopyWithImpl<$Res, _$UserPermissionsImpl>
    implements _$$UserPermissionsImplCopyWith<$Res> {
  __$$UserPermissionsImplCopyWithImpl(
      _$UserPermissionsImpl _value, $Res Function(_$UserPermissionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPermissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canViewDashboard = null,
    Object? canUseAi = null,
    Object? canCreateCase = null,
    Object? canShareLibrary = null,
    Object? canAccessShared = null,
    Object? canViewSoapNote = null,
    Object? canViewCaseLibrary = null,
    Object? canUseVoiceToText = null,
    Object? canUseHypothesisSttReplaceAll = null,
  }) {
    return _then(_$UserPermissionsImpl(
      canViewDashboard: null == canViewDashboard
          ? _value.canViewDashboard
          : canViewDashboard // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseAi: null == canUseAi
          ? _value.canUseAi
          : canUseAi // ignore: cast_nullable_to_non_nullable
              as bool,
      canCreateCase: null == canCreateCase
          ? _value.canCreateCase
          : canCreateCase // ignore: cast_nullable_to_non_nullable
              as bool,
      canShareLibrary: null == canShareLibrary
          ? _value.canShareLibrary
          : canShareLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      canAccessShared: null == canAccessShared
          ? _value.canAccessShared
          : canAccessShared // ignore: cast_nullable_to_non_nullable
              as bool,
      canViewSoapNote: null == canViewSoapNote
          ? _value.canViewSoapNote
          : canViewSoapNote // ignore: cast_nullable_to_non_nullable
              as bool,
      canViewCaseLibrary: null == canViewCaseLibrary
          ? _value.canViewCaseLibrary
          : canViewCaseLibrary // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseVoiceToText: null == canUseVoiceToText
          ? _value.canUseVoiceToText
          : canUseVoiceToText // ignore: cast_nullable_to_non_nullable
              as bool,
      canUseHypothesisSttReplaceAll: null == canUseHypothesisSttReplaceAll
          ? _value.canUseHypothesisSttReplaceAll
          : canUseHypothesisSttReplaceAll // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserPermissionsImpl implements _UserPermissions {
  const _$UserPermissionsImpl(
      {this.canViewDashboard = false,
      this.canUseAi = false,
      this.canCreateCase = false,
      this.canShareLibrary = false,
      this.canAccessShared = false,
      this.canViewSoapNote = false,
      this.canViewCaseLibrary = false,
      this.canUseVoiceToText = false,
      this.canUseHypothesisSttReplaceAll = false});

  @override
  @JsonKey()
  final bool canViewDashboard;
  @override
  @JsonKey()
  final bool canUseAi;
  @override
  @JsonKey()
  final bool canCreateCase;
  @override
  @JsonKey()
  final bool canShareLibrary;
  @override
  @JsonKey()
  final bool canAccessShared;
  @override
  @JsonKey()
  final bool canViewSoapNote;
  @override
  @JsonKey()
  final bool canViewCaseLibrary;
  @override
  @JsonKey()
  final bool canUseVoiceToText;
  @override
  @JsonKey()
  final bool canUseHypothesisSttReplaceAll;

  @override
  String toString() {
    return 'UserPermissions(canViewDashboard: $canViewDashboard, canUseAi: $canUseAi, canCreateCase: $canCreateCase, canShareLibrary: $canShareLibrary, canAccessShared: $canAccessShared, canViewSoapNote: $canViewSoapNote, canViewCaseLibrary: $canViewCaseLibrary, canUseVoiceToText: $canUseVoiceToText, canUseHypothesisSttReplaceAll: $canUseHypothesisSttReplaceAll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPermissionsImpl &&
            (identical(other.canViewDashboard, canViewDashboard) ||
                other.canViewDashboard == canViewDashboard) &&
            (identical(other.canUseAi, canUseAi) ||
                other.canUseAi == canUseAi) &&
            (identical(other.canCreateCase, canCreateCase) ||
                other.canCreateCase == canCreateCase) &&
            (identical(other.canShareLibrary, canShareLibrary) ||
                other.canShareLibrary == canShareLibrary) &&
            (identical(other.canAccessShared, canAccessShared) ||
                other.canAccessShared == canAccessShared) &&
            (identical(other.canViewSoapNote, canViewSoapNote) ||
                other.canViewSoapNote == canViewSoapNote) &&
            (identical(other.canViewCaseLibrary, canViewCaseLibrary) ||
                other.canViewCaseLibrary == canViewCaseLibrary) &&
            (identical(other.canUseVoiceToText, canUseVoiceToText) ||
                other.canUseVoiceToText == canUseVoiceToText) &&
            (identical(other.canUseHypothesisSttReplaceAll,
                    canUseHypothesisSttReplaceAll) ||
                other.canUseHypothesisSttReplaceAll ==
                    canUseHypothesisSttReplaceAll));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      canViewDashboard,
      canUseAi,
      canCreateCase,
      canShareLibrary,
      canAccessShared,
      canViewSoapNote,
      canViewCaseLibrary,
      canUseVoiceToText,
      canUseHypothesisSttReplaceAll);

  /// Create a copy of UserPermissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPermissionsImplCopyWith<_$UserPermissionsImpl> get copyWith =>
      __$$UserPermissionsImplCopyWithImpl<_$UserPermissionsImpl>(
          this, _$identity);
}

abstract class _UserPermissions implements UserPermissions {
  const factory _UserPermissions(
      {final bool canViewDashboard,
      final bool canUseAi,
      final bool canCreateCase,
      final bool canShareLibrary,
      final bool canAccessShared,
      final bool canViewSoapNote,
      final bool canViewCaseLibrary,
      final bool canUseVoiceToText,
      final bool canUseHypothesisSttReplaceAll}) = _$UserPermissionsImpl;

  @override
  bool get canViewDashboard;
  @override
  bool get canUseAi;
  @override
  bool get canCreateCase;
  @override
  bool get canShareLibrary;
  @override
  bool get canAccessShared;
  @override
  bool get canViewSoapNote;
  @override
  bool get canViewCaseLibrary;
  @override
  bool get canUseVoiceToText;
  @override
  bool get canUseHypothesisSttReplaceAll;

  /// Create a copy of UserPermissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPermissionsImplCopyWith<_$UserPermissionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
