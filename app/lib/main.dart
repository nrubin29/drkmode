import 'package:drkmode_app/poll.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drk Mode',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        toggleableActiveColor: Colors.amber,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        toggleableActiveColor: Colors.amber,
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Drk Mode',
            style: TextStyle(
              fontFamily: 'Barbaro',
              fontSize: kToolbarHeight / 2,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: PollQuestion(
            poll: Poll(
              'If you had to get rid of one Apple product, which would it be?',
              ['iPhone', 'iPad', 'Apple Watch', 'Mac'],
            ),
          ),
        ),
      ),
    );
  }
}
