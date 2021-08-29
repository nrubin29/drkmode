import 'dart:convert';

import 'package:drkmode_common/poll_question.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqflite_common/sqlite_api.dart';

part 'poll_service.g.dart';

class PollService {
  final Database database;

  const PollService(this.database);

  @Route.get('/poll')
  Future<Response> getPoll(Request request) async {
    return Response.ok(json.encode(await _getCurrentPoll()));
  }

  Router get router => _$PollServiceRouter(this);

  Future<Poll?> _getCurrentPoll() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final results = await database.query('Poll',
        columns: ['id'], where: 'end > ?', whereArgs: [now]);

    if (results.isEmpty) {
      return null;
    }

    return _getPoll(results.first['id'] as int);
  }

  Future<Poll> _getPoll(int id) async {
    final results =
        await database.query('Poll', where: 'id = ?', whereArgs: [id]);

    if (results.isEmpty) {
      throw ArgumentError.value(
          id, 'id', 'No poll with that ID is in the database');
    }

    final pollMap = {...results.single};
    final pollId = pollMap['id'] as int;
    final optionResults = await database
        .query('PollOption', where: 'poll_id = ?', whereArgs: [pollId]);
    pollMap['options'] = optionResults;

    return Poll.fromJson(pollMap);
  }
}
