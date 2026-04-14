import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/login_view_model.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  factory AuthState.initial({
    @Default(LoginViewModel()) LoginViewModel loginViewModel,
    @Default(RegisterViewModel()) RegisterViewModel registerViewModel,
  }) = AuthInitialState;

  factory AuthState.loading({
    @Default(LoginViewModel()) LoginViewModel loginViewModel,
    @Default(RegisterViewModel()) RegisterViewModel registerViewModel,
  }) = AuthLoadingState;

  factory AuthState.success({
    @Default('') String fullName,
    @Default('') String email,
    @Default('') String role,
    @Default(LoginViewModel()) LoginViewModel loginViewModel,
    @Default(RegisterViewModel()) RegisterViewModel registerViewModel,
  }) = AuthSuccessState;

  factory AuthState.error({
    @Default('') String message,
    @Default(LoginViewModel()) LoginViewModel loginViewModel,
    @Default(RegisterViewModel()) RegisterViewModel registerViewModel,
  }) = AuthErrorState;
}
