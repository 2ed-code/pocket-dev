import 'package:flutter/material.dart';

import '../../core/services/terminal_service.dart';

class TerminalPage extends StatefulWidget {
  const TerminalPage({super.key});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  final controller = TextEditingController();

  String output = "";
  bool running = false;

  Future<void> run() async {
    if (controller.text.trim().isEmpty) return;

    final parts = controller.text.trim().split(" ");

    setState(() {
      running = true;
      output = "Running...\n";
    });

    final result = await TerminalService.run(
      parts.first,
      parts.skip(1).toList(),
    );

    if (!mounted) return;

    setState(() {
      running = false;
      output = result;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terminal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Command",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => run(),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: running ? null : run,
              child: Text(running ? "Running..." : "Run"),
            ),
            const SizedBox(height: 20),
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
            ),
          ],
        ),
      ),
    );
  }
}
