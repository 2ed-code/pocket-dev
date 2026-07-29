import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/file_node.dart';
import '../../core/state/workspace_state.dart';

class ExplorerPanel extends StatefulWidget {
  const ExplorerPanel({super.key});

  @override
  State<ExplorerPanel> createState() => _ExplorerPanelState();
}

class _ExplorerPanelState extends State<ExplorerPanel> {
  List<FileNode> nodes = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    final dir = Directory.current;

    nodes = dir.listSync().map((e) {
      return FileNode(
        name: e.uri.pathSegments.last,
        path: e.path,
        isDirectory: e is Directory,
      );
    }).toList();

    nodes.sort((a, b) {
      if (a.isDirectory && !b.isDirectory) return -1;
      if (!a.isDirectory && b.isDirectory) return 1;
      return a.name.compareTo(b.name);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF252526),
      child: Column(
        children: [
          Container(
            height: 42,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Text(
              "EXPLORER",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nodes.length,
              itemBuilder: (context, index) {
                final node = nodes[index];

                return ListTile(
                  dense: true,
                  leading: Icon(
                    node.isDirectory
                        ? Icons.folder
                        : Icons.insert_drive_file,
                    color: node.isDirectory
                        ? Colors.amber
                        : Colors.white70,
                    size: 18,
                  ),
                  title: Text(
                    node.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  onTap: () {
                    if (!node.isDirectory) {
                      context
                          .read<WorkspaceState>()
                          .openFile(node.path);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
