import 'package:dio/dio.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/auth_response_raw.dart';
import 'package:medmate_stt/src/data/model/auth/user_profile_raw.dart';

const _baseUrl =
    'https://medmate-backend-staging-176393011547.asia-southeast1.run.app';

class RestClient {
  RestClient({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: _baseUrl,
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: {'accept': 'application/json'},
              ),
            );

  final Dio _dio;

  Future<AuthResponseRaw> login(LoginRequestRaw request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: request.toJson(),
    );
    return AuthResponseRaw.fromJson(response.data!);
  }

  Future<AuthResponseRaw> register(RegisterRequestRaw request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: request.toJson(),
    );
    return AuthResponseRaw.fromJson(response.data!);
  }

  Future<UserProfileRaw> getMe({required String accessToken}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/auth/me',
      options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ),
    );
    return UserProfileRaw.fromJson(response.data!);
  }
}
