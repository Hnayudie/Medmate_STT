import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';

abstract class AuthRepository {
  Future<Either<Exception, AuthResponse>> login(LoginRequest request);
  Future<Either<Exception, AuthResponse>> register(RegisterRequest request);
}
