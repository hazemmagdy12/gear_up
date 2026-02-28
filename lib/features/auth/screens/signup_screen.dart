import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../home/screens/main_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
                  (route) => false,
            );
          } else if (state is AuthError) {
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
                  const SizedBox(height: 10),

                  Text(AppLang.tr(context, 'create_account'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  Text(AppLang.tr(context, 'join_gear_up'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 16)),

                  const SizedBox(height: 24),

                  _buildLabel(AppLang.tr(context, 'full_name'), isDark),
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                    decoration: InputDecoration(hintText: AppLang.tr(context, 'full_name_hint'), prefixIcon: const Icon(Icons.person_outline, color: AppColors.textHint)),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel(AppLang.tr(context, 'email'), isDark),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    decoration: InputDecoration(hintText: AppLang.tr(context, 'email_hint'), prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textHint)),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel(AppLang.tr(context, 'phone_number'), isDark),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    decoration: InputDecoration(hintText: AppLang.tr(context, 'phone_hint'), prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textHint)),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel(AppLang.tr(context, 'password'), isDark),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                    decoration: InputDecoration(
                      hintText: AppLang.tr(context, 'password_hint'),
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                      suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textHint), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel(AppLang.tr(context, 'confirm_password'), isDark),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLang.tr(context, 'password_hint'),
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textHint),
                      suffixIcon: IconButton(icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: AppColors.textHint), onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(), // التعديل هنا: تمرير رقم الهاتف
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text(AppLang.tr(context, 'sign_up'), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppLang.tr(context, 'already_have_account'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary)),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                        child: Text(AppLang.tr(context, 'login'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
    );
  }
}