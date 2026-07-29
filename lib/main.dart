import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'core/state/editor_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EditorState(),
      child: const PocketDevApp(),
    ),
  );
}
