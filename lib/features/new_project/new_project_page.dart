import 'package:flutter/material.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({super.key});

  @override
  State<NewProjectPage> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final controller = TextEditingController();

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
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Soon: ${controller.text}",
                    ),
                  ),
                );
              },
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
