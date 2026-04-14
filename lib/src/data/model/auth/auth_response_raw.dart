import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

part 'auth_response_raw.freezed.dart';
part 'auth_response_raw.g.dart';

@freezed
class AuthResponseRaw with _$AuthResponseRaw {
  const factory AuthResponseRaw({
    @JsonKey(name: 'access_token') @Default('') String accessToken,
    @JsonKey(name: 'token_type') @Default('bearer') String tokenType,
  }) = _AuthResponseRaw;

  factory AuthResponseRaw.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseRawFromJson(json);
}

extension AuthResponseRawX on AuthResponseRaw {
  Map<String, dynamic> _decodeJwt() {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return {};
      var payload = parts[1];
      payload = payload.replaceAll('-', '+').replaceAll('_', '/');
      switch (payload.length % 4) {
        case 2:
          payload += '==';
        case 3:
          payload += '=';
      }
      final decoded = utf8.decode(base64.decode(payload));
      return json.decode(decoded) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  AuthResponse toDomainObject() {
    final claims = _decodeJwt();
    return AuthResponse(
      accessToken: accessToken,
      fullName: claims['name'] as String? ?? '',
      email: claims['email'] as String? ?? '',
    );
  }
}
