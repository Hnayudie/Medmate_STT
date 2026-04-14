import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/user_profile.dart';

abstract class AuthRepository {
  Future<Either<Exception, AuthResponse>> login(LoginRequest request);
  Future<Either<Exception, AuthResponse>> register(RegisterRequest request);
  Future<Either<Exception, UserProfile>> getMe({required String accessToken});
  Future<AuthResponse?> getStoredSession();
  Future<void> signOut();
}
