import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:flutter/material.dart';

class PollEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PollEditorState();
}

class _PollEditorState extends State<PollEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DrkModeAppBar(),
      body: Text('Editor'),
    );
  }
}
