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

    setState(() {});
  }

  Future<void> create(bool folder) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(folder ? "New Folder" : "New File"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () async {
              final path =
                  "${current.path}/${controller.text.trim()}";

              if (folder) {
                await FileService.createFolder(path);
              } else {
                await FileService.createFile(path);
              }

              if (mounted) Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );

    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(current.path.split("/").last),
        actions: [
          IconButton(
            icon: const Icon(Icons.create_new_folder),
            onPressed: () => create(true),
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: () => create(false),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: load,
          ),
        ],
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
