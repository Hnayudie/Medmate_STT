import 'package:dio/dio.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/auth_response_raw.dart';

class RestClient {
  RestClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://api.medmate.local',
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
            ),
          );

  final Dio _dio;

  Future<AuthResponseRaw> login(LoginRequestRaw request) async {
    // TODO: Replace mock section with real API:
    // final response = await _dio.post('/auth/login', data: request.toJson());
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (request.password == 'wrong') {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        message: 'Invalid credentials',
      );
    }
    return AuthResponseRaw(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      userId: 'doctor_001',
      fullName: 'Dr. ${request.username}',
    );
  }

  Future<AuthResponseRaw> register(RegisterRequestRaw request) async {
    // TODO: Replace mock section with real API:
    // final response = await _dio.post('/auth/register', data: request.toJson());
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (request.password != request.confirmPassword) {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/register'),
        message: 'Password mismatch',
      );
    }
    return AuthResponseRaw(
      accessToken: 'mock_access_token_new',
      refreshToken: 'mock_refresh_token_new',
      userId: 'doctor_new',
      fullName: request.fullName,
    );
  }
}
