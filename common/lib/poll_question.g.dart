// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      json['question'] as String,
      (json['options'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
    };
