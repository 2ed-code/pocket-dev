import 'package:flutter/material.dart';
import '../projects/projects_page.dart';
import '../terminal/terminal_page.dart';
import '../../core/widgets/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PocketDev")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            HomeCard(
              icon: Icons.folder_open,
              title: "Projects",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProjectsPage(),
                ),
              ),
            ),
            const HomeCard(
              icon: Icons.code,
              title: "Editor",
            ),
            HomeCard(
              icon: Icons.terminal,
              title: "Terminal",
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TerminalPage(),
                ),
              ),
            ),
            const HomeCard(
              icon: Icons.source,
              title: "Git",
            ),
            const HomeCard(
              icon: Icons.cloud,
              title: "Codespaces",
            ),
            const HomeCard(
              icon: Icons.settings,
              title: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
