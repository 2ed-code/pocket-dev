import 'package:flutter/material.dart';

class EditorTabs extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final ValueChanged<int> onSelected;
  final ValueChanged<int>? onClose;

  const EditorTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onSelected,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: const Color(0xff2d2d30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (_, i) {
          final active = i == selected;

          return InkWell(
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xff1e1e1e)
                    : const Color(0xff2d2d30),
                border: Border(
                  bottom: BorderSide(
                    color: active ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    tabs[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => onClose?.call(i),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white70,
                    ),
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
