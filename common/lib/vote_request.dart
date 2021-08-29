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
