import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';
import '../../../core/local_storage/cache_helper.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_state.dart'; // استدعاء ملف الـ States
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/signup_screen.dart';
import '../../intro/screens/welcome_screen.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';
import 'published_items_screen.dart';
import 'start_selling_screen.dart';
import 'account_information_screen.dart';
import 'payments_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    // التعديل هنا: أول ما الشاشة تفتح، بنطلب من الكوبيت يجيب الداتا لو مش موجودة
    final authCubit = context.read<AuthCubit>();
    if (CacheHelper.getData(key: 'uid') != null && authCubit.currentUser == null) {
      authCubit.getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bool isLoggedIn = CacheHelper.getData(key: 'uid') != null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: isLoggedIn ? _buildLoggedInProfile(isDark) : _buildUnloggedProfile(isDark),
      ),
    );
  }

  Widget _buildLoggedInProfile(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountInformationScreen())
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              // التعديل الأهم: مراقبة حالة الداتا وعرضها
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final user = context.read<AuthCubit>().currentUser;

                  // إظهار تحميل لو الداتا لسه بتيجي
                  if (state is GetUserLoading && user == null) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  }

                  // تجهيز البيانات
                  String name = user?.name ?? 'User';
                  String email = user?.email ?? '';
                  String phone = user?.phone ?? '';

                  // لوجيك لاستخراج أول حرفين من الاسم لعرضهم في الصورة
                  String initials = "U";
                  if (user != null && name.isNotEmpty) {
                    List<String> nameParts = name.trim().split(' ');
                    if (nameParts.length > 1 && nameParts[1].isNotEmpty) {
                      initials = '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
                    } else {
                      initials = name[0].toUpperCase();
                    }
                  }

                  return Row(
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                        ),
                        child: Center(
                          child: Text(initials, style: const TextStyle(color: AppColors.primary, fontSize: 26, fontWeight: FontWeight.w900)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            if (email.isNotEmpty)
                              Text(email, style: const TextStyle(color: Colors.white70, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 4),
                            if (phone.isNotEmpty)
                              Text(phone, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: Text(AppLang.tr(context, 'my_account'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
          ),

          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'start_selling'), subtitle: AppLang.tr(context, 'list_new_item'), icon: Icons.attach_money_outlined, iconColor: const Color(0xFF2E7D32),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StartSellingScreen())),
          ),
          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'published_items'), subtitle: AppLang.tr(context, 'manage_listings'), icon: Icons.inventory_2_outlined, iconColor: const Color(0xFF1976D2),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PublishedItemsScreen())),
          ),
          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'account_information'), subtitle: AppLang.tr(context, 'account_info_sub'), icon: Icons.person_outline, iconColor: const Color(0xFFF57C00),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInformationScreen())),
          ),
          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'edit_profile'), subtitle: AppLang.tr(context, 'edit_profile_sub'), icon: Icons.edit_outlined, iconColor: const Color(0xFF0097A7),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
          ),
          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'payments'), subtitle: AppLang.tr(context, 'manage_payment_methods'), icon: Icons.credit_card_outlined, iconColor: const Color(0xFF388E3C),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentsScreen())),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
            child: Text(AppLang.tr(context, 'app_section'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
          ),

          _buildMenuCard(
            isDark: isDark,
            title: AppLang.tr(context, 'settings'), subtitle: AppLang.tr(context, 'settings_sub'), icon: Icons.settings_outlined, iconColor: const Color(0xFF616161),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await context.read<AuthCubit>().logout();

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                        (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 22),
              label: Text(AppLang.tr(context, 'logout'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.0)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC3545),
                padding: const EdgeInsets.symmetric(vertical: 20),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildUnloggedProfile(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              shape: BoxShape.circle,
              border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE), width: 2),
            ),
            child: Image.asset('assets/images/logo.png', height: 60, width: 60),
          ),
          const SizedBox(height: 16),
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
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        color: isDark ? const Color(0xFF64B5F6).withOpacity(0.6) : Colors.black.withOpacity(0.3),
                        offset: Offset(0, isDark ? 0 : 3),
                        blurRadius: isDark ? 10 : 5
                    )
                  ],
                )
            ),
          ),
          const SizedBox(height: 4),
          Text(AppLang.tr(context, 'egypt_car_app'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
          const SizedBox(height: 40),

          SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                  icon: const Icon(Icons.login, color: Colors.white, size: 20),
                  label: Text(AppLang.tr(context, 'login'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))
              )
          ),
          const SizedBox(height: 16),
          SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
                  icon: Icon(Icons.person_add_outlined, color: isDark ? Colors.white : Colors.black, size: 20),
                  label: Text(AppLang.tr(context, 'sign_up'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))
              )
          ),
          const SizedBox(height: 40),

          _buildMenuCard(
              isDark: isDark,
              title: AppLang.tr(context, 'settings'), subtitle: AppLang.tr(context, 'settings_sub'), icon: Icons.settings_outlined, iconColor: const Color(0xFF616161),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()))
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required bool isDark, required String title, required String subtitle, required IconData icon, required Color iconColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.03), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconColor.withOpacity(isDark ? 0.2 : 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: isDark ? Colors.white54 : AppColors.textHint, size: 16),
          ],
        ),
      ),
    );
  }
}