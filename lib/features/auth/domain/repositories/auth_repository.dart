import 'package:medmate_stt/features/auth/domain/entities/auth_response.dart';
import 'package:medmate_stt/features/auth/domain/entities/login_request.dart';
import 'package:medmate_stt/features/auth/domain/entities/register_request.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
}
