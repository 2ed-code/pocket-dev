import 'dart:io';

import 'package:flutter/material.dart';

import '../explorer/explorer_page.dart';
import '../git/git_page.dart';
import '../terminal/terminal_page.dart';

import 'widgets/status_bar.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  int page = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      ExplorerPage(
        path: Directory.current.path,
      ),
      const Center(
        child: Text(
          "Open a file from Explorer",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      const TerminalPage(),
      const GitPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pocket Dev"),
      ),

      body: Column(
        children: [
          Expanded(
            child: pages[page],
          ),

          const StatusBar(
            text: "Pocket Dev • Ready",
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: page,

        onDestinationSelected: (i) {
          setState(() {
            page = i;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.folder),
            label: "Explorer",
          ),

          NavigationDestination(
            icon: Icon(Icons.code),
            label: "Editor",
          ),

          NavigationDestination(
            icon: Icon(Icons.terminal),
            label: "Terminal",
          ),

          NavigationDestination(
            icon: Icon(Icons.source),
            label: "Git",
          ),
        ],
      ),
    );
  }
}
