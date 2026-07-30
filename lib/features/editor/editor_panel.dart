import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/workspace_state.dart';

class EditorPanel extends StatefulWidget {
  const EditorPanel({super.key});

  @override
  State<EditorPanel> createState() => _EditorPanelState();
}

class _EditorPanelState extends State<EditorPanel> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final workspace = context.watch<WorkspaceState>();

    if (workspace.currentFile == null) {
      return Container(
        color: const Color(0xff1e1e1e),
        child: const Center(
          child: Text(
            "Open a file",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    controller.value = TextEditingValue(
      text: workspace.currentFile!.content,
      selection: TextSelection.collapsed(
        offset: workspace.currentFile!.content.length,
      ),
    );

    return Container(
      color: const Color(0xff1e1e1e),
      child: Column(
        children: [
          Container(
            height: 38,
            color: const Color(0xff252526),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workspace.openedFiles.length,
                    itemBuilder: (context, index) {
                      final tab = workspace.openedFiles[index];

                      return InkWell(
                        onTap: () => workspace.select(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          margin: const EdgeInsets.only(right: 1),
                          color: workspace.selectedIndex == index
                              ? const Color(0xff1e1e1e)
                              : const Color(0xff2d2d2d),
                          child: Row(
                            children: [
                              Text(
                                tab.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => workspace.close(index),
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
                ),
                IconButton(
                  onPressed: () async {
                    await workspace.saveCurrentFile();
                  },
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              expands: true,
              minLines: null,
              maxLines: null,
              onChanged: workspace.updateContent,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
