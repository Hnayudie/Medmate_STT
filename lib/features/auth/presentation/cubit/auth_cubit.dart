import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medmate_stt/features/auth/domain/entities/login_request.dart';
import 'package:medmate_stt/features/auth/domain/entities/register_request.dart';
import 'package:medmate_stt/features/auth/domain/usecases/login_usecase.dart';
import 'package:medmate_stt/features/auth/domain/usecases/register_usecase.dart';
import 'package:medmate_stt/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required LoginUseCase loginUseCase, required RegisterUseCase registerUseCase})
    : _loginUseCase = loginUseCase,
      _registerUseCase = registerUseCase,
      super(const AuthState());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final response = await _loginUseCase(
        LoginRequest(username: username.trim(), password: password),
      );
      emit(state.copyWith(status: AuthStatus.success, data: response));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    try {
      final response = await _registerUseCase(
        RegisterRequest(
          fullName: fullName.trim(),
          email: email.trim(),
          password: password,
          confirmPassword: confirmPassword,
        ),
      );
      emit(state.copyWith(status: AuthStatus.success, data: response));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void reset() {
    emit(const AuthState());
  }
}
