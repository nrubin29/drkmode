import 'package:flutter/material.dart';

class DrkModeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;

  const DrkModeAppBar({this.leading});

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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
