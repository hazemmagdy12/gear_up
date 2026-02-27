import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. استدعاء البلوك
import '../../../core/theme/colors.dart';
import '../../../core/theme/cubit/theme_cubit.dart'; // 2. استدعاء الكيوبت بتاعنا
import 'change_password_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // شيلنا متغير isDarkMode من هنا لأن الـ Cubit هو اللي ماسك الموضوع
  bool isPushEnabled = true;
  bool isAnalyticsEnabled = true;
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    // 3. بنستخدم BlocBuilder عشان الشاشة تتحدث أول ما الـ Theme يتغير
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        // بنعرف هل إحنا دلوقتي في وضع الدارك ولا لأ
        final isDarkMode = themeMode == ThemeMode.dark;

        return Scaffold(
          // بنغير لون الخلفية بناءً على الثيم
          backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Settings", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text("Manage your app preferences & support", style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 32),

                Text("App Preferences", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 16),

                // 4. زرار الدارك مود مربوط بالـ Cubit
                _buildSwitchTile(
                  isDarkMode: isDarkMode,
                  title: "Dark Mode",
                  subtitle: isDarkMode ? "Dark theme enabled" : "Light theme enabled",
                  icon: Icons.light_mode_outlined,
                  value: isDarkMode, // بياخد القيمة من الـ Cubit
                  onChanged: (val) {
                    // بيبعت أمر للـ Cubit يعكس الثيم
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),

                _buildSwitchTile(
                  isDarkMode: isDarkMode,
                  title: "Push Notifications", subtitle: "Receive updates and reminders",
                  icon: Icons.notifications_none, value: isPushEnabled,
                  onChanged: (val) => setState(() => isPushEnabled = val),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: _cardDecoration(isDarkMode),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: isDarkMode ? Colors.grey[800] : AppColors.surface, shape: BoxShape.circle),
                            child: const Icon(Icons.language, color: AppColors.primary, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Language", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87)),
                              const SizedBox(height: 4),
                              Text("Select your preferred language", style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isEnglish = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: isEnglish ? AppColors.primary : (isDarkMode ? Colors.grey[800] : Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isEnglish ? AppColors.primary : (isDarkMode ? Colors.transparent : AppColors.border)),
                                ),
                                child: Center(
                                  child: Text("English (US)", style: TextStyle(color: isEnglish ? Colors.white : (isDarkMode ? Colors.white : Colors.black87), fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => isEnglish = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: !isEnglish ? AppColors.primary : (isDarkMode ? Colors.grey[800] : Colors.white),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: !isEnglish ? AppColors.primary : (isDarkMode ? Colors.transparent : AppColors.border)),
                                ),
                                child: Center(
                                  child: Text("Arabic (العربية)", style: TextStyle(color: !isEnglish ? Colors.white : (isDarkMode ? Colors.white : Colors.black87), fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Text("Security & Privacy", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 16),

                _buildNavigationTile(
                  isDarkMode: isDarkMode,
                  title: "Change Password", subtitle: "Update your password", icon: Icons.lock_outline,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen())),
                ),

                _buildNavigationTile(
                  isDarkMode: isDarkMode,
                  title: "Privacy Policy", subtitle: "Terms and privacy rules", icon: Icons.shield_outlined,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen())),
                ),

                const SizedBox(height: 8),
                Text("Support & About", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 16),

                _buildNavigationTile(
                  isDarkMode: isDarkMode,
                  title: "Help Center", subtitle: "Get support & FAQ", icon: Icons.help_outline,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterScreen())),
                ),

                _buildSwitchTile(
                  isDarkMode: isDarkMode,
                  title: "Analytics & Performance", subtitle: "Help improve the app",
                  icon: Icons.remove_red_eye_outlined, value: isAnalyticsEnabled,
                  onChanged: (val) => setState(() => isAnalyticsEnabled = val),
                ),

                const SizedBox(height: 40),

                Center(
                  child: Column(
                    children: const [
                      Text("GEAR UP Version 2.0.0", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      SizedBox(height: 4),
                      Text("© 2025 GEAR UP. All rights reserved.", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  // تم تعديل دوال التصميم عشان تقرأ حالة الدارك مود
  BoxDecoration _cardDecoration(bool isDarkMode) {
    return BoxDecoration(
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.03), blurRadius: 15, offset: const Offset(0, 5)),
      ],
    );
  }

  Widget _buildSwitchTile({required bool isDarkMode, required String title, required String subtitle, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(isDarkMode),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isDarkMode ? Colors.grey[800] : AppColors.surface, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({required bool isDarkMode, required String title, String? subtitle, IconData? icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(isDarkMode),
        child: Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: isDarkMode ? Colors.grey[800] : AppColors.surface, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: isDarkMode ? Colors.white54 : AppColors.textHint, size: 16),
          ],
        ),
      ),
    );
  }
}