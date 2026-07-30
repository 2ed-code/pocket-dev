import 'dart:io';

import 'package:flutter/material.dart';

class ExplorerPanel extends StatefulWidget {
  final String path;
  final ValueChanged<String>? onFileSelected;

  const ExplorerPanel({
    super.key,
    required this.path,
    this.onFileSelected,
  });

  @override
  State<ExplorerPanel> createState() => _ExplorerPanelState();
}

class _ExplorerPanelState extends State<ExplorerPanel> {
  late List<FileSystemEntity> files;

  @override
  void initState() {
    super.initState();

    files = Directory(widget.path).listSync()
      ..sort((a, b) => a.path.compareTo(b.path));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (_, i) {
        final file = files[i];

        final isDir = file is Directory;

        return ListTile(
          dense: true,
          leading: Icon(
            isDir ? Icons.folder : Icons.description,
          ),
          title: Text(
            file.uri.pathSegments.last,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            if (!isDir) {
              widget.onFileSelected?.call(file.path);
            }
          },
        );
      },
    );
  }
}
