import 'package:flutter/material.dart';

class EditorState extends ChangeNotifier {
  final List<String> files = [];

  int current = 0;

  void open(String path) {
    if (!files.contains(path)) {
      files.add(path);
    }

    current = files.indexOf(path);
    notifyListeners();
  }

  void close(String path) {
    files.remove(path);

    if (current >= files.length) {
      current = files.isEmpty ? 0 : files.length - 1;
    }

    notifyListeners();
  }

  String? get currentFile =>
      files.isEmpty ? null : files[current];
}
