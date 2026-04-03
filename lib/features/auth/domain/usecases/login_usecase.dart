import 'package:medmate_stt/features/auth/domain/entities/auth_response.dart';
import 'package:medmate_stt/features/auth/domain/entities/login_request.dart';
import 'package:medmate_stt/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase({required AuthRepository repository})
    : _repository = repository;

  final AuthRepository _repository;

  Future<AuthResponse> call(LoginRequest request) {
    return _repository.login(request);
  }
}
