import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

class AuthResponseRaw {
  const AuthResponseRaw({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.fullName,
  });

  final String accessToken;
  final String refreshToken;
  final String userId;
  final String fullName;

  factory AuthResponseRaw.fromJson(Map<String, dynamic> json) {
    return AuthResponseRaw(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
    );
  }

  AuthResponse toDomainObject() => AuthResponse(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userId: userId,
        fullName: fullName,
      );
}
