import 'dart:convert';

import 'package:drkmode_app/poll_question.dart';
import 'package:drkmode_app/poll_responses.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Poll? _poll;
  var _voted = false;

  @override
  void initState() {
    super.initState();
    _fetchPoll();
  }

  Future<void> _fetchPoll() async {
    final response = await get(
        Uri(scheme: 'http', host: 'localhost', port: 8080, path: 'poll'));
    final poll = Poll.fromJson(json.decode(response.body));
    final voted =
        ((await SharedPreferences.getInstance()).getStringList('voted') ??
                const <String>[])
            .contains('${poll.id}');

    setState(() {
      _poll = poll;
      _voted = voted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Drk Mode',
          style: TextStyle(
            fontFamily: 'Barbaro',
            fontSize: kToolbarHeight / 2,
          ),
        ),
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
      body: RefreshIndicator(
        onRefresh: _fetchPoll,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              if (_poll != null)
                if (_voted)
                  PollResponses(poll: _poll!)
                else
                  PollQuestion(
                    poll: _poll!,
                    onVote: () {
                      _fetchPoll();
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
