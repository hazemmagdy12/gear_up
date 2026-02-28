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
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 4),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // التعديل هنا: ألوان فاتحة ومنورة في الدارك مود
                colors: isDark
                    ? [const Color(0xFF64B5F6), const Color(0xFF1976D2)] // أزرق سماوي لأزرق ساطع
                    : [const Color(0xFF2E86AB), const Color(0xFF0A3656)], // الألوان القديمة لللايت مود
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
                      // التعديل هنا: توهج أزرق خفيف في الدارك مود بدل الظل الأسود الكئيب
                      color: isDark ? const Color(0xFF64B5F6).withOpacity(0.6) : Colors.black.withOpacity(0.3),
                      offset: Offset(0, isDark ? 0 : 3), // شيلنا الأوفسيت في الدارك عشان يبقى توهج مش ضل
                      blurRadius: isDark ? 10 : 5, // كبرنا الانتشار في الدارك
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