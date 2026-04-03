import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';

class RegisterViewModel {
  const RegisterViewModel({
    required this.isLoading,
    required this.errorText,
    required this.successText,
  });

  final bool isLoading;
  final String? errorText;
  final String? successText;

  factory RegisterViewModel.fromState(AuthState state) {
    return RegisterViewModel(
      isLoading: state.status == AuthStatus.loading,
      errorText: state.status == AuthStatus.failure ? state.errorMessage : null,
      successText:
          state.status == AuthStatus.success
              ? 'Welcome ${state.data?.fullName ?? ''}'
              : null,
    );
  }
}
