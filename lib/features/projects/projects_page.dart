import 'package:flutter/material.dart';
import '../../core/data/projects.dart';
import '../new_project/new_project_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NewProjectPage(),
            ),
          );
        },
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final p = projects[index];

          return Card(
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
