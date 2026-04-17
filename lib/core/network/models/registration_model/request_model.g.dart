// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationRequest _$UserRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => UserRegistrationRequest(
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  birthday: DateTime.parse(json['birthday'] as String),
  gender: json['gender'] as String,
  hobbies: (json['hobbies'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  goals: (json['goals'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  languages: (json['languages'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  about: json['about'] as String,
  password: json['password'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserRegistrationRequestToJson(
  UserRegistrationRequest instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'birthday': instance.birthday.toIso8601String(),
  'gender': instance.gender,
  'hobbies': instance.hobbies,
  'goals': instance.goals,
  'languages': instance.languages,
  'about': instance.about,
  'password': instance.password,
  'email': instance.email,
};

const _$UserRegistrationRequestJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'first_name': {'type': 'string'},
    'last_name': {'type': 'string'},
    'birthday': {'type': 'string', 'format': 'date-time'},
    'gender': {'type': 'string'},
    'hobbies': {
      'type': 'array',
      'items': {'type': 'integer'},
    },
    'goals': {
      'type': 'array',
      'items': {'type': 'integer'},
    },
    'languages': {
      'type': 'array',
      'items': {'type': 'integer'},
    },
    'about': {'type': 'string'},
    'password': {'type': 'string'},
    'email': {'type': 'string'},
  },
  'required': [
    'first_name',
    'last_name',
    'birthday',
    'gender',
    'hobbies',
    'goals',
    'languages',
    'about',
    'password',
    'email',
  ],
};
