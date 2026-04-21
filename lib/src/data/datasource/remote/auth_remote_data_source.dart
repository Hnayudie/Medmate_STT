import 'package:injectable/injectable.dart';
import 'package:medmate_stt/src/data/model/auth/auth_response_raw.dart';
import 'package:medmate_stt/src/data/model/auth/login_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/register_request_raw.dart';
import 'package:medmate_stt/src/data/model/auth/user_profile_raw.dart';
import 'package:medmate_stt/src/data/network/rest_client.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseRaw> login(LoginRequestRaw request);
  Future<AuthResponseRaw> register(RegisterRequestRaw request);
  Future<UserProfileRaw> getMe({required String accessToken});
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._restClient);

  final RestClient _restClient;

  @override
  Future<AuthResponseRaw> login(LoginRequestRaw request) =>
      _restClient.login(request);

  @override
  Future<AuthResponseRaw> register(RegisterRequestRaw request) =>
      _restClient.register(request);

  @override
  Future<UserProfileRaw> getMe({required String accessToken}) =>
      _restClient.getMe(accessToken: accessToken);
}
