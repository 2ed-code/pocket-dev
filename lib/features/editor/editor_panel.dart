import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/editor_state.dart';
import '../../core/state/workspace_state.dart';
import '../../core/widgets/line_numbers.dart';

class EditorPanel extends StatelessWidget {
  const EditorPanel({super.key});

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

    final file = workspace.currentFile!;

    final controller =
        context.read<EditorState>().controllerFor(
              file.path,
              file.content,
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
                    itemBuilder: (_, index) {
                      final tab = workspace.openedFiles[index];

                      return InkWell(
                        onTap: () {
                          workspace.select(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          color: workspace.selectedIndex == index
                              ? const Color(0xff1e1e1e)
                              : const Color(0xff2d2d2d),
                          child: Center(
                            child: Text(
                              tab.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: workspace.saveCurrentFile,
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                LineNumbers(
                  text: controller.text,
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
                      fontFamily: "monospace",
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
          ),
        ],
      ),
    );
  }
}
