import 'package:flutter/material.dart';
import '../../core/data/projects.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: projects.isEmpty
          ? const Center(
              child: Text(
                "No projects yet",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final p = projects[index];

                return Card(
                  color: const Color(0xFF161B22),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.folder),
                    ),
                    title: Text(p.name),
                    subtitle: Text(p.path),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.language),
                        if (p.favorite)
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
