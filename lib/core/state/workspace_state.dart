import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/open_file.dart';

class WorkspaceState extends ChangeNotifier {
  final List<OpenFile> openedFiles = [];

  int selectedIndex = -1;

  OpenFile? get currentFile {
    if (selectedIndex < 0 || selectedIndex >= openedFiles.length) {
      return null;
    }
    return openedFiles[selectedIndex];
  }

  Future<void> openFile(String path) async {
    final index = openedFiles.indexWhere((e) => e.path == path);

    if (index != -1) {
      selectedIndex = index;
      notifyListeners();
      return;
    }

    final file = File(path);

    openedFiles.add(
      OpenFile(
        path: path,
        name: file.uri.pathSegments.last,
        content: await file.readAsString(),
      ),
    );

    selectedIndex = openedFiles.length - 1;

    notifyListeners();
  }

  void select(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void close(int index) {
    openedFiles.removeAt(index);

    if (openedFiles.isEmpty) {
      selectedIndex = -1;
    } else if (selectedIndex >= openedFiles.length) {
      selectedIndex = openedFiles.length - 1;
    }

    notifyListeners();
  }

  void updateContent(String text) {
    if (currentFile == null) return;

    currentFile!.content = text;

    notifyListeners();
  }

  Future<void> saveCurrentFile() async {
    if (currentFile == null) return;

    await File(currentFile!.path).writeAsString(currentFile!.content);

    notifyListeners();
  }
}
