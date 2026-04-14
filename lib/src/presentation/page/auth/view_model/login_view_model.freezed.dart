// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginViewModel {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorText => throw _privateConstructorUsedError;
  String? get welcomeText => throw _privateConstructorUsedError;

  /// Create a copy of LoginViewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginViewModelCopyWith<LoginViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginViewModelCopyWith<$Res> {
  factory $LoginViewModelCopyWith(
          LoginViewModel value, $Res Function(LoginViewModel) then) =
      _$LoginViewModelCopyWithImpl<$Res, LoginViewModel>;
  @useResult
  $Res call({bool isLoading, String? errorText, String? welcomeText});
}

/// @nodoc
class _$LoginViewModelCopyWithImpl<$Res, $Val extends LoginViewModel>
    implements $LoginViewModelCopyWith<$Res> {
  _$LoginViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginViewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorText = freezed,
    Object? welcomeText = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      welcomeText: freezed == welcomeText
          ? _value.welcomeText
          : welcomeText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginViewModelImplCopyWith<$Res>
    implements $LoginViewModelCopyWith<$Res> {
  factory _$$LoginViewModelImplCopyWith(_$LoginViewModelImpl value,
          $Res Function(_$LoginViewModelImpl) then) =
      __$$LoginViewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorText, String? welcomeText});
}

/// @nodoc
class __$$LoginViewModelImplCopyWithImpl<$Res>
    extends _$LoginViewModelCopyWithImpl<$Res, _$LoginViewModelImpl>
    implements _$$LoginViewModelImplCopyWith<$Res> {
  __$$LoginViewModelImplCopyWithImpl(
      _$LoginViewModelImpl _value, $Res Function(_$LoginViewModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginViewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorText = freezed,
    Object? welcomeText = freezed,
  }) {
    return _then(_$LoginViewModelImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      welcomeText: freezed == welcomeText
          ? _value.welcomeText
          : welcomeText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoginViewModelImpl implements _LoginViewModel {
  const _$LoginViewModelImpl(
      {this.isLoading = false, this.errorText, this.welcomeText});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorText;
  @override
  final String? welcomeText;

  @override
  String toString() {
    return 'LoginViewModel(isLoading: $isLoading, errorText: $errorText, welcomeText: $welcomeText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginViewModelImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText) &&
            (identical(other.welcomeText, welcomeText) ||
                other.welcomeText == welcomeText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorText, welcomeText);

  /// Create a copy of LoginViewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginViewModelImplCopyWith<_$LoginViewModelImpl> get copyWith =>
      __$$LoginViewModelImplCopyWithImpl<_$LoginViewModelImpl>(
          this, _$identity);
}

abstract class _LoginViewModel implements LoginViewModel {
  const factory _LoginViewModel(
      {final bool isLoading,
      final String? errorText,
      final String? welcomeText}) = _$LoginViewModelImpl;

  @override
  bool get isLoading;
  @override
  String? get errorText;
  @override
  String? get welcomeText;

  /// Create a copy of LoginViewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginViewModelImplCopyWith<_$LoginViewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
