import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

abstract class LoginUseCase {
  Future<Either<Exception, AuthResponse>> call(LoginRequest request);
}

@Injectable(as: LoginUseCase)
class LoginUseCaseImpl implements LoginUseCase {
  const LoginUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Exception, AuthResponse>> call(LoginRequest request) async {
    try {
      return await _repository.login(request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
