import 'package:equatable/equatable.dart';
import 'package:medmate_stt/features/auth/domain/entities/auth_response.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.data,
    this.errorMessage,
  });

  final AuthStatus status;
  final AuthResponse? data;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    AuthResponse? data,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
