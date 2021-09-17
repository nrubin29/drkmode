import 'package:drkmode_app/card.dart';
import 'package:drkmode_app/http_service.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:drkmode_common/vote_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  String get _timeLeft {
    var delta = widget.poll.end.difference(DateTime.now());
    final components = <String>[];

    if (delta.inDays > 0) {
      components.add(Intl.plural(delta.inDays,
          one: '${delta.inDays} day', other: '${delta.inDays} days'));
      delta = delta - Duration(days: delta.inDays);
    }

    if (delta.inHours > 0) {
      components.add(Intl.plural(delta.inHours,
          one: '${delta.inHours} hour', other: '${delta.inHours} hours'));
      delta = delta - Duration(hours: delta.inHours);
    }

    if (delta.inMinutes > 0) {
      components.add(Intl.plural(delta.inMinutes,
          one: '${delta.inMinutes} minute',
          other: '${delta.inMinutes} minutes'));
      delta = delta - Duration(minutes: delta.inMinutes);
    }

    if (delta.inSeconds > 0) {
      components.add(Intl.plural(delta.inSeconds,
          one: '${delta.inSeconds} second',
          other: '${delta.inSeconds} seconds'));
      delta = delta - Duration(seconds: delta.inSeconds);
    }

    if (components.length == 1) {
      return components.single;
    } else if (components.length == 2) {
      return '${components[0]} and ${components[1]}';
    }

    components[components.length - 1] =
        'and ${components[components.length - 1]}';

    return components.join(', ');
  }

  @override
  Widget build(BuildContext context) => DrkModeCard(
        title: Row(
          children: [
            Icon(Icons.poll, color: Colors.black),
            Expanded(
              child: Text(
                widget.poll.question,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
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
            TextButton(
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
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.black.withOpacity(.25)),
              ),
            ),
          ],
        ),
        belowBottom: Text('Poll ends in $_timeLeft.'),
      );
}
