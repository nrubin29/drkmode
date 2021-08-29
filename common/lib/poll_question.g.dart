// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      json['id'] as int,
      json['question'] as String,
      (json['options'] as List<dynamic>)
          .map((e) => PollOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
    };

PollOption _$PollOptionFromJson(Map<String, dynamic> json) => PollOption(
      json['id'] as int,
      json['value'] as String,
      json['votes'] as int? ?? 0,
    );

Map<String, dynamic> _$PollOptionToJson(PollOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'votes': instance.votes,
    };
