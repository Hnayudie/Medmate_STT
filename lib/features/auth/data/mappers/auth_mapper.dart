import 'package:medmate_stt/features/auth/data/models/request_raw/login_request_raw.dart';
import 'package:medmate_stt/features/auth/data/models/request_raw/register_request_raw.dart';
import 'package:medmate_stt/features/auth/data/models/response_raw/auth_response_raw.dart';
import 'package:medmate_stt/features/auth/domain/entities/auth_response.dart';
import 'package:medmate_stt/features/auth/domain/entities/login_request.dart';
import 'package:medmate_stt/features/auth/domain/entities/register_request.dart';

class AuthMapper {
  const AuthMapper._();

  static LoginRequestRaw toLoginRaw(LoginRequest request) {
    return LoginRequestRaw(
      username: request.username,
      password: request.password,
    );
  }

  static RegisterRequestRaw toRegisterRaw(RegisterRequest request) {
    return RegisterRequestRaw(
      fullName: request.fullName,
      email: request.email,
      password: request.password,
      confirmPassword: request.confirmPassword,
    );
  }

  static AuthResponse toDomain(AuthResponseRaw raw) {
    return AuthResponse(
      accessToken: raw.accessToken,
      refreshToken: raw.refreshToken,
      userId: raw.userId,
      fullName: raw.fullName,
    );
  }
}
