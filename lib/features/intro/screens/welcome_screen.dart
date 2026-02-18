import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart'; // استدعاء ملف الألوان
import '../../auth/screens/login_screen.dart'; // استدعاء صفحة تسجيل الدخول
import '../../auth/screens/signup_screen.dart'; // 1. استدعاء صفحة إنشاء الحساب

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
            crossAxisAlignment: CrossAxisAlignment.stretch, // عشان الزراير تاخد عرض الشاشة
            children: [
              const Spacer(flex: 2), // مسافة مرنة فوق

              // 1. اللوجو
              Image.asset(
                'assets/images/logo.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 24),

              // 2. العنوان الرئيسي
              const Text(
                "GEAR UP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // الأزرق
                ),
              ),
              const SizedBox(height: 8),

              // 3. العنوان الفرعي
              const Text(
                "Your Premium Car Companion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary, // الرمادي
                ),
              ),

              const Spacer(flex: 1), // مسافة مرنة في النص

              // 4. زرار Skip (أبيض بحدود)
              OutlinedButton(
                onPressed: () {
                  // لسه هنبرمجه يروح للصفحة الرئيسية
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border), // لون الحدود
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // حواف دائرية كاملة
                  ),
                ),
                child: const Text(
                  "Skip to Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),

              // 5. زرار Login (أزرق غامق)
              ElevatedButton(
                onPressed: () {
                  // الانتقال لصفحة تسجيل الدخول
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

              // 6. زرار Sign Up (أسود/رمادي غامق) - تم التفعيل ✅
              ElevatedButton(
                onPressed: () {
                  // الانتقال لصفحة إنشاء حساب
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary, // اللون الأسود
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),

              const Spacer(flex: 1), // مسافة تحت خالص
            ],
          ),
        ),
      ),
    );
  }
}