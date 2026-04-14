// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestRawImpl _$$LoginRequestRawImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestRawImpl(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginRequestRawImplToJson(
        _$LoginRequestRawImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
