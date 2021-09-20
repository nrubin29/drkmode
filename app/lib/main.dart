import 'package:drkmode_app/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting();
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
