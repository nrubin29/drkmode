import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/material.dart';

/// Displays a [Poll] that the user can respond to.
class PollQuestion extends StatefulWidget {
  final Poll poll;

  const PollQuestion({required this.poll});

  @override
  State<StatefulWidget> createState() => _PollQuestionState();
}

class _PollQuestionState extends State<PollQuestion> {
  PollOption? _selection;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
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
              ),
            ),
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
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      print('Vote pressed');
                    },
                    child: Text(
                      'Vote',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(.25)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
