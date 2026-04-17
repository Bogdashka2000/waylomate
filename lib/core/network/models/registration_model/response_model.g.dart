// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationResponse _$UserRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => UserRegistrationResponse(result: json['result'] as String);

Map<String, dynamic> _$UserRegistrationResponseToJson(
  UserRegistrationResponse instance,
) => <String, dynamic>{'result': instance.result};

const _$UserRegistrationResponseJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'result': {'type': 'string'},
  },
  'required': ['result'],
};
