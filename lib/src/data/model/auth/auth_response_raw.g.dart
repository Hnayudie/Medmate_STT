// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseRawImpl _$$AuthResponseRawImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthResponseRawImpl(
      accessToken: json['access_token'] as String? ?? '',
      tokenType: json['token_type'] as String? ?? 'bearer',
    );

Map<String, dynamic> _$$AuthResponseRawImplToJson(
        _$AuthResponseRawImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };
