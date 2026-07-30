import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/services/file_service.dart';
import '../editor/editor_page.dart';

class ExplorerPage extends StatefulWidget {
  final String? path;

  const ExplorerPage({super.key, this.path});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  late Directory current;
  List<FileSystemEntity> files = [];

  final FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    current = Directory(widget.path ?? Directory.current.path);
    load();
  }

  void load() {
    files = current.listSync().toList();

    files.sort((a, b) {
      if (a is Directory && b is! Directory) return -1;
      if (a is! Directory && b is Directory) return 1;
      return a.path.compareTo(b.path);
    });

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> delete(FileSystemEntity file) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete"),
        content: Text(file.path.split("/").last),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (ok == true) {
      await fileService.delete(file.path);
      load();
    }
  }

  Future<void> rename(FileSystemEntity file) async {
    final controller = TextEditingController(
      text: file.path.split("/").last,
    );

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Rename"),
        content: TextField(
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () async {
              final parent = File(file.path).parent.path;

              await fileService.rename(
                file.path,
                "$parent/${controller.text}",
              );

              if (mounted) Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );

    load();
  }

  Future<void> menu(FileSystemEntity file) async {
    final value = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Rename"),
              onTap: () => Navigator.pop(context, "rename"),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Delete"),
              onTap: () => Navigator.pop(context, "delete"),
            ),
          ],
        ),
      ),
    );

    if (value == "rename") {
      await rename(file);
    }

    if (value == "delete") {
      await delete(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(current.path.split("/").last),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (_, i) {
          final file = files[i];

          return ListTile(
            leading: Icon(
              file is Directory
                  ? Icons.folder
                  : Icons.insert_drive_file,
            ),
            title: Text(file.path.split("/").last),
            onLongPress: () => menu(file),
            onTap: () {
              if (file is Directory) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExplorerPage(
                      path: file.path,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditorPage(
                      path: file.path,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
