import 'package:flutter/material.dart';

class TerminalDock extends StatelessWidget {
  final Widget child;

  const TerminalDock({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Color(0xff181818),
        border: Border(
          top: BorderSide(
            color: Colors.white12,
          ),
        ),
      ),
      child: child,
    );
  }
}
