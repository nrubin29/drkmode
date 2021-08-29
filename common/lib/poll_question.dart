import 'package:json_annotation/json_annotation.dart';

part 'poll_question.g.dart';

@JsonSerializable()
class Poll {
  final int id;
  final String question;
  final List<PollOption> options;

  const Poll(this.id, this.question, this.options);

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  Map<String, dynamic> toJson() => _$PollToJson(this);
}

@JsonSerializable()
class PollOption {
  final int id;
  final String value;

  @JsonKey(defaultValue: 0)
  final int votes;

  const PollOption(this.id, this.value, this.votes);

  factory PollOption.fromJson(Map<String, dynamic> json) =>
      _$PollOptionFromJson(json);

  Map<String, dynamic> toJson() => _$PollOptionToJson(this);
}
