import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/cubit/theme_cubit.dart';
import '../../../core/localization/app_lang.dart'; // 1. استدعاء القاموس
import '../../../core/localization/cubit/locale_cubit.dart'; // 2. استدعاء مخ اللغة
import 'change_password_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isPushEnabled = true;
  bool isAnalyticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {

            final isDarkMode = themeMode == ThemeMode.dark;
            final isEnglish = locale.languageCode == 'en';

            return Scaffold(
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
                    Text(AppLang.tr(context, 'settings'), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: isDarkMode ? Colors.white : Colors.black87)),
                    const SizedBox(height: 4),
                    Text(AppLang.tr(context, 'manage_preferences'), style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
                    const SizedBox(height: 32),

                    Text(AppLang.tr(context, 'app_preferences'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                    const SizedBox(height: 16),

                    _buildSwitchTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'dark_mode'),
                      subtitle: isDarkMode ? AppLang.tr(context, 'dark_enabled') : AppLang.tr(context, 'light_enabled'),
                      icon: Icons.light_mode_outlined,
                      value: isDarkMode,
                      onChanged: (val) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),

                    _buildSwitchTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'push_notifications'), subtitle: AppLang.tr(context, 'receive_updates'),
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppLang.tr(context, 'language'), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDarkMode ? Colors.white : Colors.black87)),
                                    const SizedBox(height: 4),
                                    Text(AppLang.tr(context, 'select_language'), style: TextStyle(color: isDarkMode ? Colors.white70 : AppColors.textSecondary, fontSize: 13)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => context.read<LocaleCubit>().changeLanguage('en'),
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
                                  onTap: () => context.read<LocaleCubit>().changeLanguage('ar'),
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

                    Text(AppLang.tr(context, 'security_privacy'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                    const SizedBox(height: 16),

                    _buildNavigationTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'change_password'), subtitle: AppLang.tr(context, 'update_password'), icon: Icons.lock_outline,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen())),
                    ),

                    _buildNavigationTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'privacy_policy'), subtitle: AppLang.tr(context, 'terms_privacy'), icon: Icons.shield_outlined,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen())),
                    ),

                    const SizedBox(height: 8),
                    Text(AppLang.tr(context, 'support_about'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black87)),
                    const SizedBox(height: 16),

                    _buildNavigationTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'help_center'), subtitle: AppLang.tr(context, 'get_support'), icon: Icons.help_outline,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterScreen())),
                    ),

                    _buildSwitchTile(
                      isDarkMode: isDarkMode,
                      title: AppLang.tr(context, 'analytics'), subtitle: AppLang.tr(context, 'help_improve'),
                      icon: Icons.remove_red_eye_outlined, value: isAnalyticsEnabled,
                      onChanged: (val) => setState(() => isAnalyticsEnabled = val),
                    ),

                    const SizedBox(height: 40),

                    // التعديل هنا: ترجمة النسخة وحقوق الملكية
                    Center(
                      child: Column(
                        children: [
                          Text(AppLang.tr(context, 'version'), style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(AppLang.tr(context, 'copyright'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
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
      },
    );
  }

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