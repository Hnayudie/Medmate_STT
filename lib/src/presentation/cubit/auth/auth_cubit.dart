import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/usecase/auth/login_usecase.dart';
import 'package:medmate_stt/src/domain/usecase/auth/register_usecase.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/login_view_model.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(const AuthInitialState());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(AuthLoadingState(
      loginViewModel: const LoginViewModel(isLoading: true),
      registerViewModel: state.registerViewModel,
    ));

    final result = await _loginUseCase(
      LoginRequest(username: username.trim(), password: password),
    );

    result.fold(
      (error) => emit(AuthErrorState(
        message: error.toString(),
        loginViewModel: LoginViewModel(errorText: error.toString()),
        registerViewModel: state.registerViewModel,
      )),
      (data) => emit(AuthSuccessState(
        fullName: data.fullName,
        loginViewModel: LoginViewModel.fromDomain(data),
        registerViewModel: state.registerViewModel,
      )),
    );
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoadingState(
      loginViewModel: state.loginViewModel,
      registerViewModel: const RegisterViewModel(isLoading: true),
    ));

    final result = await _registerUseCase(
      RegisterRequest(
        fullName: fullName.trim(),
        email: email.trim(),
        password: password,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (error) => emit(AuthErrorState(
        message: error.toString(),
        loginViewModel: state.loginViewModel,
        registerViewModel: RegisterViewModel(errorText: error.toString()),
      )),
      (data) => emit(AuthSuccessState(
        fullName: data.fullName,
        loginViewModel: state.loginViewModel,
        registerViewModel: RegisterViewModel.fromDomain(data),
      )),
    );
  }

  void clearError() {
    if (state is AuthErrorState) {
      emit(AuthInitialState());
    }
  }

  void reset() {
    emit(const AuthInitialState());
  }
}
