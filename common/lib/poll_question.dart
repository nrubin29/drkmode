import 'package:json_annotation/json_annotation.dart';

part 'poll_question.g.dart';

DateTime fromMillis(value) => DateTime.fromMillisecondsSinceEpoch(value);

int toMillis(DateTime value) => value.millisecondsSinceEpoch;

@JsonSerializable()
class Poll {
  final int id;
  final String question;
  final List<PollOption> options;

  @JsonKey(fromJson: fromMillis, toJson: toMillis)
  final DateTime end;

  bool get isEnded {
    final now = DateTime.now();
    return now.isAtSameMomentAs(end) || now.isAfter(end);
  }

  const Poll(this.id, this.question, this.options, this.end);

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
