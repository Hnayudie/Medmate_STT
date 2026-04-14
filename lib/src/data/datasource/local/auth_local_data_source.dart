import 'package:shared_preferences/shared_preferences.dart';

const _keyAccessToken = 'access_token';
const _keyFullName = 'full_name';
const _keyEmail = 'email';
const _keyRole = 'role';

class AuthLocalDataSource {
  Future<void> saveSession({
    required String accessToken,
    required String fullName,
    String email = '',
    String role = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAccessToken, accessToken);
    await prefs.setString(_keyFullName, fullName);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyRole, role);
  }

  Future<({String accessToken, String fullName, String email, String role})?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_keyAccessToken);
    if (token == null || token.isEmpty) return null;
    return (
      accessToken: token,
      fullName: prefs.getString(_keyFullName) ?? '',
      email: prefs.getString(_keyEmail) ?? '',
      role: prefs.getString(_keyRole) ?? '',
    );
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAccessToken);
    await prefs.remove(_keyFullName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyRole);
  }
}
