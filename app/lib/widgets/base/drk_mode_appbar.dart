import 'package:flutter/material.dart';

class DrkModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;

  const DrkModeAppBar({this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Drk Mode',
        style: TextStyle(
          fontFamily: 'Barbaro',
          fontSize: kToolbarHeight / 2,
        ),
      ),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
