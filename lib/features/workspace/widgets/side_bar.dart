import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Widget child;

  const SideBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xff1e1e1e),
      child: child,
    );
  }
}
