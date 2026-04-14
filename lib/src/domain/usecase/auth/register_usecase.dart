import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  Future<Either<Exception, AuthResponse>> call(RegisterRequest request) async {
    try {
      return await _repository.register(request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
