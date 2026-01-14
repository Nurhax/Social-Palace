import 'package:flutter/material.dart';
import 'Pages/loading_screen.dart';

void main() {
  runApp(const SoPalApp());
}

class SoPalApp extends StatelessWidget {
  const SoPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoPal',
      theme: ThemeData(
        // Set standard bright theme but with our red accent color
        brightness: Brightness.light,
        primaryColor: const Color(0xFFCE3333),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCE3333),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // Start with the LoadingScreen
      home: const LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
