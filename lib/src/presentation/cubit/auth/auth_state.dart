import 'package:medmate_stt/src/presentation/page/auth/view_model/login_view_model.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';

sealed class AuthState {
  const AuthState({required this.loginViewModel, required this.registerViewModel});
  final LoginViewModel loginViewModel;
  final RegisterViewModel registerViewModel;
}

final class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(
          loginViewModel: const LoginViewModel(),
          registerViewModel: const RegisterViewModel(),
        );
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState({
    required super.loginViewModel,
    required super.registerViewModel,
  });
}

final class AuthSuccessState extends AuthState {
  const AuthSuccessState({
    required this.fullName,
    required super.loginViewModel,
    required super.registerViewModel,
  });
  final String fullName;
}

final class AuthErrorState extends AuthState {
  const AuthErrorState({
    required this.message,
    required super.loginViewModel,
    required super.registerViewModel,
  });
  final String message;
}
