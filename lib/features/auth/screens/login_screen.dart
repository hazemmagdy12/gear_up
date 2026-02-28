import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(width: 8),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF64B5F6), const Color(0xFF1976D2)]
                    : [const Color(0xFF2E86AB), const Color(0xFF0A3656)],
              ).createShader(bounds),
              child: Text(
                "GEAR UP",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: isDark ? const Color(0xFF64B5F6).withOpacity(0.6) : Colors.black.withOpacity(0.2),
                        offset: Offset(0, isDark ? 0 : 2),
                        blurRadius: isDark ? 8 : 4
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // لو نجح، انقل على الرئيسية وامسح الشاشات اللي ورا
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
                  (route) => false,
            );
          } else if (state is AuthError) {
            // لو فشل، طلع رسالة خطأ
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  Text(AppLang.tr(context, 'welcome_back'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  Text(AppLang.tr(context, 'sign_in'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 16)),

                  const SizedBox(height: 32),

                  Text(AppLang.tr(context, 'email'), style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    decoration: _inputDecoration(AppLang.tr(context, 'email_hint'), Icons.email_outlined, isDark),
                  ),

                  const SizedBox(height: 20),

                  Text(AppLang.tr(context, 'password'), style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    decoration: _inputDecoration(AppLang.tr(context, 'password_hint'), Icons.lock_outline, isDark).copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textHint),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())),
                      child: Text(AppLang.tr(context, 'forgot_password_title'), style: const TextStyle(color: AppColors.primary)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // هنا بنكلم الـ Cubit عشان يعمل اللوج إن
                          context.read<AuthCubit>().login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text(AppLang.tr(context, 'login'), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(child: Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(AppLang.tr(context, 'or_continue_with'), style: const TextStyle(color: AppColors.textHint)),
                      ),
                      Expanded(child: Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(child: _buildSocialButton('assets/images/google.png', AppLang.tr(context, 'google'), isDark)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSocialButton('assets/images/facebook.png', AppLang.tr(context, 'facebook'), isDark)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLang.tr(context, 'dont_have_account'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary)),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
                        child: Text(AppLang.tr(context, 'sign_up'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textHint),
      prefixIcon: Icon(icon, color: AppColors.textHint),
      filled: true,
      fillColor: isDark ? const Color(0xFF1E1E1E) : AppColors.surfaceLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
    );
  }

  Widget _buildSocialButton(String iconPath, String label, bool isDark) {
    return OutlinedButton.icon(
      onPressed: () {}, // ده هيتساب مؤقتاً لحد ما نفعل السوشيال ميديا
      icon: Image.asset(iconPath, height: 24),
      label: Text(label, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}