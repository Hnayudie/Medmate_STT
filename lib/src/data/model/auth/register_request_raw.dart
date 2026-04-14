import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';

class RegisterRequestRaw {
  const RegisterRequestRaw({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  factory RegisterRequestRaw.fromDomain(RegisterRequest domain) =>
      RegisterRequestRaw(
        fullName: domain.fullName,
        email: domain.email,
        password: domain.password,
        confirmPassword: domain.confirmPassword,
      );

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      };
}
