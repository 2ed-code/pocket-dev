import 'package:flutter/material.dart';

class WorkspaceState extends ChangeNotifier {
  String? openedFile;

  void openFile(String path) {
    openedFile = path;
    notifyListeners();
  }
}
