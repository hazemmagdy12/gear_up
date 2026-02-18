import 'package:flutter/material.dart';
import 'dart:async'; // عشان نستخدم التايمر
import 'welcome_screen.dart'; // استدعاء الصفحة اللي هنروحلها

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // مؤقت لمدة 3 ثواني وبعدين ينقلنا للصفحة اللي بعدها
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اللوجو
            Image.asset(
              'assets/images/logo.png',
              width: 150, // حجم اللوجو
              height: 150,
            ),
            const SizedBox(height: 20),
            // اسم التطبيق تحت اللوجو (اختياري)
            const Text(
              "GEAR UP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F5F8B), // نفس اللون الأزرق الأساسي
              ),
            ),
          ],
        ),
      ),
    );
  }
}