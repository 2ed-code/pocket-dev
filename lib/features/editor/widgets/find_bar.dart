import 'package:flutter/material.dart';

class FindBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onNext;

  const FindBar({
    super.key,
    required this.controller,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xFF252526),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Find",
                hintStyle: TextStyle(color: Colors.white54),
              ),
              onSubmitted: (_) => onNext(),
            ),
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ],
      ),
    );
  }
}
