import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @Default('') String id,
    @Default('') String email,
    @Default('') String name,
    @Default('') String role,
    @Default('') String hypothesisType,
    @Default(UserPermissions()) UserPermissions permissions,
  }) = _UserProfile;
}

@freezed
class UserPermissions with _$UserPermissions {
  const factory UserPermissions({
    @Default(false) bool canViewDashboard,
    @Default(false) bool canUseAi,
    @Default(false) bool canCreateCase,
    @Default(false) bool canShareLibrary,
    @Default(false) bool canAccessShared,
    @Default(false) bool canViewSoapNote,
    @Default(false) bool canViewCaseLibrary,
    @Default(false) bool canUseVoiceToText,
    @Default(false) bool canUseHypothesisSttReplaceAll,
  }) = _UserPermissions;
}
