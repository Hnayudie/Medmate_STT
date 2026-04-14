// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfileRaw _$UserProfileRawFromJson(Map<String, dynamic> json) {
  return _UserProfileRaw.fromJson(json);
}

/// @nodoc
mixin _$UserProfileRaw {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'role')
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'hypothesis_type')
  String get hypothesisType => throw _privateConstructorUsedError;
  UserPermissionsRaw get permissions => throw _privateConstructorUsedError;

  /// Serializes this UserProfileRaw to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileRawCopyWith<UserProfileRaw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileRawCopyWith<$Res> {
  factory $UserProfileRawCopyWith(
          UserProfileRaw value, $Res Function(UserProfileRaw) then) =
      _$UserProfileRawCopyWithImpl<$Res, UserProfileRaw>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'hypothesis_type') String hypothesisType,
      UserPermissionsRaw permissions});

  $UserPermissionsRawCopyWith<$Res> get permissions;
}

/// @nodoc
class _$UserProfileRawCopyWithImpl<$Res, $Val extends UserProfileRaw>
    implements $UserProfileRawCopyWith<$Res> {
  _$UserProfileRawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileRaw
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
              as UserPermissionsRaw,
    ) as $Val);
  }

  /// Create a copy of UserProfileRaw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserPermissionsRawCopyWith<$Res> get permissions {
    return $UserPermissionsRawCopyWith<$Res>(_value.permissions, (value) {
      return _then(_value.copyWith(permissions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileRawImplCopyWith<$Res>
    implements $UserProfileRawCopyWith<$Res> {
  factory _$$UserProfileRawImplCopyWith(_$UserProfileRawImpl value,
          $Res Function(_$UserProfileRawImpl) then) =
      __$$UserProfileRawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'hypothesis_type') String hypothesisType,
      UserPermissionsRaw permissions});

  @override
  $UserPermissionsRawCopyWith<$Res> get permissions;
}

/// @nodoc
class __$$UserProfileRawImplCopyWithImpl<$Res>
    extends _$UserProfileRawCopyWithImpl<$Res, _$UserProfileRawImpl>
    implements _$$UserProfileRawImplCopyWith<$Res> {
  __$$UserProfileRawImplCopyWithImpl(
      _$UserProfileRawImpl _value, $Res Function(_$UserProfileRawImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileRaw
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
    return _then(_$UserProfileRawImpl(
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
              as UserPermissionsRaw,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileRawImpl implements _UserProfileRaw {
  const _$UserProfileRawImpl(
      {@JsonKey(name: 'id') this.id = '',
      @JsonKey(name: 'email') this.email = '',
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'role') this.role = '',
      @JsonKey(name: 'hypothesis_type') this.hypothesisType = '',
      this.permissions = const UserPermissionsRaw()});

  factory _$UserProfileRawImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileRawImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'role')
  final String role;
  @override
  @JsonKey(name: 'hypothesis_type')
  final String hypothesisType;
  @override
  @JsonKey()
  final UserPermissionsRaw permissions;

  @override
  String toString() {
    return 'UserProfileRaw(id: $id, email: $email, name: $name, role: $role, hypothesisType: $hypothesisType, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileRawImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.hypothesisType, hypothesisType) ||
                other.hypothesisType == hypothesisType) &&
            (identical(other.permissions, permissions) ||
                other.permissions == permissions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, name, role, hypothesisType, permissions);

  /// Create a copy of UserProfileRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileRawImplCopyWith<_$UserProfileRawImpl> get copyWith =>
      __$$UserProfileRawImplCopyWithImpl<_$UserProfileRawImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileRawImplToJson(
      this,
    );
  }
}

abstract class _UserProfileRaw implements UserProfileRaw {
  const factory _UserProfileRaw(
      {@JsonKey(name: 'id') final String id,
      @JsonKey(name: 'email') final String email,
      @JsonKey(name: 'name') final String name,
      @JsonKey(name: 'role') final String role,
      @JsonKey(name: 'hypothesis_type') final String hypothesisType,
      final UserPermissionsRaw permissions}) = _$UserProfileRawImpl;

  factory _UserProfileRaw.fromJson(Map<String, dynamic> json) =
      _$UserProfileRawImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'role')
  String get role;
  @override
  @JsonKey(name: 'hypothesis_type')
  String get hypothesisType;
  @override
  UserPermissionsRaw get permissions;

  /// Create a copy of UserProfileRaw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileRawImplCopyWith<_$UserProfileRawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPermissionsRaw _$UserPermissionsRawFromJson(Map<String, dynamic> json) {
  return _UserPermissionsRaw.fromJson(json);
}

/// @nodoc
mixin _$UserPermissionsRaw {
  @JsonKey(name: 'can_view_dashboard')
  bool get canViewDashboard => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_use_ai')
  bool get canUseAi => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_create_case')
  bool get canCreateCase => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_share_library')
  bool get canShareLibrary => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_access_shared')
  bool get canAccessShared => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_view_soapnote')
  bool get canViewSoapNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_view_case_library')
  bool get canViewCaseLibrary => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_use_voice_to_text')
  bool get canUseVoiceToText => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
  bool get canUseHypothesisSttReplaceAll => throw _privateConstructorUsedError;

  /// Serializes this UserPermissionsRaw to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPermissionsRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPermissionsRawCopyWith<UserPermissionsRaw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPermissionsRawCopyWith<$Res> {
  factory $UserPermissionsRawCopyWith(
          UserPermissionsRaw value, $Res Function(UserPermissionsRaw) then) =
      _$UserPermissionsRawCopyWithImpl<$Res, UserPermissionsRaw>;
  @useResult
  $Res call(
      {@JsonKey(name: 'can_view_dashboard') bool canViewDashboard,
      @JsonKey(name: 'can_use_ai') bool canUseAi,
      @JsonKey(name: 'can_create_case') bool canCreateCase,
      @JsonKey(name: 'can_share_library') bool canShareLibrary,
      @JsonKey(name: 'can_access_shared') bool canAccessShared,
      @JsonKey(name: 'can_view_soapnote') bool canViewSoapNote,
      @JsonKey(name: 'can_view_case_library') bool canViewCaseLibrary,
      @JsonKey(name: 'can_use_voice_to_text') bool canUseVoiceToText,
      @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
      bool canUseHypothesisSttReplaceAll});
}

/// @nodoc
class _$UserPermissionsRawCopyWithImpl<$Res, $Val extends UserPermissionsRaw>
    implements $UserPermissionsRawCopyWith<$Res> {
  _$UserPermissionsRawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPermissionsRaw
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
abstract class _$$UserPermissionsRawImplCopyWith<$Res>
    implements $UserPermissionsRawCopyWith<$Res> {
  factory _$$UserPermissionsRawImplCopyWith(_$UserPermissionsRawImpl value,
          $Res Function(_$UserPermissionsRawImpl) then) =
      __$$UserPermissionsRawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'can_view_dashboard') bool canViewDashboard,
      @JsonKey(name: 'can_use_ai') bool canUseAi,
      @JsonKey(name: 'can_create_case') bool canCreateCase,
      @JsonKey(name: 'can_share_library') bool canShareLibrary,
      @JsonKey(name: 'can_access_shared') bool canAccessShared,
      @JsonKey(name: 'can_view_soapnote') bool canViewSoapNote,
      @JsonKey(name: 'can_view_case_library') bool canViewCaseLibrary,
      @JsonKey(name: 'can_use_voice_to_text') bool canUseVoiceToText,
      @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
      bool canUseHypothesisSttReplaceAll});
}

/// @nodoc
class __$$UserPermissionsRawImplCopyWithImpl<$Res>
    extends _$UserPermissionsRawCopyWithImpl<$Res, _$UserPermissionsRawImpl>
    implements _$$UserPermissionsRawImplCopyWith<$Res> {
  __$$UserPermissionsRawImplCopyWithImpl(_$UserPermissionsRawImpl _value,
      $Res Function(_$UserPermissionsRawImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPermissionsRaw
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
    return _then(_$UserPermissionsRawImpl(
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
@JsonSerializable()
class _$UserPermissionsRawImpl implements _UserPermissionsRaw {
  const _$UserPermissionsRawImpl(
      {@JsonKey(name: 'can_view_dashboard') this.canViewDashboard = false,
      @JsonKey(name: 'can_use_ai') this.canUseAi = false,
      @JsonKey(name: 'can_create_case') this.canCreateCase = false,
      @JsonKey(name: 'can_share_library') this.canShareLibrary = false,
      @JsonKey(name: 'can_access_shared') this.canAccessShared = false,
      @JsonKey(name: 'can_view_soapnote') this.canViewSoapNote = false,
      @JsonKey(name: 'can_view_case_library') this.canViewCaseLibrary = false,
      @JsonKey(name: 'can_use_voice_to_text') this.canUseVoiceToText = false,
      @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
      this.canUseHypothesisSttReplaceAll = false});

  factory _$UserPermissionsRawImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPermissionsRawImplFromJson(json);

  @override
  @JsonKey(name: 'can_view_dashboard')
  final bool canViewDashboard;
  @override
  @JsonKey(name: 'can_use_ai')
  final bool canUseAi;
  @override
  @JsonKey(name: 'can_create_case')
  final bool canCreateCase;
  @override
  @JsonKey(name: 'can_share_library')
  final bool canShareLibrary;
  @override
  @JsonKey(name: 'can_access_shared')
  final bool canAccessShared;
  @override
  @JsonKey(name: 'can_view_soapnote')
  final bool canViewSoapNote;
  @override
  @JsonKey(name: 'can_view_case_library')
  final bool canViewCaseLibrary;
  @override
  @JsonKey(name: 'can_use_voice_to_text')
  final bool canUseVoiceToText;
  @override
  @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
  final bool canUseHypothesisSttReplaceAll;

  @override
  String toString() {
    return 'UserPermissionsRaw(canViewDashboard: $canViewDashboard, canUseAi: $canUseAi, canCreateCase: $canCreateCase, canShareLibrary: $canShareLibrary, canAccessShared: $canAccessShared, canViewSoapNote: $canViewSoapNote, canViewCaseLibrary: $canViewCaseLibrary, canUseVoiceToText: $canUseVoiceToText, canUseHypothesisSttReplaceAll: $canUseHypothesisSttReplaceAll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPermissionsRawImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UserPermissionsRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPermissionsRawImplCopyWith<_$UserPermissionsRawImpl> get copyWith =>
      __$$UserPermissionsRawImplCopyWithImpl<_$UserPermissionsRawImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPermissionsRawImplToJson(
      this,
    );
  }
}

abstract class _UserPermissionsRaw implements UserPermissionsRaw {
  const factory _UserPermissionsRaw(
      {@JsonKey(name: 'can_view_dashboard') final bool canViewDashboard,
      @JsonKey(name: 'can_use_ai') final bool canUseAi,
      @JsonKey(name: 'can_create_case') final bool canCreateCase,
      @JsonKey(name: 'can_share_library') final bool canShareLibrary,
      @JsonKey(name: 'can_access_shared') final bool canAccessShared,
      @JsonKey(name: 'can_view_soapnote') final bool canViewSoapNote,
      @JsonKey(name: 'can_view_case_library') final bool canViewCaseLibrary,
      @JsonKey(name: 'can_use_voice_to_text') final bool canUseVoiceToText,
      @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
      final bool canUseHypothesisSttReplaceAll}) = _$UserPermissionsRawImpl;

  factory _UserPermissionsRaw.fromJson(Map<String, dynamic> json) =
      _$UserPermissionsRawImpl.fromJson;

  @override
  @JsonKey(name: 'can_view_dashboard')
  bool get canViewDashboard;
  @override
  @JsonKey(name: 'can_use_ai')
  bool get canUseAi;
  @override
  @JsonKey(name: 'can_create_case')
  bool get canCreateCase;
  @override
  @JsonKey(name: 'can_share_library')
  bool get canShareLibrary;
  @override
  @JsonKey(name: 'can_access_shared')
  bool get canAccessShared;
  @override
  @JsonKey(name: 'can_view_soapnote')
  bool get canViewSoapNote;
  @override
  @JsonKey(name: 'can_view_case_library')
  bool get canViewCaseLibrary;
  @override
  @JsonKey(name: 'can_use_voice_to_text')
  bool get canUseVoiceToText;
  @override
  @JsonKey(name: 'can_use_hypothesis_stt_replace_all')
  bool get canUseHypothesisSttReplaceAll;

  /// Create a copy of UserPermissionsRaw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPermissionsRawImplCopyWith<_$UserPermissionsRawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
