// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hobby _$HobbyFromJson(Map<String, dynamic> json) => Hobby(
  Id: (json['id'] as num).toInt(),
  hobbyName: json['hobby_name'] as String,
);

Map<String, dynamic> _$HobbyToJson(Hobby instance) => <String, dynamic>{
  'id': instance.Id,
  'hobby_name': instance.hobbyName,
};

const _$HobbyJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'hobby_name': {'type': 'string'},
  },
  'required': ['id', 'hobby_name'],
};
