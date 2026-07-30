import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  const EditorTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      color: Colors.grey.shade900,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Text(
        "No file opened",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
