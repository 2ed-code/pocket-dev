import 'package:flutter/material.dart';

class FindReplaceBar extends StatelessWidget {
  final TextEditingController findController;
  final TextEditingController replaceController;
  final VoidCallback onNext;
  final VoidCallback onReplace;

  const FindReplaceBar({
    super.key,
    required this.findController,
    required this.replaceController,
    required this.onNext,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff252526),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.search, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: findController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Find",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => onNext(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: onNext,
                  child: const Text("Next"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.find_replace, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: replaceController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Replace",
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => onReplace(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: onReplace,
                  child: const Text("Replace"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
