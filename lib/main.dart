
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'component/navbar.dart';
import 'component/navbarAnim.dart';
import 'screens/profile.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}