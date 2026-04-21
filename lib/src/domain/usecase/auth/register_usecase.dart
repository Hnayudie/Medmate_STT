import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class RegisterUseCaseParams {
  const RegisterUseCaseParams({required this.request});
  final RegisterRequest request;
}

abstract class RegisterUseCase {
  Future<Either<Exception, AuthResponse>> call(RegisterUseCaseParams params);
}

@Injectable(as: RegisterUseCase)
class RegisterUseCaseImpl implements RegisterUseCase {
  const RegisterUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Exception, AuthResponse>> call(RegisterUseCaseParams params) async {
    try {
      return await _repository.register(params.request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
