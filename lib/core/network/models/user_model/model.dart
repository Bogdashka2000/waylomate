import 'dart:isolate';

import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class UserModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'birthday')
  final DateTime birthday;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'avatar_image_url')
  final String avatarImageUrl;
  @JsonKey(name: 'header_image_url')
  final String headerImageUrl;
  @JsonKey(name: 'about')
  final String about;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.gender,
    required this.avatarImageUrl,
    required this.headerImageUrl,
    required this.about,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$UserModelJsonSchema;
}
