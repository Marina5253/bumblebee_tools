import 'package:flutter/material.dart';

class RootAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;

  const RootAppBar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(label),
      centerTitle: true,
      elevation: 3,
      shadowColor: Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


