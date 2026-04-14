import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    @Default('') String accessToken,
    @Default('') String fullName,
    @Default('') String email,
    @Default('') String role,
  }) = _AuthResponse;
}
