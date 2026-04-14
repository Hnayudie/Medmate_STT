import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';

class LoginRequestRaw {
  const LoginRequestRaw({required this.username, required this.password});

  final String username;
  final String password;

  factory LoginRequestRaw.fromDomain(LoginRequest domain) => LoginRequestRaw(
        username: domain.username,
        password: domain.password,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
