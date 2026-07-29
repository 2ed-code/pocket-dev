import 'package:flutter/material.dart';
import '../../core/data/projects.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final p = projects[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: Text(p.name),
              subtitle: Text(p.path),
              trailing: Text(p.language),
            ),
          );
        },
      ),
    );
  }
}
