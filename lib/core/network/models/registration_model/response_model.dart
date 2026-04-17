import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class UserRegistrationResponse {
  @JsonKey(name: 'result')
  final String result;

  UserRegistrationResponse({required this.result});

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationResponseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRegistrationResponseToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$UserRegistrationResponseJsonSchema;
}
