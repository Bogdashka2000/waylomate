import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class LikeModel {
  @JsonKey(name: 'action')
  final String action;
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @JsonKey(name: 'total_likes')
  final int totalLikes;

  LikeModel({
    required this.action,
    required this.isLiked,
    required this.totalLikes,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LikeModelToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$LikeModelJsonSchema;
}
