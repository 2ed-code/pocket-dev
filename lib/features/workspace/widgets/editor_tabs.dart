import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  const EditorTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelect,
    required this.onClose,
  });

  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onClose;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (_, i) {
          final active = i == selected;

          return InkWell(
            onTap: () => onSelect(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              color: active
                  ? Theme.of(context).colorScheme.surface
                  : Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tabs[i]),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => onClose(i),
                    child: const Icon(Icons.close, size: 16),
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
