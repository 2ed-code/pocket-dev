import 'package:flutter/material.dart';

class ActivityBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const ActivityBar({
    super.key,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const icons = [
      Icons.folder,
      Icons.search,
      Icons.source,
      Icons.extension,
    ];

    return Container(
      width: 56,
      color: const Color(0xff252526),
      child: Column(
        children: List.generate(
          icons.length,
          (i) => IconButton(
            onPressed: () => onChanged(i),
            icon: Icon(
              icons[i],
              color: index == i ? Colors.white : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
