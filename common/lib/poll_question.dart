import 'package:json_annotation/json_annotation.dart';

part 'poll_question.g.dart';

@JsonSerializable()
class Poll {
  final String question;
  final List<String> options;

  const Poll(this.question, this.options);

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  Map<String, dynamic> toJson() => _$PollToJson(this);
}
