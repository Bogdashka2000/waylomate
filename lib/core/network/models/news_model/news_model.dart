import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class NewsModel {
  @JsonKey(name: 'id')
  final int Id;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'text')
  final String text;

  NewsModel({
    required this.Id,
    required this.userId,
    required this.title,
    required this.text,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$NewsModelJsonSchema;
}
