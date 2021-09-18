import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:drkmode_app/http_service.dart';
import 'package:drkmode_common/environment.dart';
import 'package:drkmode_common/poll_create.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PollEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PollEditorState();
}

class _PollEditorState extends State<PollEditor> {
  final _questionController = TextEditingController();
  final _optionControllers = <TextEditingController>[];
  DateTime? _endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrkModeAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _endTime != null && _optionControllers.length > 1
                ? () async {
                    final request = PollCreateRequest(
                      _questionController.text,
                      _optionControllers
                          .map((e) => e.text)
                          .toList(growable: false),
                      _endTime!,
                      secretKey,
                    );
                    final response = await createPoll(request);
                    print(response);
                  }
                : null,
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
              DateTimeField(
                decoration: InputDecoration(labelText: 'Timestamp'),
                initialValue: _endTime,
                format: DateFormat('d MMM yyyy').add_jm(),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );

                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );

                    if (time != null) {
                      return DateTimeField.combine(date, time);
                    }
                  }

                  return currentValue;
                },
                onChanged: (dateTime) {
                  if (dateTime != null) {
                    setState(() {
                      _endTime = dateTime.toUtc();
                    });
                  }
                },
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

    for (var optionController in _optionControllers) {
      optionController.dispose();
    }

    super.dispose();
  }
}
