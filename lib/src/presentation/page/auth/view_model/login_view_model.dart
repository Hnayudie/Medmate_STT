import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

class LoginViewModel {
  const LoginViewModel({
    this.isLoading = false,
    this.errorText,
    this.welcomeText,
  });

  final bool isLoading;
  final String? errorText;
  final String? welcomeText;

  factory LoginViewModel.fromDomain(AuthResponse domain) => LoginViewModel(
        welcomeText: domain.fullName,
      );
}
