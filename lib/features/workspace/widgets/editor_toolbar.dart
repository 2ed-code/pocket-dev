import 'package:flutter/material.dart';

class EditorToolbar extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onSearch;
  final VoidCallback? onFormat;

  const EditorToolbar({
    super.key,
    this.onSave,
    this.onSearch,
    this.onFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: const Color(0xff252526),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            tooltip: "Save",
            onPressed: onSave,
            icon: const Icon(Icons.save, size: 18),
          ),
          IconButton(
            tooltip: "Search",
            onPressed: onSearch,
            icon: const Icon(Icons.search, size: 18),
          ),
          IconButton(
            tooltip: "Format",
            onPressed: onFormat,
            icon: const Icon(Icons.auto_fix_high, size: 18),
          ),
          const Spacer(),
          const Text(
            "Pocket Dev",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
