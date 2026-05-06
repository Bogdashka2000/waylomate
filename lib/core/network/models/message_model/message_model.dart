import 'package:json_annotation/json_annotation.dart';
import 'package:waylomate/core/network/models/user_model/model.dart';

part 'message_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class MessageModel {
  @JsonKey(name: 'user')
  final UserModel user;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'timestamp')
  final DateTime timestamp;

  MessageModel({required this.user, required this.message, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now().toUtc();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
