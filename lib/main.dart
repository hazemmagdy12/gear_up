import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'features/intro/screens/splash_screen.dart'; // 1. استدعاء ملف السبلاش

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GearUpApp());
}

class GearUpApp extends StatelessWidget {
  const GearUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gear Up',
      theme: AppTheme.lightTheme, // الثيم بتاعنا
      home: const SplashScreen(), // 2. البداية من شاشة اللوجو
    );
  }
}