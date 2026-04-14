// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterViewModel {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorText => throw _privateConstructorUsedError;
  String? get successText => throw _privateConstructorUsedError;

  /// Create a copy of RegisterViewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterViewModelCopyWith<RegisterViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterViewModelCopyWith<$Res> {
  factory $RegisterViewModelCopyWith(
          RegisterViewModel value, $Res Function(RegisterViewModel) then) =
      _$RegisterViewModelCopyWithImpl<$Res, RegisterViewModel>;
  @useResult
  $Res call({bool isLoading, String? errorText, String? successText});
}

/// @nodoc
class _$RegisterViewModelCopyWithImpl<$Res, $Val extends RegisterViewModel>
    implements $RegisterViewModelCopyWith<$Res> {
  _$RegisterViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterViewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorText = freezed,
    Object? successText = freezed,
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
      successText: freezed == successText
          ? _value.successText
          : successText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterViewModelImplCopyWith<$Res>
    implements $RegisterViewModelCopyWith<$Res> {
  factory _$$RegisterViewModelImplCopyWith(_$RegisterViewModelImpl value,
          $Res Function(_$RegisterViewModelImpl) then) =
      __$$RegisterViewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? errorText, String? successText});
}

/// @nodoc
class __$$RegisterViewModelImplCopyWithImpl<$Res>
    extends _$RegisterViewModelCopyWithImpl<$Res, _$RegisterViewModelImpl>
    implements _$$RegisterViewModelImplCopyWith<$Res> {
  __$$RegisterViewModelImplCopyWithImpl(_$RegisterViewModelImpl _value,
      $Res Function(_$RegisterViewModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterViewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorText = freezed,
    Object? successText = freezed,
  }) {
    return _then(_$RegisterViewModelImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: freezed == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String?,
      successText: freezed == successText
          ? _value.successText
          : successText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RegisterViewModelImpl implements _RegisterViewModel {
  const _$RegisterViewModelImpl(
      {this.isLoading = false, this.errorText, this.successText});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorText;
  @override
  final String? successText;

  @override
  String toString() {
    return 'RegisterViewModel(isLoading: $isLoading, errorText: $errorText, successText: $successText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterViewModelImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText) &&
            (identical(other.successText, successText) ||
                other.successText == successText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorText, successText);

  /// Create a copy of RegisterViewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterViewModelImplCopyWith<_$RegisterViewModelImpl> get copyWith =>
      __$$RegisterViewModelImplCopyWithImpl<_$RegisterViewModelImpl>(
          this, _$identity);
}

abstract class _RegisterViewModel implements RegisterViewModel {
  const factory _RegisterViewModel(
      {final bool isLoading,
      final String? errorText,
      final String? successText}) = _$RegisterViewModelImpl;

  @override
  bool get isLoading;
  @override
  String? get errorText;
  @override
  String? get successText;

  /// Create a copy of RegisterViewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterViewModelImplCopyWith<_$RegisterViewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
