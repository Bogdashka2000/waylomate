// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  Id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  text: json['text'] as String,
  imageUrl: json['image_url'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  likeCount: (json['like_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  isLiked: json['is_liked'] as bool,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.Id,
  'user_id': instance.userId,
  'text': instance.text,
  'image_url': instance.imageUrl,
  'created_at': instance.createdAt.toIso8601String(),
  'like_count': instance.likeCount,
  'comment_count': instance.commentCount,
  'is_liked': instance.isLiked,
};

const _$PostModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'user_id': {'type': 'integer'},
    'text': {'type': 'string'},
    'image_url': {'type': 'string'},
    'created_at': {'type': 'string', 'format': 'date-time'},
    'like_count': {'type': 'integer'},
    'comment_count': {'type': 'integer'},
    'is_liked': {'type': 'boolean'},
  },
  'required': [
    'id',
    'user_id',
    'text',
    'image_url',
    'created_at',
    'like_count',
    'comment_count',
    'is_liked',
  ],
};
