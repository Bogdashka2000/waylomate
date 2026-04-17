import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class Hobby {
  @JsonKey(name: 'id')
  final int Id;
  @JsonKey(name: 'hobby_name')
  final String hobbyName;

  Hobby({required this.Id, required this.hobbyName});

  factory Hobby.fromJson(Map<String, dynamic> json) => _$HobbyFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HobbyToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$HobbyJsonSchema;
}
