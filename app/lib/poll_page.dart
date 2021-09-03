import 'dart:convert';

import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:drkmode_app/poll_question.dart';
import 'package:drkmode_app/poll_responses.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchPoll();
  }

  Future<void> _fetchPoll() async {
    setState(() {
      _fetched = false;
    });

    final response = await get(
        Uri(scheme: 'http', host: 'localhost', port: 8080, path: 'poll'));
    final responseObject = json.decode(response.body);

    if (responseObject == null) {
      setState(() {
        _poll = null;
        _fetched = true;
      });
    } else {
      final poll = Poll.fromJson(json.decode(response.body));
      final voted =
          ((await SharedPreferences.getInstance()).getStringList('voted') ??
                  const <String>[])
              .contains('${poll.id}');

      setState(() {
        _poll = poll;
        _voted = voted;
        _fetched = true;
      });
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
                    else if (_voted)
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
}
