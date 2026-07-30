import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/dart.dart';

import 'widgets/find_replace_bar.dart';

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
  late final CodeController controller;

  final findController = TextEditingController();
  final replaceController = TextEditingController();

  Timer? _timer;

  bool _dirty = false;

  @override
  void initState() {
    super.initState();

    controller = CodeController(
      text: File(widget.path).readAsStringSync(),
      language: dart,
    );

    controller.addListener(_onChanged);
  }

  void _onChanged() {
    if (!_dirty) {
      setState(() {
        _dirty = true;
      });
    }

    _timer?.cancel();

    _timer = Timer(
      const Duration(seconds: 2),
      () async {
        await File(widget.path).writeAsString(controller.text);

        if (!mounted) return;

        setState(() {
          _dirty = false;
        });
      },
    );
  }

  void findNext() {
    final q = findController.text;

    if (q.isEmpty) return;

    final start = controller.selection.end;

    int index = controller.text.indexOf(q, start);

    if (index == -1) {
      index = controller.text.indexOf(q);
    }

    if (index == -1) return;

    controller.selection = TextSelection(
      baseOffset: index,
      extentOffset: index + q.length,
    );
  }

  void replaceCurrent() {
    final q = findController.text;

    if (q.isEmpty) return;

    final sel = controller.selection;

    if (sel.start == -1) return;

    controller.text = controller.text.replaceRange(
      sel.start,
      sel.end,
      replaceController.text,
    );

    findNext();
  }

  Future<void> _save() async {
    _timer?.cancel();

    await File(widget.path).writeAsString(controller.text);

    if (!mounted) return;

    setState(() {
      _dirty = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.dispose();
    findController.dispose();
    replaceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = widget.path.split('/').last;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _dirty ? "$fileName ●" : fileName,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: Column(
        children: [
          FindReplaceBar(
            findController: findController,
            replaceController: replaceController,
            onNext: findNext,
            onReplace: replaceCurrent,
          ),
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(),
              child: CodeField(
                controller: controller,
                expands: true,
                gutterStyle: const GutterStyle(
                  width: 48,
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                textStyle: const TextStyle(
                  fontFamily: "monospace",
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
