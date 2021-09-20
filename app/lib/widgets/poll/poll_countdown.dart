import 'dart:async';

import 'package:drkmode_common/poll_question.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PollCountdown extends StatefulWidget {
  final Poll poll;

  const PollCountdown({required this.poll});

  @override
  State<StatefulWidget> createState() => _PollCountdownState();
}

class _PollCountdownState extends State<PollCountdown> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Poll ends in $_timeLeft.',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  String get _timeLeft {
    var delta = widget.poll.end.difference(DateTime.now());
    final components = <String>[];

    if (delta.inDays > 0) {
      components.add(Intl.plural(delta.inDays,
          one: '${delta.inDays} day', other: '${delta.inDays} days'));
      delta = delta - Duration(days: delta.inDays);
    }

    if (delta.inHours > 0) {
      components.add(Intl.plural(delta.inHours,
          one: '${delta.inHours} hour', other: '${delta.inHours} hours'));
      delta = delta - Duration(hours: delta.inHours);
    }

    if (delta.inMinutes > 0) {
      components.add(Intl.plural(delta.inMinutes,
          one: '${delta.inMinutes} minute',
          other: '${delta.inMinutes} minutes'));
      delta = delta - Duration(minutes: delta.inMinutes);
    }

    if (delta.inSeconds > 0) {
      components.add(Intl.plural(delta.inSeconds,
          one: '${delta.inSeconds} second',
          other: '${delta.inSeconds} seconds'));
      delta = delta - Duration(seconds: delta.inSeconds);
    }

    if (components.length == 1) {
      return components.single;
    } else if (components.length == 2) {
      return '${components[0]} and ${components[1]}';
    }

    components[components.length - 1] =
        'and ${components[components.length - 1]}';

    return components.join(', ');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
