import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(createJsonSchema: true)
class Goal {
  @JsonKey(name: 'id')
  final int Id;
  @JsonKey(name: 'travel_goal_name')
  final String goalName;

  Goal({required this.Id, required this.goalName});

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GoalToJson(this);

  /// The JSON Schema for this class.
  static const jsonSchema = _$GoalJsonSchema;
}
