// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PollServiceRouter(PollService service) {
  final router = Router();
  router.add('GET', r'/poll', service.getPoll);
  router.add('POST', r'/vote', service.vote);
  return router;
}
