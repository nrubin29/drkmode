import 'dart:convert';

import 'package:drkmode_common/generic_response.dart';
import 'package:drkmode_common/poll_create.dart';
import 'package:drkmode_common/poll_question.dart';
import 'package:drkmode_common/vote_request.dart';
import 'package:http/http.dart';

final _client = Client();

Uri _uri(String path) =>
    Uri(scheme: 'https', host: 'app.drkmodepodcast.com', path: 'api/$path');

Future<String> _get(String path) async {
  return (await _client.get(_uri(path))).body;
}

Future<String> _post(String path, String body) async {
  return (await _client.post(_uri(path), body: body)).body;
}

Future<Poll?> getPoll() async {
  final responseObject = json.decode(await _get('poll/get'));
  return responseObject == null ? null : Poll.fromJson(responseObject);
}

Future<GenericResponse> vote(VoteRequest request) async =>
    GenericResponse.fromJson(
        json.decode(await _post('poll/vote', json.encode(request.toJson()))));

Future<GenericResponse> createPoll(PollCreateRequest request) async =>
    GenericResponse.fromJson(
        json.decode(await _post('poll/create', json.encode(request.toJson()))));
