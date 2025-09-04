import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFCE3333), // Set background color
        body: Center(
          child: Image.asset(
            'assets/logov1.png',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.7,
            fit: BoxFit.contain,
          ), // Display the image
        ),
      ),
    );
  }
}
