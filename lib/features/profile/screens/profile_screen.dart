import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/signup_screen.dart';
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
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: isLoggedIn ? _buildLoggedInProfile() : _buildUnloggedProfile(),
      ),
      // مفيش FloatingActionButton هنا عشان ميتداخلش مع البار السفلي
    );
  }

  Widget _buildLoggedInProfile() {
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
              child: Row(
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
                    child: const Center(
                      child: Text("SA", style: TextStyle(color: AppColors.primary, fontSize: 26, fontWeight: FontWeight.w900)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("safds", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 6),
                        Text("safds@sg", style: TextStyle(color: Colors.white70, fontSize: 14)),
                        SizedBox(height: 4),
                        Text("+20 123 456 7890", style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: Text("My Account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87)),
          ),

          _buildMenuCard(
            title: "Start Selling", subtitle: "List a new item", icon: Icons.attach_money_outlined, iconColor: const Color(0xFF2E7D32),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StartSellingScreen())),
          ),
          _buildMenuCard(
            title: "Published Items", subtitle: "Manage your listings", icon: Icons.inventory_2_outlined, iconColor: const Color(0xFF1976D2),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PublishedItemsScreen())),
          ),
          _buildMenuCard(
            title: "Account Information", subtitle: "Name, email, phone", icon: Icons.person_outline, iconColor: const Color(0xFFF57C00),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInformationScreen())),
          ),
          _buildMenuCard(
            title: "Edit Profile", subtitle: "Update your information", icon: Icons.edit_outlined, iconColor: const Color(0xFF0097A7),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
          ),
          // تم إزالة كارت My Car من هنا نهائياً
          _buildMenuCard(
            title: "Payments", subtitle: "Manage Payment Methods", icon: Icons.credit_card_outlined, iconColor: const Color(0xFF388E3C),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentsScreen())),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 16.0, bottom: 16.0),
            child: Text("App", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87)),
          ),

          _buildMenuCard(
            title: "Settings", subtitle: "Preferences, Privacy, Help", icon: Icons.settings_outlined, iconColor: const Color(0xFF616161),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.white, size: 22),
              label: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.0)),
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

  Widget _buildUnloggedProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFEEEEEE), width: 2),
            ),
            child: Image.asset('assets/images/logo.png', height: 60, width: 60),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF2E86AB), Color(0xFF0A3656)]).createShader(bounds),
            child: const Text("GEAR UP", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.white)),
          ),
          const SizedBox(height: 4),
          const Text("Egypt's #1 Car App", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          const SizedBox(height: 40),

          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())), icon: const Icon(Icons.login, color: Colors.white, size: 20), label: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
          const SizedBox(height: 16),
          SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())), icon: const Icon(Icons.person_add_outlined, color: Colors.black, size: 20), label: const Text("Sign Up", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
          const SizedBox(height: 40),

          _buildMenuCard(title: "Settings", subtitle: "Preferences, Privacy, Help", icon: Icons.settings_outlined, iconColor: const Color(0xFF616161), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()))),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required String title, required String subtitle, required IconData icon, required Color iconColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.textHint, size: 16),
          ],
        ),
      ),
    );
  }
}