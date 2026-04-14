import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medmate_stt/src/domain/entity/auth/user_profile.dart';

part 'user_profile_raw.freezed.dart';
part 'user_profile_raw.g.dart';

@freezed
class UserProfileRaw with _$UserProfileRaw {
  const factory UserProfileRaw({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'role') @Default('') String role,
    @JsonKey(name: 'hypothesis_type') @Default('') String hypothesisType,
    @Default(UserPermissionsRaw()) UserPermissionsRaw permissions,
  }) = _UserProfileRaw;

  factory UserProfileRaw.fromJson(Map<String, dynamic> json) =>
      _$UserProfileRawFromJson(json);
}

@freezed
class UserPermissionsRaw with _$UserPermissionsRaw {
  const factory UserPermissionsRaw({
    @JsonKey(name: 'can_view_dashboard') @Default(false) bool canViewDashboard,
    @JsonKey(name: 'can_use_ai') @Default(false) bool canUseAi,
    @JsonKey(name: 'can_create_case') @Default(false) bool canCreateCase,
    @JsonKey(name: 'can_share_library') @Default(false) bool canShareLibrary,
    @JsonKey(name: 'can_access_shared') @Default(false) bool canAccessShared,
    @JsonKey(name: 'can_view_soapnote') @Default(false) bool canViewSoapNote,
    @JsonKey(name: 'can_view_case_library') @Default(false) bool canViewCaseLibrary,
    @JsonKey(name: 'can_use_voice_to_text') @Default(false) bool canUseVoiceToText,
    @JsonKey(name: 'can_use_hypothesis_stt_replace_all') @Default(false) bool canUseHypothesisSttReplaceAll,
  }) = _UserPermissionsRaw;

  factory UserPermissionsRaw.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionsRawFromJson(json);
}

extension UserProfileRawX on UserProfileRaw {
  UserProfile toDomainObject() => UserProfile(
        id: id,
        email: email,
        name: name,
        role: role,
        hypothesisType: hypothesisType,
        permissions: permissions.toDomainObject(),
      );
}

extension UserPermissionsRawX on UserPermissionsRaw {
  UserPermissions toDomainObject() => UserPermissions(
        canViewDashboard: canViewDashboard,
        canUseAi: canUseAi,
        canCreateCase: canCreateCase,
        canShareLibrary: canShareLibrary,
        canAccessShared: canAccessShared,
        canViewSoapNote: canViewSoapNote,
        canViewCaseLibrary: canViewCaseLibrary,
        canUseVoiceToText: canUseVoiceToText,
        canUseHypothesisSttReplaceAll: canUseHypothesisSttReplaceAll,
      );
}
