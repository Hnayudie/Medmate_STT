import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';
import 'package:medmate_stt/src/domain/usecase/auth/login_usecase.dart';
import 'package:medmate_stt/src/domain/usecase/auth/register_usecase.dart';
import 'package:medmate_stt/src/presentation/cubit/auth/auth_state.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/login_view_model.dart';
import 'package:medmate_stt/src/presentation/page/auth/view_model/register_view_model.dart';

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

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthState.loading(
      loginViewModel: const LoginViewModel(isLoading: true),
      registerViewModel: state.registerViewModel,
    ));

    final result = await _loginUseCase(
      LoginRequest(email: email.trim(), password: password),
    );

    result.fold(
      (error) => emit(AuthState.error(
        message: error.toString(),
        loginViewModel: LoginViewModel(errorText: error.toString()),
        registerViewModel: state.registerViewModel,
      )),
      (data) => emit(AuthState.success(
        fullName: data.fullName,
        email: data.email,
        role: data.role,
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
    emit(AuthState.loading(
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
      (error) => emit(AuthState.error(
        message: error.toString(),
        loginViewModel: state.loginViewModel,
        registerViewModel: RegisterViewModel(errorText: error.toString()),
      )),
      (data) => emit(AuthState.success(
        fullName: data.fullName,
        email: data.email,
        role: data.role,
        loginViewModel: state.loginViewModel,
        registerViewModel: RegisterViewModel.fromDomain(data),
      )),
    );
  }

  Future<void> restoreSession() async {
    final session = await _authRepository.getStoredSession();
    if (session != null) {
      emit(AuthState.success(
        fullName: session.fullName,
        email: session.email,
        role: session.role,
        loginViewModel: LoginViewModel.fromDomain(session),
        registerViewModel: state.registerViewModel,
      ));
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
