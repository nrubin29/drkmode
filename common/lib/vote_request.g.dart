// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteRequest _$VoteRequestFromJson(Map<String, dynamic> json) => VoteRequest(
      json['pollId'] as int,
      json['option'] as String,
    );

Map<String, dynamic> _$VoteRequestToJson(VoteRequest instance) =>
    <String, dynamic>{
      'pollId': instance.pollId,
      'option': instance.option,
    };
