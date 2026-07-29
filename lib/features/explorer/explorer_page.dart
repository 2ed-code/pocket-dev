import 'dart:io';

import 'package:flutter/material.dart';

import '../editor/editor_page.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    files = Directory.current.listSync();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorer"),
        actions: [
          IconButton(
            onPressed: load,
            icon: const Icon(Icons.refresh),
          )
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
                  : Icons.insert_drive_file,
            ),
            title: Text(f.path.split("/").last),
            subtitle: Text(f.path),
            onTap: () {
              if (f is File) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditorPage(
                      path: f.path,
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
