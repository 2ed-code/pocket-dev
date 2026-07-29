import 'dart:io';
import 'package:flutter/material.dart';

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

  Future<void> load() async {
    final dir = Directory.current;

    setState(() {
      files = dir.listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorer"),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (_, i) {
          final f = files[i];

          return ListTile(
            leading: Icon(
              f is Directory ? Icons.folder : Icons.insert_drive_file,
            ),
            title: Text(
              f.path.split("/").last,
            ),
            subtitle: Text(f.path),
          );
        },
      ),
    );
  }
}
