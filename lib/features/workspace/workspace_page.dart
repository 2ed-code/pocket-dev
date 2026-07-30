import 'dart:io';

import 'package:flutter/material.dart';

import '../editor/editor_panel.dart';
import '../explorer/explorer_panel.dart';
import '../terminal/terminal_panel.dart';

import 'widgets/activity_bar.dart';
import 'widgets/command_palette.dart';
import 'widgets/editor_tabs.dart';
import 'widgets/side_bar.dart';
import 'widgets/status_bar.dart';
import 'widgets/terminal_dock.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  int activity = 0;

  String? currentFile;

  final List<String> tabs = [];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pocket Dev"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: "Command Palette",
            onPressed: () {
              CommandPalette.show(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ActivityBar(
                  index: activity,
                  onChanged: (i) {
                    setState(() {
                      activity = i;
                    });
                  },
                ),
                SideBar(
                  child: ExplorerPanel(
                    path: Directory.current.path,
                    onFileSelected: (path) {
                      final name = path.split('/').last;

                      setState(() {
                        currentFile = path;

                        if (!tabs.contains(name)) {
                          tabs.add(name);
                        }

                        selectedTab = tabs.indexOf(name);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      EditorTabs(
                        tabs: tabs.isEmpty ? const ["Welcome"] : tabs,
                        selected: selectedTab,
                        onSelected: (i) {
                          setState(() {
                            selectedTab = i;
                          });
                        },
                      ),
                      Expanded(
                        child: EditorPanel(
                          path: currentFile,
                        ),
                      ),
                      const SizedBox(
                        height: 220,
                        child: TerminalDock(
                          child: TerminalPanel(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const StatusBar(
            text: "Pocket Dev • Ready",
          ),
        ],
      ),
    );
  }
}
