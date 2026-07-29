import 'package:flutter/material.dart';

class TerminalPanel extends StatelessWidget {
  const TerminalPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: const Text(
        "Terminal",
        style: TextStyle(
          color: Colors.greenAccent,
          fontFamily: "monospace",
        ),
      ),
    );
  }
}
