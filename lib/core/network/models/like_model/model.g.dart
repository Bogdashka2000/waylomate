// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeModel _$LikeModelFromJson(Map<String, dynamic> json) => LikeModel(
  action: json['action'] as String,
  isLiked: json['is_liked'] as bool,
  totalLikes: (json['total_likes'] as num).toInt(),
);

Map<String, dynamic> _$LikeModelToJson(LikeModel instance) => <String, dynamic>{
  'action': instance.action,
  'is_liked': instance.isLiked,
  'total_likes': instance.totalLikes,
};

const _$LikeModelJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'action': {'type': 'string'},
    'is_liked': {'type': 'boolean'},
    'total_likes': {'type': 'integer'},
  },
  'required': ['action', 'is_liked', 'total_likes'],
};
