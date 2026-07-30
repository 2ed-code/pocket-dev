import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/services/file_actions.dart';
import '../editor/editor_page.dart';

class ExplorerPage extends StatefulWidget {
  final String path;

  const ExplorerPage({
    super.key,
    required this.path,
  });

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  final actions = FileActions();

  late Directory dir;

  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    dir = Directory(widget.path);
    load();
  }

  void load() {
    files = dir.listSync();

    files.sort((a, b) {
      if (a is Directory && b is! Directory) return -1;
      if (a is! Directory && b is Directory) return 1;
      return a.path.compareTo(b.path);
    });

    if (mounted) setState(() {});
  }

  Future<void> createFile() async {
    final c = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("New File"),
        content: TextField(controller: c),
        actions: [
          FilledButton(
            onPressed: () async {
              await actions.newFile("${dir.path}/${c.text}");
              if (mounted) Navigator.pop(context);
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );

    load();
  }

  Future<void> createFolder() async {
    final c = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("New Folder"),
        content: TextField(controller: c),
        actions: [
          FilledButton(
            onPressed: () async {
              await actions.newFolder("${dir.path}/${c.text}");
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
        title: Text(dir.path.split('/').last),
        actions: [
          IconButton(
            icon: const Icon(Icons.create_new_folder),
            onPressed: createFolder,
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: createFile,
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
          final f = files[i];

          return ListTile(
            leading: Icon(
              f is Directory
                  ? Icons.folder
                  : Icons.description,
            ),
            title: Text(f.path.split('/').last),
            onTap: () {
              if (f is Directory) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExplorerPage(path: f.path),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditorPage(path: f.path),
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
