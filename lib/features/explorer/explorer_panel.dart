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
  late FileNode root;

  @override
  void initState() {
    super.initState();
    root = _buildTree(Directory.current);
    root.expanded = true;
  }

  FileNode _buildTree(Directory dir) {
    final children = <FileNode>[];

    for (final entity in dir.listSync()) {
      if (entity is Directory) {
        children.add(_buildTree(entity));
      } else if (entity is File) {
        children.add(
          FileNode(
            name: entity.uri.pathSegments.last,
            path: entity.path,
            isDirectory: false,
          ),
        );
      }
    }

    children.sort((a, b) {
      if (a.isDirectory != b.isDirectory) {
        return a.isDirectory ? -1 : 1;
      }
      return a.name.compareTo(b.name);
    });

    return FileNode(
      name: dir.uri.pathSegments.isEmpty
          ? dir.path
          : dir.uri.pathSegments.last,
      path: dir.path,
      isDirectory: true,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF252526),
      child: ListView(
        children: _buildWidgets(root.children, 0),
      ),
    );
  }

  List<Widget> _buildWidgets(List<FileNode> nodes, int level) {
    final widgets = <Widget>[];

    for (final node in nodes) {
      widgets.add(
        InkWell(
          onTap: () {
            if (node.isDirectory) {
              setState(() {
                node.expanded = !node.expanded;
              });
            } else {
              context.read<WorkspaceState>().openFile(node.path);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: level * 16.0),
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  if (node.isDirectory)
                    Icon(
                      node.expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      size: 18,
                      color: Colors.white70,
                    )
                  else
                    const SizedBox(width: 18),
                  Icon(
                    node.isDirectory
                        ? Icons.folder
                        : Icons.insert_drive_file,
                    size: 18,
                    color: node.isDirectory
                        ? Colors.amber
                        : Colors.white70,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      node.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      if (node.isDirectory && node.expanded) {
        widgets.addAll(_buildWidgets(node.children, level + 1));
      }
    }

    return widgets;
  }
}
