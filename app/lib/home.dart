import 'package:drkmode_app/poll_editor.dart';
import 'package:drkmode_app/poll_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          if (index != _index) {
            setState(() {
              _index = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'Poll'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), label: 'Create Poll'),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          PollPage(),
          PollEditor(),
        ],
      ),
    );
  }
}
