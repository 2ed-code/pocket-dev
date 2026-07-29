import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';

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
  late CodeController controller;

  @override
  void initState() {
    super.initState();

    String text = "";

    final file = File(widget.path);

    if (file.existsSync()) {
      text = file.readAsStringSync();
    }

    controller = CodeController(
      text: text,
      language: dart,
    );
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
            onPressed: save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: CodeTheme(
        data: const CodeThemeData(),
        child: CodeField(
          controller: controller,
        ),
      ),
    );
  }
}
