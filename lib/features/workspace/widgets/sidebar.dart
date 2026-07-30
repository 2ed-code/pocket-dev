import 'package:flutter/material.dart';

class WorkspaceSidebar extends StatelessWidget {
  const WorkspaceSidebar({
    super.key,
    required this.index,
    required this.onSelect,
  });

  final int index;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: index,
      onDestinationSelected: onSelect,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.folder),
          label: Text("Files"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.terminal),
          label: Text("Terminal"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.source),
          label: Text("Git"),
        ),
      ],
    );
  }
}
