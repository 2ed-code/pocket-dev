import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TerminalPanel extends StatefulWidget {
  const TerminalPanel({super.key});

  @override
  State<TerminalPanel> createState() => _TerminalPanelState();
}

class _TerminalPanelState extends State<TerminalPanel> {
  final controller = TextEditingController();
  final scroll = ScrollController();
  final focus = FocusNode();

  final List<String> output = [];
  final List<String> history = [];

  int historyIndex = -1;

  Process? process;

  bool running = false;

  Future<void> execute() async {
    final cmd = controller.text.trim();

    if (cmd.isEmpty || running) return;

    history.add(cmd);
    historyIndex = history.length;

    controller.clear();

    setState(() {
      running = true;
      output.add("\$ $cmd");
    });

    process = await Process.start(
      "bash",
      ["-c", cmd],
      workingDirectory: Directory.current.path,
    );

    process!.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(addLine);

    process!.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(addLine);

    await process!.exitCode;

    setState(() {
      running = false;
    });
  }

  void addLine(String text) {
    setState(() {
      output.add(text);
    });

    Future.delayed(const Duration(milliseconds: 30), () {
      if (scroll.hasClients) {
        scroll.jumpTo(scroll.position.maxScrollExtent);
      }
    });
  }

  void previousHistory() {
    if (history.isEmpty) return;

    historyIndex--;

    if (historyIndex < 0) {
      historyIndex = 0;
    }

    controller.text = history[historyIndex];
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
  }

  void nextHistory() {
    if (history.isEmpty) return;

    historyIndex++;

    if (historyIndex >= history.length) {
      historyIndex = history.length;
      controller.clear();
      return;
    }

    controller.text = history[historyIndex];
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: focus,
      onKeyEvent: (_, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;

        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          previousHistory();
          return KeyEventResult.handled;
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          nextHistory();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: Container(
        color: const Color(0xff181818),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scroll,
                itemCount: output.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  child: Text(
                    output[i],
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: "monospace",
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: controller,
              onSubmitted: (_) => execute(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "monospace",
              ),
              decoration: const InputDecoration(
                prefixText: "\$ ",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
