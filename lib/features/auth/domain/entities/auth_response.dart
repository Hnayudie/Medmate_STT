class AuthResponse {
  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.fullName,
  });

  final String accessToken;
  final String refreshToken;
  final String userId;
  final String fullName;
}
