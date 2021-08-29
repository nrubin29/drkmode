import 'dart:convert';

import 'package:drkmode_app/drk_mode_appbar.dart';
import 'package:drkmode_common/generic_response.dart';
import 'package:drkmode_common/poll_create.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PollEditor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PollEditorState();
}

class _PollEditorState extends State<PollEditor> {
  final _questionController = TextEditingController();
  final _optionControllers = <TextEditingController>[];

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
              );

              final rawResponse = await post(
                  Uri(
                      scheme: 'http',
                      host: 'localhost',
                      port: 8080,
                      path: 'create'),
                  body: json.encode(request.toJson()));
              final response =
                  GenericResponse.fromJson(json.decode(rawResponse.body));

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
