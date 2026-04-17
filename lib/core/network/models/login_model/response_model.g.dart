// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      ok: json['ok'] as bool,
      userToken: json['user_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'user_token': instance.userToken,
      'refresh_token': instance.refreshToken,
      'message': instance.message,
    };

const _$UserLoginResponseJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'ok': {'type': 'boolean'},
    'user_token': {'type': 'string'},
    'refresh_token': {'type': 'string'},
    'message': {'type': 'string'},
  },
  'required': ['ok', 'user_token', 'refresh_token', 'message'],
};
