import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'core/state/editor_state.dart';
import 'core/state/workspace_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkspaceState(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditorState(),
        ),
      ],
      child: const PocketDevApp(),
    ),
  );
}
