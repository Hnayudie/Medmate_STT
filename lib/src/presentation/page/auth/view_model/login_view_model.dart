import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

part 'login_view_model.freezed.dart';

@freezed
class LoginViewModel with _$LoginViewModel {
  const factory LoginViewModel({
    @Default(false) bool isLoading,
    String? errorText,
    String? welcomeText,
  }) = _LoginViewModel;

  factory LoginViewModel.fromDomain(AuthResponse domain) => LoginViewModel(
        welcomeText: domain.fullName,
      );
}
