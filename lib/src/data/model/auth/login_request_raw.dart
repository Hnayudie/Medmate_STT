import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/login_request.dart';

part 'login_request_raw.freezed.dart';
part 'login_request_raw.g.dart';

@freezed
class LoginRequestRaw with _$LoginRequestRaw {
  const factory LoginRequestRaw({
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'password') @Default('') String password,
  }) = _LoginRequestRaw;

  factory LoginRequestRaw.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestRawFromJson(json);

  factory LoginRequestRaw.fromDomain(LoginRequest domain) => LoginRequestRaw(
        email: domain.email,
        password: domain.password,
      );
}
