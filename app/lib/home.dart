import 'dart:convert';

import 'package:drkmode_app/poll_question.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Poll? _poll;

  @override
  void initState() {
    super.initState();
    _fetchPoll();
  }

  Future<void> _fetchPoll() async {
    final response = await get(
        Uri(scheme: 'http', host: 'localhost', port: 8080, path: 'poll'));
    final poll = Poll.fromJson(json.decode(response.body));

    setState(() {
      _poll = poll;
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
      ),
      body: RefreshIndicator(
        onRefresh: _fetchPoll,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              if (_poll != null) PollQuestion(poll: _poll!),
            ],
          ),
        ),
      ),
    );
  }
}
