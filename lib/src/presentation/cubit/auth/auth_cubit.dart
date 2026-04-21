import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/data/error/error_mapper.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';
import 'package:medmate_stt/src/domain/usecase/auth/login_usecase.dart';
import 'package:medmate_stt/src/domain/usecase/auth/register_usecase.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/login_view_model.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _authRepository = authRepository,
        super(AuthState.initial());

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepository _authRepository;

  LoginViewModel get _loginVM =>
      state is AuthSplashState ? const LoginViewModel() : (state as dynamic).loginViewModel as LoginViewModel;

  RegisterViewModel get _registerVM =>
      state is AuthSplashState ? const RegisterViewModel() : (state as dynamic).registerViewModel as RegisterViewModel;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthState.loading(
      loginViewModel: const LoginViewModel(isLoading: true),
      registerViewModel: _registerVM,
    ));

    final result = await _loginUseCase(
      LoginUseCaseParams(request: LoginRequest(email: email.trim(), password: password)),
    );

    result.fold(
      (error) => emit(AuthState.error(
        message: ErrorMapper.toMessage(error),
        loginViewModel: LoginViewModel(errorText: ErrorMapper.toMessage(error)),
        registerViewModel: _registerVM,
      )),
      (data) => emit(AuthState.success(
        fullName: data.fullName,
        email: data.email,
        role: data.role,
        loginViewModel: LoginViewModel.fromDomain(data),
        registerViewModel: _registerVM,
      )),
    );
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthState.loading(
      loginViewModel: _loginVM,
      registerViewModel: const RegisterViewModel(isLoading: true),
    ));

    final result = await _registerUseCase(
      RegisterUseCaseParams(
        request: RegisterRequest(
          fullName: fullName.trim(),
          email: email.trim(),
          password: password,
          confirmPassword: confirmPassword,
        ),
      ),
    );

    result.fold(
      (error) => emit(AuthState.error(
        message: ErrorMapper.toMessage(error),
        loginViewModel: _loginVM,
        registerViewModel: RegisterViewModel(errorText: ErrorMapper.toMessage(error)),
      )),
      (data) => emit(AuthState.success(
        fullName: data.fullName,
        email: data.email,
        role: data.role,
        loginViewModel: _loginVM,
        registerViewModel: RegisterViewModel.fromDomain(data),
      )),
    );
  }

  Future<void> restoreSession() async {
    emit(AuthState.splash());
    final session = await _authRepository.getStoredSession();
    if (session != null) {
      emit(AuthState.success(
        fullName: session.fullName,
        email: session.email,
        role: session.role,
        loginViewModel: LoginViewModel.fromDomain(session),
        registerViewModel: const RegisterViewModel(),
      ));
    } else {
      emit(AuthState.initial());
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthState.initial());
  }

  void clearError() {
    if (state is AuthErrorState) {
      emit(AuthState.initial());
    }
  }

  void reset() {
    emit(AuthState.initial());
  }
}
