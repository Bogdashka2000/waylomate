// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) => Goal(
  Id: (json['id'] as num).toInt(),
  goalName: json['travel_goal_name'] as String,
);

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
  'id': instance.Id,
  'travel_goal_name': instance.goalName,
};

const _$GoalJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'integer'},
    'travel_goal_name': {'type': 'string'},
  },
  'required': ['id', 'travel_goal_name'],
};
