import 'package:flutter/material.dart';

class EditorHost extends StatelessWidget {
  final Widget child;

  const EditorHost({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1e1e1e),
      child: child,
    );
  }
}
