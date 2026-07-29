import 'package:flutter/material.dart';
import '../../core/services/terminal_service.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({super.key});

  @override
  State<NewProjectPage> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final controller = TextEditingController();

  bool loading = false;

  Future<void> createProject() async {
    if (controller.text.isEmpty) return;

    setState(() {
      loading = true;
    });

    final result = await TerminalService.run(
      "flutter",
      [
        "create",
        controller.text,
      ],
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Result"),
        content: SingleChildScrollView(
          child: Text(result),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Project"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Project Name",
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: loading ? null : createProject,
              child: Text(
                loading ? "Creating..." : "Create",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
