import 'package:flutter/material.dart';

/// A Card with Drk Mode styling.
class DrkModeCard extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? bottom;

  const DrkModeCard({required this.title, required this.body, this.bottom});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: title,
              ),
            ),
            body,
            if (bottom != null)
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: bottom,
              ),
          ],
        ),
      );
}
