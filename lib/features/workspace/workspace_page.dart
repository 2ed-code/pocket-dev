import 'package:flutter/material.dart';

import '../explorer/explorer_page.dart';
import '../terminal/terminal_page.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PocketDev"),
      ),
      body: Column(
        children: [
          Container(
            height: 42,
            color: Colors.grey.shade900,
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.description,size:18),
                SizedBox(width:6),
                Text("main.dart"),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 280,
                  child: ExplorerPage(),
                ),
                VerticalDivider(width: 1),
                Expanded(
                  child: Center(
                    child: Text(
                      "Open a file",
                      style: TextStyle(fontSize:22),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: TerminalPage(),
          ),
        ],
      ),
    );
  }
}
