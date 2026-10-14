import 'package:flutter/material.dart';
import 'screen/primary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AFL 1 Case Study',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xC85A32), // Terracotta
          brightness: Brightness.light,
        ),
      ),
      home: const PrimaryScreen(),
    );
  }
}