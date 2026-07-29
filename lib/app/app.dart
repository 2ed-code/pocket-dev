import 'package:flutter/material.dart';
import '../features/home/home_page.dart';

class PocketDevApp extends StatelessWidget {
  const PocketDevApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PocketDev',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF238636),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}
