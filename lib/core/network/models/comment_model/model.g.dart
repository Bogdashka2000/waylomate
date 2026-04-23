// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  postId: (json['post_id'] as num).toInt(),
  text: json['text'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'post_id': instance.postId,
      'text': instance.text,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$CommentModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'user_id': {'type': 'integer'},
    'post_id': {'type': 'integer'},
    'text': {'type': 'string'},
    'created_at': {'type': 'string', 'format': 'date-time'},
  },
  'required': ['id', 'user_id', 'post_id', 'text', 'created_at'],
};
