import 'package:flutter/material.dart';

import '../workspace/workspace_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PocketDev"),
      ),
      body: Center(
        child: FilledButton.icon(
          icon: const Icon(Icons.code),
          label: const Text("Open Workspace"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const WorkspacePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
