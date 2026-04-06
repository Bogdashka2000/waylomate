import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable(createJsonSchema: true)
class UserRegistrationRequest {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'birthday')
  final DateTime birthday;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'hobbies')
  final List<int> hobbies;
  @JsonKey(name: 'goals')
  final List<int> goals;
  @JsonKey(name: 'languages')
  final List<int> languages;
  @JsonKey(name: 'about')
  final String about;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'email')
  final String email;

  UserRegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.gender,
    required this.hobbies,
    required this.goals,
    required this.languages,
    required this.about,
    required this.password,
    required this.email,
  });

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRegistrationRequestToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$UserRegistrationRequestJsonSchema;
}
