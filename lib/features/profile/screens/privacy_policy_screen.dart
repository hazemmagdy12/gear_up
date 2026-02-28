import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../../home/widgets/ai_chat_bottom_sheet.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLang.tr(context, 'privacy_policy_title'), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 8),
            Text(AppLang.tr(context, 'last_updated'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 32),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec1_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec1_p1'), isDark),
            _buildParagraph(AppLang.tr(context, 'pp_sec1_p2'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec2_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec2_p1'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b1'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b2'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b3'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b4'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b5'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec2_b6'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec3_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec3_p1'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec4_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec4_p1'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec5_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec5_p1'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec5_b1'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec5_b2'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec5_b3'), isDark),
            _buildBulletPoint(AppLang.tr(context, 'pp_sec5_b4'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec6_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec6_p1'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec7_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec7_p1'), isDark),
            const SizedBox(height: 24),

            _buildSectionTitle(AppLang.tr(context, 'pp_sec8_title')),
            _buildParagraph(AppLang.tr(context, 'pp_sec8_p1'), isDark),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AiChatBottomSheet(),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primary),
      ),
    );
  }

  Widget _buildParagraph(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.6),
      ),
    );
  }

  Widget _buildBulletPoint(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 8.0),
            child: Icon(Icons.circle, size: 6, color: isDark ? Colors.white54 : AppColors.textSecondary),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}