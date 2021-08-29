import 'package:json_annotation/json_annotation.dart';

part 'vote_request.g.dart';

@JsonSerializable()
class VoteRequest {
  final int pollId;
  final String option;

  const VoteRequest(this.pollId, this.option);

  factory VoteRequest.fromJson(Map<String, dynamic> json) =>
      _$VoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoteRequestToJson(this);
}

@JsonSerializable()
class VoteResponse {
  final bool success;

  const VoteResponse(this.success);

  factory VoteResponse.fromJson(Map<String, dynamic> json) =>
      _$VoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoteResponseToJson(this);
}
