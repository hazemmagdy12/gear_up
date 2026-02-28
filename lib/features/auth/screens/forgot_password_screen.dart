import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
                // التعديل: تدرج لوني زاهي في الدارك مود
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
                      // التعديل: توهج في الدارك مود
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(AppLang.tr(context, 'forgot_password_title'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 12),
            Text(
              AppLang.tr(context, 'forgot_password_desc'),
              style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 32),

            Text(AppLang.tr(context, 'email'), style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: AppLang.tr(context, 'email_hint'),
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textHint),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(AppLang.tr(context, 'send_reset_link'), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLang.tr(context, 'back_to_login'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}