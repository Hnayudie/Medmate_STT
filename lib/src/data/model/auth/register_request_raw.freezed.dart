// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_request_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterRequestRaw _$RegisterRequestRawFromJson(Map<String, dynamic> json) {
  return _RegisterRequestRaw.fromJson(json);
}

/// @nodoc
mixin _$RegisterRequestRaw {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'password')
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirm_password')
  String get confirmPassword => throw _privateConstructorUsedError;

  /// Serializes this RegisterRequestRaw to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterRequestRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterRequestRawCopyWith<RegisterRequestRaw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterRequestRawCopyWith<$Res> {
  factory $RegisterRequestRawCopyWith(
          RegisterRequestRaw value, $Res Function(RegisterRequestRaw) then) =
      _$RegisterRequestRawCopyWithImpl<$Res, RegisterRequestRaw>;
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'confirm_password') String confirmPassword});
}

/// @nodoc
class _$RegisterRequestRawCopyWithImpl<$Res, $Val extends RegisterRequestRaw>
    implements $RegisterRequestRawCopyWith<$Res> {
  _$RegisterRequestRawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterRequestRaw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterRequestRawImplCopyWith<$Res>
    implements $RegisterRequestRawCopyWith<$Res> {
  factory _$$RegisterRequestRawImplCopyWith(_$RegisterRequestRawImpl value,
          $Res Function(_$RegisterRequestRawImpl) then) =
      __$$RegisterRequestRawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'confirm_password') String confirmPassword});
}

/// @nodoc
class __$$RegisterRequestRawImplCopyWithImpl<$Res>
    extends _$RegisterRequestRawCopyWithImpl<$Res, _$RegisterRequestRawImpl>
    implements _$$RegisterRequestRawImplCopyWith<$Res> {
  __$$RegisterRequestRawImplCopyWithImpl(_$RegisterRequestRawImpl _value,
      $Res Function(_$RegisterRequestRawImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterRequestRaw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? password = null,
    Object? confirmPassword = null,
  }) {
    return _then(_$RegisterRequestRawImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterRequestRawImpl implements _RegisterRequestRaw {
  const _$RegisterRequestRawImpl(
      {@JsonKey(name: 'full_name') this.fullName = '',
      @JsonKey(name: 'email') this.email = '',
      @JsonKey(name: 'password') this.password = '',
      @JsonKey(name: 'confirm_password') this.confirmPassword = ''});

  factory _$RegisterRequestRawImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterRequestRawImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'password')
  final String password;
  @override
  @JsonKey(name: 'confirm_password')
  final String confirmPassword;

  @override
  String toString() {
    return 'RegisterRequestRaw(fullName: $fullName, email: $email, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterRequestRawImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, email, password, confirmPassword);

  /// Create a copy of RegisterRequestRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterRequestRawImplCopyWith<_$RegisterRequestRawImpl> get copyWith =>
      __$$RegisterRequestRawImplCopyWithImpl<_$RegisterRequestRawImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterRequestRawImplToJson(
      this,
    );
  }
}

abstract class _RegisterRequestRaw implements RegisterRequestRaw {
  const factory _RegisterRequestRaw(
          {@JsonKey(name: 'full_name') final String fullName,
          @JsonKey(name: 'email') final String email,
          @JsonKey(name: 'password') final String password,
          @JsonKey(name: 'confirm_password') final String confirmPassword}) =
      _$RegisterRequestRawImpl;

  factory _RegisterRequestRaw.fromJson(Map<String, dynamic> json) =
      _$RegisterRequestRawImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'email')
  String get email;
  @override
  @JsonKey(name: 'password')
  String get password;
  @override
  @JsonKey(name: 'confirm_password')
  String get confirmPassword;

  /// Create a copy of RegisterRequestRaw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterRequestRawImplCopyWith<_$RegisterRequestRawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
