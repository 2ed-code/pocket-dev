import 'package:flutter/material.dart';

class EditorState extends ChangeNotifier {
  final Map<String, TextEditingController> _controllers = {};

  TextEditingController controllerFor(
    String path,
    String content,
  ) {
    return _controllers.putIfAbsent(
      path,
      () => TextEditingController(text: content),
    );
  }

  void disposeController(String path) {
    _controllers.remove(path)?.dispose();
    notifyListeners();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }
}
