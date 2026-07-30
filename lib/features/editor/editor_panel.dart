import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorPanel extends StatefulWidget {
  final String? path;

  const EditorPanel({
    super.key,
    this.path,
  });

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  final controller = TextEditingController();

  bool dirty = false;

  @override
  void initState() {
    super.initState();
    _load();

    controller.addListener(() {
      if (!dirty) {
        setState(() {
          dirty = true;
        });
      }
    });
  }

  @override
  void didUpdateWidget(EditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.path != widget.path) {
      _load();
    }
  }

  void _load() {
    dirty = false;

    if (widget.path == null) {
      controller.clear();
      return;
    }

    final file = File(widget.path!);

    if (file.existsSync()) {
      controller.text = file.readAsStringSync();
    } else {
      controller.clear();
    }
  }

  Future<void> save() async {
    if (widget.path == null) return;

    await File(widget.path!).writeAsString(controller.text);

    if (!mounted) return;

    setState(() {
      dirty = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Saved"),
        duration: Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyS &&
            HardwareKeyboard.instance.isControlPressed) {
          save();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Column(
        children: [
          Container(
            height: 38,
            color: const Color(0xff2d2d30),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.path == null
                        ? "No file"
                        : "${widget.path!.split('/').last}${dirty ? " •" : ""}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  tooltip: "Save",
                  onPressed: save,
                  icon: const Icon(Icons.save),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              expands: true,
              maxLines: null,
              minLines: null,
              style: const TextStyle(
                fontFamily: "monospace",
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
