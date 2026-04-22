// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  birthday: DateTime.parse(json['birthday'] as String),
  gender: json['gender'] as String,
  avatarImageUrl: json['avatar_image_url'] as String,
  headerImageUrl: json['header_image_url'] as String,
  about: json['about'] as String,
  isAdmin: json['is_admin'] as bool,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'birthday': instance.birthday.toIso8601String(),
  'gender': instance.gender,
  'avatar_image_url': instance.avatarImageUrl,
  'header_image_url': instance.headerImageUrl,
  'about': instance.about,
  'is_admin': instance.isAdmin,
};

const _$UserModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'first_name': {'type': 'string'},
    'last_name': {'type': 'string'},
    'birthday': {'type': 'string', 'format': 'date-time'},
    'gender': {'type': 'string'},
    'avatar_image_url': {'type': 'string'},
    'header_image_url': {'type': 'string'},
    'about': {'type': 'string'},
    'is_admin': {'type': 'boolean'},
  },
  'required': [
    'id',
    'first_name',
    'last_name',
    'birthday',
    'gender',
    'avatar_image_url',
    'header_image_url',
    'about',
    'is_admin',
  ],
};
