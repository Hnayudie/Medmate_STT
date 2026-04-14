import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

abstract class RegisterUseCase {
  Future<Either<Exception, AuthResponse>> call(RegisterRequest request);
}

@Injectable(as: RegisterUseCase)
class RegisterUseCaseImpl implements RegisterUseCase {
  const RegisterUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Exception, AuthResponse>> call(RegisterRequest request) async {
    try {
      return await _repository.register(request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
