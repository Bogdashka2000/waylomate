import 'dart:isolate';

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class CommentModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'post_id')
  final int postId;
  @JsonKey(name: 'text')
  final String text;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$CommentModelJsonSchema;
}
