import 'package:flutter/material.dart';

/// A Card with Drk Mode styling.
class DrkModeCard extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? bottom;
  final Widget? belowBottom;

  const DrkModeCard(
      {required this.title, required this.body, this.bottom, this.belowBottom});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding: EdgeInsets.all(16),
              child: title,
            ),
          ),
          body,
          if (bottom != null)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding: EdgeInsets.all(16),
              child: bottom,
            ),
          if (belowBottom != null)
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: belowBottom!,
            ),
        ],
      );
}
