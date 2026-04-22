import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class PostModel {
  @JsonKey(name: 'id')
  final int Id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'is_liked')
  final bool isLiked;

  PostModel({
    required this.Id,
    required this.userId,
    required this.text,
    required this.imageUrl,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$PostModelJsonSchema;
}
