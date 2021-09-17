import 'dart:io';

import 'package:drkmode_server/poll_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  sqfliteFfiInit();
  final database = await databaseFactoryFfi.openDatabase(
    '${Directory.current.path}/db.sqlite3',
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, _) async {
        await db.execute(
            'CREATE TABLE Poll (id INTEGER PRIMARY KEY, question TEXT, end '
            'INTEGER)');
        await db.execute(
            'CREATE TABLE PollOption (id INTEGER PRIMARY KEY, poll_id INTEGER, '
            'value TEXT, votes INTEGER)');
      },
    ),
  );

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_handleCors)
      .addHandler(Router()..mount('/api/poll/', PollService(database).router));

  final server = await shelf_io.serve(handler, 'localhost', 8016);
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

const _corsHeaders = {'Access-Control-Allow-Origin': '*'};

Middleware _handleCors = createMiddleware(
    requestHandler: (request) async {
      return request.method == 'OPTIONS'
          ? Response.ok(null, headers: _corsHeaders)
          : null;
    },
    responseHandler: (response) => response.change(headers: _corsHeaders));
