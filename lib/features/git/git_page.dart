import 'package:flutter/material.dart';
import '../../core/services/terminal_service.dart';

class GitPage extends StatefulWidget {
  const GitPage({super.key});

  @override
  State<GitPage> createState() => _GitPageState();
}

class _GitPageState extends State<GitPage> {
  String output = "";

  Future<void> run(List<String> cmd) async {
    final result = await TerminalService.run(
      cmd.first,
      cmd.sublist(1),
    );

    setState(() {
      output = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Git")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () => run(["git","status"]),
                  child: const Text("Status"),
                ),
                FilledButton(
                  onPressed: () => run(["git","pull"]),
                  child: const Text("Pull"),
                ),
                FilledButton(
                  onPressed: () => run(["git","push"]),
                  child: const Text("Push"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: SelectableText(
                    output,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: "monospace",
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
