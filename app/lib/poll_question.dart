import 'dart:convert';

import 'package:drkmode_app/card.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:drkmode_common/vote_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
                      final rawResponse = await post(
                          Uri(
                              scheme: 'http',
                              host: 'localhost',
                              port: 8080,
                              path: 'vote'),
                          body: json.encode(request.toJson()));
                      final response =
                          VoteResponse.fromJson(json.decode(rawResponse.body));

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
      );
}
