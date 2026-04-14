// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestRawImpl _$$RegisterRequestRawImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestRawImpl(
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      confirmPassword: json['confirm_password'] as String? ?? '',
    );

Map<String, dynamic> _$$RegisterRequestRawImplToJson(
        _$RegisterRequestRawImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
    };
