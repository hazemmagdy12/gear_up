import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart'; // استدعاء ملف الستيت ضروري هنا

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
    _phoneController = TextEditingController(text: user?.phone ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final user = context.read<AuthCubit>().currentUser;
    String name = user?.name ?? 'User';
    String initials = "U";
    if (name.isNotEmpty) {
      List<String> nameParts = name.trim().split(' ');
      if (nameParts.length > 1 && nameParts[1].isNotEmpty) {
        initials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
      } else {
        initials = name[0].toUpperCase();
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLang.tr(context, 'edit_profile'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      // التعديل هنا: دمجنا البلوك كونسيومر عشان نسمع ونبني في نفس الوقت
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UpdateUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث البيانات بنجاح'), backgroundColor: Colors.green),
            );
            Navigator.pop(context); // يرجع للبروفايل بعد النجاح
          } else if (state is UpdateUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? AppColors.surfaceDark : Colors.white, width: 4),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.1), blurRadius: 15, offset: const Offset(0, 5))],
                      ),
                      child: Center(
                        child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? AppColors.surfaceDark : Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(AppLang.tr(context, 'change_profile_photo'), style: const TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),

                _buildLabelField(AppLang.tr(context, 'full_name'), Icons.person_outline, _nameController, isDark, true),
                const SizedBox(height: 24),
                _buildLabelField(AppLang.tr(context, 'email_address'), Icons.email_outlined, _emailController, isDark, false),
                const SizedBox(height: 24),
                _buildLabelField(AppLang.tr(context, 'phone_number'), Icons.phone_outlined, _phoneController, isDark, true),
                const SizedBox(height: 50),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: state is UpdateUserLoading ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(AppLang.tr(context, 'cancel'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state is UpdateUserLoading ? null : () {
                          // تأكيد إن الحقول مش فاضية قبل ما نبعت للفايربيز
                          if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الاسم ورقم الهاتف مطلوبين'), backgroundColor: Colors.red),
                            );
                            return;
                          }

                          context.read<AuthCubit>().updateUserData(
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: state is UpdateUserLoading
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text(AppLang.tr(context, 'save_changes'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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

  Widget _buildLabelField(String label, IconData icon, TextEditingController controller, bool isDark, bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: isDark ? Colors.white : Colors.black87)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: enabled
                ? (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA))
                : (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}