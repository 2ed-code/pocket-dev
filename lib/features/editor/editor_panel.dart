import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/workspace_state.dart';

class EditorPanel extends StatelessWidget {
  const EditorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorkspaceState>();

    if (state.openedFile == null) {
      return Container(
        color: const Color(0xFF1E1E1E),
        child: const Center(
          child: Text(
            "Open a file",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final file = File(state.openedFile!);

    String text = "";

    if (file.existsSync()) {
      text = file.readAsStringSync();
    }

    return Container(
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: const Color(0xFF252526),
            child: Text(
              file.uri.pathSegments.last,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: text),
              expands: true,
              minLines: null,
              maxLines: null,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
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
