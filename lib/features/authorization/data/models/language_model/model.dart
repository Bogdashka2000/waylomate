import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class Language {
  @JsonKey(name: 'id')
  final int Id;
  @JsonKey(name: 'language_name')
  final String languageName;

  Language({required this.Id, required this.languageName});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$LanguageJsonSchema;
}
