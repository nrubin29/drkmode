import 'package:drkmode_app/http_service.dart';
import 'package:drkmode_app/widgets/base/card.dart';
import 'package:drkmode_app/widgets/poll/poll_countdown.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:drkmode_common/vote_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays a [Poll] that the user can respond to.
class PollQuestion extends StatefulWidget {
  final Poll poll;
  final VoidCallback onVote;

  const PollQuestion({required this.poll, required this.onVote});

  @override
  State<StatefulWidget> createState() => _PollQuestionState();
}

class _PollQuestionState extends State<PollQuestion> {
  PollOption? _selection;

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
              RadioListTile<PollOption>(
                value: option,
                groupValue: _selection,
                onChanged: (_) {
                  setState(() {
                    _selection = option;
                  });
                },
                title: Text(option.value),
              ),
          ],
        ),
        bottom: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: _selection != null
                    ? () async {
                        final request =
                            VoteRequest(widget.poll.id, _selection!.value);
                        final response = await vote(request);

                        if (response.success) {
                          final sharedPreferences =
                              await SharedPreferences.getInstance();
                          final voted =
                              sharedPreferences.getStringList('voted') ??
                                  <String>[];
                          voted.add('${widget.poll.id}');
                          await sharedPreferences.setStringList('voted', voted);
                          widget.onVote();
                        }
                      }
                    : null,
                child: Text(
                  'Vote',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                ),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.black.withOpacity(.25)),
                ),
              ),
            ),
          ],
        ),
        belowBottom: PollCountdown(poll: widget.poll),
      );
}
