// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollCreateRequest _$PollCreateRequestFromJson(Map<String, dynamic> json) =>
    PollCreateRequest(
      json['question'] as String,
      (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      DateTime.parse(json['end'] as String),
      json['secretKey'] as String,
    );

Map<String, dynamic> _$PollCreateRequestToJson(PollCreateRequest instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'end': instance.end.toIso8601String(),
      'secretKey': instance.secretKey,
    };
