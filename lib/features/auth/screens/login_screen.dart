import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../../home/screens/main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
            // التعديل هنا: كبرنا اللوجو
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 8),
            // التعديل هنا: نفس ستايل التدرج اللوني والفخامة بتاع الـ Welcome Screen
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E86AB),
                  Color(0xFF0A3656),
                ],
              ).createShader(bounds),
              child: Text(
                "GEAR UP",
                style: TextStyle(
                  fontSize: 26, // حجم مثالي للـ AppBar
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
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
            const SizedBox(height: 20),

            const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Sign in to continue", style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),

            const SizedBox(height: 32),

            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "your@email.com",
                prefixIcon: Icon(Icons.email_outlined, color: AppColors.textHint),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "••••••••",
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textHint,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text("Forgot Password?", style: TextStyle(color: AppColors.primary)),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                  );
                },
                child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 32),

            Row(
              children: const [
                Expanded(child: Divider(color: AppColors.border)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Or continue with", style: TextStyle(color: AppColors.textHint)),
                ),
                Expanded(child: Divider(color: AppColors.border)),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildSocialButton('assets/images/google.png', "Google")),
                const SizedBox(width: 16),
                Expanded(child: _buildSocialButton('assets/images/facebook.png', "Facebook")),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ", style: TextStyle(color: AppColors.textSecondary)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text("Sign up", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath, String label) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
        );
      },
      icon: Image.asset(iconPath, height: 24),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}