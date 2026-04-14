import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/data/datasource/remote/auth_remote_data_source.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Exception, AuthResponse>> login(LoginRequest request) async {
    try {
      final raw = await _remoteDataSource.login(
        LoginRequestRaw.fromDomain(request),
      );
      return Right(raw.toDomainObject());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, AuthResponse>> register(RegisterRequest request) async {
    try {
      final raw = await _remoteDataSource.register(
        RegisterRequestRaw.fromDomain(request),
      );
      return Right(raw.toDomainObject());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
