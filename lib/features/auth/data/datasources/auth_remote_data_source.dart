import 'package:medmate_stt/core/network/rest_client.dart';
import 'package:medmate_stt/features/auth/data/models/request_raw/login_request_raw.dart';
import 'package:medmate_stt/features/auth/data/models/request_raw/register_request_raw.dart';
import 'package:medmate_stt/features/auth/data/models/response_raw/auth_response_raw.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({RestClient? restClient})
    : _restClient = restClient ?? RestClient();

  final RestClient _restClient;

  Future<AuthResponseRaw> login(LoginRequestRaw request) {
    return _restClient.login(request);
  }

  Future<AuthResponseRaw> register(RegisterRequestRaw request) {
    return _restClient.register(request);
  }
}
