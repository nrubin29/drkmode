import 'dart:async';

import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:drkmode_app/http_service.dart';
import 'package:drkmode_app/poll_question.dart';
import 'package:drkmode_app/poll_responses.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The page that displays the current poll.
class PollPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  var _fetched = false;
  Poll? _poll;
  var _voted = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchPoll();
  }

  Future<void> _fetchPoll() async {
    setState(() {
      _fetched = false;
    });

    final poll = await getPoll();

    if (poll == null) {
      setState(() {
        _poll = null;
        _fetched = true;
      });
    } else {
      final voted =
          ((await SharedPreferences.getInstance()).getStringList('voted') ??
                  const <String>[])
              .contains('${poll.id}');

      setState(() {
        _poll = poll;
        _voted = voted;
        _fetched = true;
      });

      _timer?.cancel();
      _timer = null;

      if (!poll.isEnded) {
        _timer = Timer(poll.end.difference(DateTime.now()), _fetchPoll);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrkModeAppBar(
        leading: kDebugMode
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await (await SharedPreferences.getInstance()).clear();
                  _fetchPoll();
                },
              )
            : null,
      ),
      body: _fetched
          ? RefreshIndicator(
              onRefresh: _fetchPoll,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    if (_poll == null)
                      Text(
                        'There is no active poll. Please check back later.',
                        textAlign: TextAlign.center,
                      )
                    else if (_voted || (_poll?.isEnded ?? false))
                      PollResponses(poll: _poll!)
                    else
                      PollQuestion(poll: _poll!, onVote: _fetchPoll),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
