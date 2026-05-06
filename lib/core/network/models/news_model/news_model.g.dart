// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
  Id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  title: json['title'] as String,
  text: json['text'] as String,
);

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
  'id': instance.Id,
  'user_id': instance.userId,
  'title': instance.title,
  'text': instance.text,
};

const _$NewsModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'user_id': {'type': 'integer'},
    'title': {'type': 'string'},
    'text': {'type': 'string'},
  },
  'required': ['id', 'user_id', 'title', 'text'],
};
