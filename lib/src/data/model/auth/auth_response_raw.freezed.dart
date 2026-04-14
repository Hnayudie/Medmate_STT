// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response_raw.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthResponseRaw _$AuthResponseRawFromJson(Map<String, dynamic> json) {
  return _AuthResponseRaw.fromJson(json);
}

/// @nodoc
mixin _$AuthResponseRaw {
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  String get tokenType => throw _privateConstructorUsedError;

  /// Serializes this AuthResponseRaw to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthResponseRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthResponseRawCopyWith<AuthResponseRaw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResponseRawCopyWith<$Res> {
  factory $AuthResponseRawCopyWith(
          AuthResponseRaw value, $Res Function(AuthResponseRaw) then) =
      _$AuthResponseRawCopyWithImpl<$Res, AuthResponseRaw>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'token_type') String tokenType});
}

/// @nodoc
class _$AuthResponseRawCopyWithImpl<$Res, $Val extends AuthResponseRaw>
    implements $AuthResponseRawCopyWith<$Res> {
  _$AuthResponseRawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResponseRaw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthResponseRawImplCopyWith<$Res>
    implements $AuthResponseRawCopyWith<$Res> {
  factory _$$AuthResponseRawImplCopyWith(_$AuthResponseRawImpl value,
          $Res Function(_$AuthResponseRawImpl) then) =
      __$$AuthResponseRawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'token_type') String tokenType});
}

/// @nodoc
class __$$AuthResponseRawImplCopyWithImpl<$Res>
    extends _$AuthResponseRawCopyWithImpl<$Res, _$AuthResponseRawImpl>
    implements _$$AuthResponseRawImplCopyWith<$Res> {
  __$$AuthResponseRawImplCopyWithImpl(
      _$AuthResponseRawImpl _value, $Res Function(_$AuthResponseRawImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthResponseRaw
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? tokenType = null,
  }) {
    return _then(_$AuthResponseRawImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthResponseRawImpl implements _AuthResponseRaw {
  const _$AuthResponseRawImpl(
      {@JsonKey(name: 'access_token') this.accessToken = '',
      @JsonKey(name: 'token_type') this.tokenType = 'bearer'});

  factory _$AuthResponseRawImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthResponseRawImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  @JsonKey(name: 'token_type')
  final String tokenType;

  @override
  String toString() {
    return 'AuthResponseRaw(accessToken: $accessToken, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthResponseRawImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, tokenType);

  /// Create a copy of AuthResponseRaw
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthResponseRawImplCopyWith<_$AuthResponseRawImpl> get copyWith =>
      __$$AuthResponseRawImplCopyWithImpl<_$AuthResponseRawImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthResponseRawImplToJson(
      this,
    );
  }
}

abstract class _AuthResponseRaw implements AuthResponseRaw {
  const factory _AuthResponseRaw(
          {@JsonKey(name: 'access_token') final String accessToken,
          @JsonKey(name: 'token_type') final String tokenType}) =
      _$AuthResponseRawImpl;

  factory _AuthResponseRaw.fromJson(Map<String, dynamic> json) =
      _$AuthResponseRawImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @override
  @JsonKey(name: 'token_type')
  String get tokenType;

  /// Create a copy of AuthResponseRaw
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthResponseRawImplCopyWith<_$AuthResponseRawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
