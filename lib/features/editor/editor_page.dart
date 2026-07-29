import 'dart:io';
import 'package:flutter/material.dart';

class EditorPage extends StatefulWidget {
  final String path;

  const EditorPage({
    super.key,
    required this.path,
  });

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final file = File(widget.path);

    if (await file.exists()) {
      controller.text = await file.readAsString();
      setState(() {});
    }
  }

  Future<void> save() async {
    await File(widget.path).writeAsString(controller.text);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.path.split("/").last),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: controller,
          expands: true,
          maxLines: null,
          minLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
