import 'package:flutter/material.dart';
import 'login_screen.dart'; // استدعاء صفحة اللوجين
import '../../../core/theme/colors.dart'; // استدعاء الألوان
import '../../home/screens/main_layout.dart'; // 1. استدعاء الشاشة الرئيسية هنا

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // مفاتيح التحكم في الحقول
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            const SizedBox(width: 8),
            const Text(
              "GEAR UP",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 1. العناوين
            const Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Join GEAR UP today", style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),

            const SizedBox(height: 24),

            // 2. حقل الاسم الكامل
            _buildLabel("Full Name"),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Your full name",
                prefixIcon: Icon(Icons.person_outline, color: AppColors.textHint),
              ),
            ),
            const SizedBox(height: 16),

            // 3. حقل الإيميل
            _buildLabel("Email"),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "your@email.com",
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
              ),
            ),
            const SizedBox(height: 16),

            // 4. حقل رقم الهاتف
            _buildLabel("Phone Number"),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "+20 123 456 7890",
                prefixIcon: Icon(Icons.phone_outlined, color: AppColors.textHint),
              ),
            ),
            const SizedBox(height: 16),

            // 5. حقل كلمة السر
            _buildLabel("Password"),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "••••••••",
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textHint),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 6. تأكيد كلمة السر
            _buildLabel("Confirm Password"),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                hintText: "••••••••",
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textHint),
                  onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 7. زرار إنشاء الحساب
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // 2. التعديل هنا: الانتقال للشاشة الرئيسية بعد التسجيل
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                  );
                },
                child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 24),

            // 8. الرجوع لتسجيل الدخول
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: AppColors.textSecondary)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Login", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

            const SizedBox(height: 20), // مسافة أمان تحت
          ],
        ),
      ),
    );
  }

  // دالة صغيرة عشان منكررش كود الـ Text كل شوية
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}