import 'package:flutter/material.dart';

class CommandPalette {
  static Future<void> show(
    BuildContext context, {
    VoidCallback? onSave,
    VoidCallback? onOpenFolder,
    VoidCallback? onNewFile,
    VoidCallback? onGitStatus,
    VoidCallback? onTerminal,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff252526),
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text("New File"),
                onTap: () {
                  Navigator.pop(context);
                  onNewFile?.call();
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder_open),
                title: const Text("Open Folder"),
                onTap: () {
                  Navigator.pop(context);
                  onOpenFolder?.call();
                },
              ),
              ListTile(
                leading: const Icon(Icons.save),
                title: const Text("Save"),
                onTap: () {
                  Navigator.pop(context);
                  onSave?.call();
                },
              ),
              ListTile(
                leading: const Icon(Icons.source),
                title: const Text("Git Status"),
                onTap: () {
                  Navigator.pop(context);
                  onGitStatus?.call();
                },
              ),
              ListTile(
                leading: const Icon(Icons.terminal),
                title: const Text("Terminal"),
                onTap: () {
                  Navigator.pop(context);
                  onTerminal?.call();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
