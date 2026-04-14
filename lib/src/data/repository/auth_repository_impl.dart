import 'package:fpdart/fpdart.dart';
import 'package:medmate_stt/src/data/datasource/local/auth_local_data_source.dart';
import 'package:medmate_stt/src/data/datasource/remote/auth_remote_data_source.dart';
import 'package:medmate_stt/src/data/model/auth/auth_response_raw.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/user_profile_raw.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';
import 'package:medmate_stt/src/domain/entity/auth/user_profile.dart';
import 'package:medmate_stt/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<Exception, AuthResponse>> login(LoginRequest request) async {
    try {
      final raw = await _remoteDataSource.login(
        LoginRequestRaw.fromDomain(request),
      );
      final tokenDomain = raw.toDomainObject();

      // Fetch full user profile with the new token
      final profileRaw = await _remoteDataSource.getMe(
        accessToken: tokenDomain.accessToken,
      );
      final profile = profileRaw.toDomainObject();

      final domain = AuthResponse(
        accessToken: tokenDomain.accessToken,
        fullName: profile.name,
        email: profile.email,
        role: profile.role,
      );

      await _localDataSource.saveSession(
        accessToken: domain.accessToken,
        fullName: domain.fullName,
        email: domain.email,
        role: domain.role,
      );
      return Right(domain);
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
      final tokenDomain = raw.toDomainObject();

      final profileRaw = await _remoteDataSource.getMe(
        accessToken: tokenDomain.accessToken,
      );
      final profile = profileRaw.toDomainObject();

      final domain = AuthResponse(
        accessToken: tokenDomain.accessToken,
        fullName: profile.name,
        email: profile.email,
        role: profile.role,
      );

      await _localDataSource.saveSession(
        accessToken: domain.accessToken,
        fullName: domain.fullName,
        email: domain.email,
        role: domain.role,
      );
      return Right(domain);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, UserProfile>> getMe({required String accessToken}) async {
    try {
      final raw = await _remoteDataSource.getMe(accessToken: accessToken);
      return Right(raw.toDomainObject());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<AuthResponse?> getStoredSession() async {
    final session = await _localDataSource.loadSession();
    if (session == null) return null;
    return AuthResponse(
      accessToken: session.accessToken,
      fullName: session.fullName,
      email: session.email,
      role: session.role,
    );
  }

  @override
  Future<void> signOut() async {
    await _localDataSource.clearSession();
  }
}
