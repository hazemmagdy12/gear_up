import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart';

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // اللوجو
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),

            // مسافة صغيرة جداً عشان الكلمة تبقى قريبة من اللوجو
            const SizedBox(height: 4),

            // نفس كود الفونت والتدرج اللوني بتاع شاشة الويلكام بالظبط
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E86AB), // أزرق فاتح/تيل من فوق
                  Color(0xFF0A3656), // كحلي/أزرق غامق جداً من تحت
                ],
              ).createShader(bounds),
              child: Text(
                "GEAR UP",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}