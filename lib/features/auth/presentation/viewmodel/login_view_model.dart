import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';

class LoginViewModel {
  const LoginViewModel({
    required this.isLoading,
    required this.errorText,
    required this.welcomeText,
  });

  final bool isLoading;
  final String? errorText;
  final String? welcomeText;

  factory LoginViewModel.fromState(AuthState state) {
    return LoginViewModel(
      isLoading: state.status == AuthStatus.loading,
      errorText: state.status == AuthStatus.failure ? state.errorMessage : null,
      welcomeText:
          state.status == AuthStatus.success ? state.data?.fullName : null,
    );
  }
}
