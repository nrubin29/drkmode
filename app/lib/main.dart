import 'package:drkmode_app/home.dart';
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
        accentColor: Colors.amber,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber,
        toggleableActiveColor: Colors.amber,
        accentColor: Colors.amber,
        brightness: Brightness.dark,
      ),
      home: const Home(),
    );
  }
}
