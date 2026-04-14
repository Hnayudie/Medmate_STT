import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  Future<Either<Exception, AuthResponse>> call(LoginRequest request) async {
    try {
      return await _repository.login(request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
