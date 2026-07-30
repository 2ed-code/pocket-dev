import 'package:flutter/material.dart';

class LineNumbers extends StatelessWidget {
  final String text;

  const LineNumbers({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final count = '\n'.allMatches(text).length + 1;

    return Container(
      width: 50,
      color: const Color(0xFF252526),
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (_, index) => SizedBox(
          height: 20,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: "monospace",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
