import 'package:medmate_stt/src/data/network/rest_client.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/auth_response_raw.dart';

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
