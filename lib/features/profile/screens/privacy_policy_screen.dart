import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء الذكاء الاصطناعي

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Privacy Policy", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87)),
            const SizedBox(height: 8),
            const Text("Last updated: October 23, 2025", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 32),

            _buildSectionTitle("1. Information We Collect"),
            _buildParagraph("GEAR UP collects information that you provide directly to us when you create an account, use our services, or communicate with us. This may include your name, email address, phone number, and vehicle information."),
            _buildParagraph("We also automatically collect certain information about your device and how you interact with our app, including your IP address, device type, operating system, and usage patterns."),
            const SizedBox(height: 24),

            _buildSectionTitle("2. How We Use Your Information"),
            _buildParagraph("We use the information we collect to:"),
            _buildBulletPoint("Provide, maintain, and improve our services"),
            _buildBulletPoint("Send you technical notices and support messages"),
            _buildBulletPoint("Respond to your comments and questions"),
            _buildBulletPoint("Provide personalized car recommendations"),
            _buildBulletPoint("Monitor and analyze trends, usage, and activities"),
            _buildBulletPoint("Detect, prevent, and address technical issues"),
            const SizedBox(height: 24),

            _buildSectionTitle("3. Information Sharing"),
            _buildParagraph("We do not sell your personal information. We may share your information only in the following circumstances: with your consent, with service providers who help us operate our business, to comply with legal obligations, or to protect our rights and safety."),
            const SizedBox(height: 24),

            _buildSectionTitle("4. Data Security"),
            _buildParagraph("We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction. However, no internet transmission is ever fully secure or error-free."),
            const SizedBox(height: 24),

            _buildSectionTitle("5. Your Rights and Choices"),
            _buildParagraph("You have the right to:"),
            _buildBulletPoint("Access and update your account information"),
            _buildBulletPoint("Request deletion of your personal data"),
            _buildBulletPoint("Opt-out of marketing communications"),
            _buildBulletPoint("Disable cookies through your browser settings"),
            const SizedBox(height: 24),

            _buildSectionTitle("6. Children's Privacy"),
            _buildParagraph("Our services are not directed to children under 13. We do not knowingly collect personal information from children under 13. If you become aware that a child has provided us with personal information, please contact us."),
            const SizedBox(height: 24),

            _buildSectionTitle("7. Changes to This Policy"),
            _buildParagraph("We may update this privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page and updating the \"Last updated\" date."),
            const SizedBox(height: 24),

            _buildSectionTitle("8. Contact Us"),
            _buildParagraph("If you have any questions about this Privacy Policy, please contact us at:\nEmail: privacy@gearup.com\nPhone: +20 2 1234 5678"),

            const SizedBox(height: 80),
          ],
        ),
      ),
      // زرار الشات العائم للذكاء الاصطناعي
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

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.6),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 8.0),
            child: Icon(Icons.circle, size: 6, color: AppColors.textSecondary),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}