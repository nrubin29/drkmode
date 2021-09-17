// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PollServiceRouter(PollService service) {
  final router = Router();
  router.add('GET', r'/get', service.getPoll);
  router.add('POST', r'/vote', service.vote);
  router.add('POST', r'/create', service.create);
  return router;
}
