// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      success: json['success'] as bool,
      status: json['status'] as int?,
      isVerified: json['is_verified'] as int?,
      token: json['token'] as String?,
      role: json['role'] as int?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'is_verified': instance.isVerified,
      'role': instance.role,
      'token': instance.token,
      'error': instance.error,
    };
