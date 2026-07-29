import 'package:flutter/material.dart';

import '../explorer/explorer_panel.dart';
import '../editor/editor_panel.dart';
import '../terminal/terminal_panel.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 42,
              color: const Color(0xFF1E1E1E),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                "PocketDev",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: const [
                  SizedBox(
                    width: 280,
                    child: ExplorerPanel(),
                  ),
                  VerticalDivider(width: 1),
                  Expanded(
                    child: EditorPanel(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: TerminalPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
