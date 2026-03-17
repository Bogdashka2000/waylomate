// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
  Id: (json['id'] as num).toInt(),
  languageName: json['language_name'] as String,
);

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'id': instance.Id,
  'language_name': instance.languageName,
};

const _$LanguageJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'language_name': {'type': 'string'},
  },
  'required': ['id', 'language_name'],
};
