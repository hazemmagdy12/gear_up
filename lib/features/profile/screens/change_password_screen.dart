import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء شات الذكاء الاصطناعي

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
            const Text("Change Password", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87)),
            const SizedBox(height: 8),
            const Text("Update your account password", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 40),

            // حقول إدخال الباسورد بتصميم Premium
            _buildPasswordField("Current Password", _currentPasswordController),
            const SizedBox(height: 24),
            _buildPasswordField("New Password", _newPasswordController),
            const SizedBox(height: 24),
            _buildPasswordField("Confirm New Password", _confirmPasswordController),
            const SizedBox(height: 48),

            // زرار التحديث الفخم
            GestureDetector(
              onTap: () {
                // كود حفظ الباسورد
                Navigator.pop(context);
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
                  children: const [
                    Text("Update Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // زرار الذكاء الاصطناعي الموحد
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

  // دالة مساعدة لرسم حقول الباسورد
  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: TextField(
            controller: controller,
            obscureText: true,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            decoration: const InputDecoration(
              hintText: "••••••••",
              hintStyle: TextStyle(color: AppColors.textHint, letterSpacing: 2.0),
              prefixIcon: Icon(Icons.lock_outline, color: AppColors.textHint, size: 22),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
      ],
    );
  }
}