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
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber.shade500,
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
      ),
    );
  }
}
