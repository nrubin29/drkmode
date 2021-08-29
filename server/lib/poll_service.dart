import 'dart:convert';

import 'package:drkmode_common/poll_question.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'poll_service.g.dart';

class PollService {
  @Route.get('/poll')
  Future<Response> getPoll(Request request) async {
    return Response.ok(json.encode(Poll(
      'If you had to get rid of one Apple product, which would it be?',
      ['iPhone', 'iPad', 'Apple Watch', 'Mac'],
    ).toJson()));
  }

  Router get router => _$PollServiceRouter(this);
}
