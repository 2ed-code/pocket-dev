import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'core/state/workspace_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WorkspaceState(),
      child: const PocketDevApp(),
    ),
  );
}
