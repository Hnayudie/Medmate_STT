import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/register_request.dart';

part 'register_request_raw.freezed.dart';
part 'register_request_raw.g.dart';

@freezed
class RegisterRequestRaw with _$RegisterRequestRaw {
  const factory RegisterRequestRaw({
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'password') @Default('') String password,
    @JsonKey(name: 'confirm_password') @Default('') String confirmPassword,
  }) = _RegisterRequestRaw;

  factory RegisterRequestRaw.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestRawFromJson(json);

  factory RegisterRequestRaw.fromDomain(RegisterRequest domain) =>
      RegisterRequestRaw(
        fullName: domain.fullName,
        email: domain.email,
        password: domain.password,
        confirmPassword: domain.confirmPassword,
      );
}
