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

VoteResponse _$VoteResponseFromJson(Map<String, dynamic> json) => VoteResponse(
      json['success'] as bool,
    );

Map<String, dynamic> _$VoteResponseToJson(VoteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
