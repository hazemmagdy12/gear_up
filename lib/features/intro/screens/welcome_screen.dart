import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/signup_screen.dart';
import '../../home/screens/main_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // 1. اللوجو
              Image.asset(
                'assets/images/logo.png',
                height: 120,
                width: 120,
              ),

              // التعديل الأول: تقليل المسافة جداً
              const SizedBox(height: 4),

              // 2. العنوان الرئيسي (بالتدرج اللوني)
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
                  textAlign: TextAlign.center,
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
              const SizedBox(height: 8),

              // 3. العنوان الفرعي
              const Text(
                "Your Premium Car Companion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),

              const Spacer(flex: 1),

              // 4. زرار Skip
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Skip to Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),

              // 5. زرار Login
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 16),

              // 6. زرار Sign Up
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}