import 'package:flutter/material.dart';

import '../explorer/explorer_page.dart';
import '../git/git_page.dart';
import '../terminal/terminal_page.dart';
import 'widgets/sidebar.dart';
import 'widgets/editor_tabs.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Widget panel;

    switch (index) {
      case 0:
        panel = const ExplorerPage();
        break;
      case 1:
        panel = const TerminalPage();
        break;
      default:
        panel = const GitPage();
    }

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            WorkspaceSidebar(
              index: index,
              onSelect: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  const EditorTabs(),
                  const Divider(height: 1),
                  Expanded(child: panel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
