import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class LoginUseCaseParams {
  const LoginUseCaseParams({required this.request});
  final LoginRequest request;
}

abstract class LoginUseCase {
  Future<Either<Exception, AuthResponse>> call(LoginUseCaseParams params);
}

@Injectable(as: LoginUseCase)
class LoginUseCaseImpl implements LoginUseCase {
  const LoginUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Exception, AuthResponse>> call(LoginUseCaseParams params) async {
    try {
      return await _repository.login(params.request);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
