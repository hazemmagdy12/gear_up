import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'edit_profile_screen.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء الذكاء الاصطناعي

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

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
            const Text("Account Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black87)),
            const SizedBox(height: 4),
            const Text("View your account details", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 40),

            Center(
              child: Column(
                children: [
                  Container(
                    width: 100, // تكبير الصورة قليلاً لتناسب الشاشة
                    height: 100,
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Center(
                      child: Text("SA", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("safds", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 6),
                  const Text("Member Since January 2024", style: TextStyle(color: AppColors.textHint, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            _buildInfoCard(Icons.person_outline, "Full Name", "safds"),
            _buildInfoCard(Icons.email_outlined, "Email Address", "safds@sg"),
            _buildInfoCard(Icons.phone_outlined, "Phone Number", "+20 123 456 7890"),
            _buildInfoCard(Icons.location_on_outlined, "Location", "Cairo, Egypt"),
            _buildInfoCard(Icons.calendar_today_outlined, "Member Since", "January 2024"),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text("Edit Information", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
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

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // تظبيط مسافات الكارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Text(value, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black87)), // تكبير وتوضيح الخط
              ],
            ),
          ),
        ],
      ),
    );
  }
}