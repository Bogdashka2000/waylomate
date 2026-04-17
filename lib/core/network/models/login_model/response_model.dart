import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class UserLoginResponse {
  @JsonKey(name: 'ok')
  final bool ok;
  @JsonKey(name: 'user_token')
  final String userToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @JsonKey(name: 'message')
  final String message;

  UserLoginResponse({
    required this.ok,
    required this.userToken,
    required this.refreshToken,
    required this.message,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$UserLoginResponseJsonSchema;
}
