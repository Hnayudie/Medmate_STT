// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileRawImpl _$$UserProfileRawImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileRawImpl(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      hypothesisType: json['hypothesis_type'] as String? ?? '',
      permissions: json['permissions'] == null
          ? const UserPermissionsRaw()
          : UserPermissionsRaw.fromJson(
              json['permissions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProfileRawImplToJson(
        _$UserProfileRawImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
      'hypothesis_type': instance.hypothesisType,
      'permissions': instance.permissions,
    };

_$UserPermissionsRawImpl _$$UserPermissionsRawImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPermissionsRawImpl(
      canViewDashboard: json['can_view_dashboard'] as bool? ?? false,
      canUseAi: json['can_use_ai'] as bool? ?? false,
      canCreateCase: json['can_create_case'] as bool? ?? false,
      canShareLibrary: json['can_share_library'] as bool? ?? false,
      canAccessShared: json['can_access_shared'] as bool? ?? false,
      canViewSoapNote: json['can_view_soapnote'] as bool? ?? false,
      canViewCaseLibrary: json['can_view_case_library'] as bool? ?? false,
      canUseVoiceToText: json['can_use_voice_to_text'] as bool? ?? false,
      canUseHypothesisSttReplaceAll:
          json['can_use_hypothesis_stt_replace_all'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserPermissionsRawImplToJson(
        _$UserPermissionsRawImpl instance) =>
    <String, dynamic>{
      'can_view_dashboard': instance.canViewDashboard,
      'can_use_ai': instance.canUseAi,
      'can_create_case': instance.canCreateCase,
      'can_share_library': instance.canShareLibrary,
      'can_access_shared': instance.canAccessShared,
      'can_view_soapnote': instance.canViewSoapNote,
      'can_view_case_library': instance.canViewCaseLibrary,
      'can_use_voice_to_text': instance.canUseVoiceToText,
      'can_use_hypothesis_stt_replace_all':
          instance.canUseHypothesisSttReplaceAll,
    };
