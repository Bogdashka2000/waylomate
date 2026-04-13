import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class UserLoginRequest {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  UserLoginRequest({required this.email, required this.password});

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLoginRequestFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserLoginRequestToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$UserLoginRequestJsonSchema;
}
