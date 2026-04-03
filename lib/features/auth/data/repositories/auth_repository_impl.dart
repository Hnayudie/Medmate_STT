import 'package:dio/dio.dart';
import 'package:medmate_stt/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:medmate_stt/features/auth/data/mappers/auth_mapper.dart';
import 'package:medmate_stt/features/auth/domain/entities/auth_response.dart';
import 'package:medmate_stt/features/auth/domain/entities/login_request.dart';
import 'package:medmate_stt/features/auth/domain/entities/register_request.dart';
import 'package:medmate_stt/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final raw = await _remoteDataSource.login(AuthMapper.toLoginRaw(request));
      return AuthMapper.toDomain(raw);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final raw = await _remoteDataSource.register(
        AuthMapper.toRegisterRaw(request),
      );
      return AuthMapper.toDomain(raw);
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Register failed');
    }
  }
}
