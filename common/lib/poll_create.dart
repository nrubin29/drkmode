import 'package:json_annotation/json_annotation.dart';

part 'poll_create.g.dart';

@JsonSerializable()
class PollCreateRequest {
  final String question;
  final List<String> options;

  const PollCreateRequest(this.question, this.options);

  factory PollCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$PollCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PollCreateRequestToJson(this);
}
