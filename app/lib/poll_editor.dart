import 'dart:ui';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:drkmode_app/http_service.dart';
import 'package:drkmode_common/poll_create.dart';
import 'package:flutter/material.dart';

class PollEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PollEditorState();
}

class _PollEditorState extends State<PollEditor> {
  final _questionController = TextEditingController();
  final _optionControllers = <TextEditingController>[];
  final _endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrkModeAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              final request = PollCreateRequest(
                _questionController.text,
                _optionControllers.map((e) => e.text).toList(growable: false),
                DateTime.parse(_endController.text),
              );
              final response = await createPoll(request);
              print(response);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                children: [
                  Text('Options'),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _optionControllers.add(TextEditingController());
                      });
                    },
                  )
                ],
              ),
              for (var optionController in _optionControllers)
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: optionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _optionControllers.remove(optionController);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              DateTimePicker(
                type: DateTimePickerType.dateTime,
                use24HourFormat: false,
                controller: _endController,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)),
                locale: PlatformDispatcher.instance.locale,
                decoration: InputDecoration(
                  labelText: 'End',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _endController.dispose();

    for (var optionController in _optionControllers) {
      optionController.dispose();
    }

    super.dispose();
  }
}
