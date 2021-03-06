import 'package:drkmode_app/widgets/base/card.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Displays the responses for a [Poll].
class PollResponses extends StatefulWidget {
  final Poll poll;
  final int totalVotes;

  PollResponses({required this.poll})
      : totalVotes = poll.options
            .map((e) => e.votes)
            .reduce((value, element) => value + element);

  @override
  State<StatefulWidget> createState() => _PollResponsesState();
}

class _PollResponsesState extends State<PollResponses> {
  double _percentVotes(PollOption option) =>
      widget.totalVotes == 0 ? 0 : option.votes / widget.totalVotes;

  String _votes(PollOption option) => Intl.plural(
        option.votes,
        one: '${option.votes} vote',
        other: '${option.votes} votes',
      );

  @override
  Widget build(BuildContext context) => DrkModeCard(
        title: Row(
          children: [
            Icon(
              Icons.poll,
              color: Colors.black,
              size: Theme.of(context).textTheme.headline5!.fontSize,
            ),
            Expanded(
              child: Text(
                widget.poll.question,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            for (var option in widget.poll.options)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _percentVotes(option),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text(option.value),
                      trailing: Text('${_votes(option)} ??? '
                          '${(_percentVotes(option) * 100).round()}%'),
                    ),
                  ],
                ),
              ),
          ],
        ),
        bottom: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                '${widget.totalVotes} vote${widget.totalVotes != 1 ? 's' : ''}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black),
              ),
            )
          ],
        ),
      );
}
