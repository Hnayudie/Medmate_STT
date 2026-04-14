import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

class RegisterViewModel {
  const RegisterViewModel({
    this.isLoading = false,
    this.errorText,
    this.successText,
  });

  final bool isLoading;
  final String? errorText;
  final String? successText;

  factory RegisterViewModel.fromDomain(AuthResponse domain) => RegisterViewModel(
        successText: domain.fullName,
      );
}
