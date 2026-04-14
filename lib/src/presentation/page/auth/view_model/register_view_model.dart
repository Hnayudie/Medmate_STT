import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/auth_response.dart';

part 'register_view_model.freezed.dart';

@freezed
class RegisterViewModel with _$RegisterViewModel {
  const factory RegisterViewModel({
    @Default(false) bool isLoading,
    String? errorText,
    String? successText,
  }) = _RegisterViewModel;

  factory RegisterViewModel.fromDomain(AuthResponse domain) => RegisterViewModel(
        successText: domain.fullName,
      );
}
