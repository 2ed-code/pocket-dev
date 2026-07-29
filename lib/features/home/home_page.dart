import 'package:flutter/material.dart';
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
          children: const [
            HomeCard(icon: Icons.folder_open,title:"Projects"),
            HomeCard(icon: Icons.code,title:"Editor"),
            HomeCard(icon: Icons.terminal,title:"Terminal"),
            HomeCard(icon: Icons.source,title:"Git"),
            HomeCard(icon: Icons.cloud,title:"Codespaces"),
            HomeCard(icon: Icons.settings,title:"Settings"),
          ],
        ),
      ),
    );
  }
}
