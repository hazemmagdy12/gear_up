import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import 'reminders_screen.dart';
import '../../nearby/screens/nearby_locations_screen.dart';
import 'edit_my_car_screen.dart';

class MyCarScreen extends StatefulWidget {
  const MyCarScreen({super.key});

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    // تحديد الثيم الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // خلفية من الثيم
      body: SafeArea(
        child: isLoggedIn ? _buildLoggedInState(isDark) : _buildUnloggedState(isDark),
      ),
    );
  }

  // ==========================================
  // 1. حالة عدم تسجيل الدخول (Unlogged State)
  // ==========================================
  Widget _buildUnloggedState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight, shape: BoxShape.circle),
                child: const Icon(Icons.lock_outline, size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text(AppLang.tr(context, 'my_car'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 12),
              Text(
                AppLang.tr(context, 'login_signup_msg'),
                textAlign: TextAlign.center,
                style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.login, color: Colors.white, size: 20),
                  label: Text(AppLang.tr(context, 'login'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_outlined, color: AppColors.primary, size: 20),
                  label: Text(AppLang.tr(context, 'sign_up'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 2. حالة تسجيل الدخول (Logged In State)
  // ==========================================
  Widget _buildLoggedInState(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الهيدر
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLang.tr(context, 'my_car'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 4),
              Text(AppLang.tr(context, 'manage_vehicles'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),

          // قسم: بيانات العربية
          _buildSectionHeader(title: AppLang.tr(context, 'my_vehicle'), isDark: isDark),
          const SizedBox(height: 16),
          _buildMyVehicleCard(isDark),
          const SizedBox(height: 32),

          // قسم: التذكيرات القادمة
          _buildSectionHeader(
              title: AppLang.tr(context, 'upcoming_reminders'),
              actionLabel: AppLang.tr(context, 'manage'),
              actionIcon: Icons.settings_outlined,
              isDark: isDark,
              onActionTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RemindersScreen()),
                );
              }
          ),
          const SizedBox(height: 16),
          _buildReminderCard(
            title: "Oil Change", // داتا وهمية مش هتترجم
            date: "2025-11-15",
            daysLeft: "-100 days",
            progress: 0.3,
            progressGradient: [AppColors.primary, const Color(0xFF4FC3F7)],
            glowColor: AppColors.primary,
            isDark: isDark,
            onTap: () => _showEditReminderDialog("Oil Change", "2025-11-15", isDark),
          ),
          _buildReminderCard(
            title: "Tire Rotation",
            date: "2025-12-20",
            daysLeft: "-65 days",
            progress: 0.8,
            progressGradient: [const Color(0xFFD32F2F), const Color(0xFFFF5252)],
            glowColor: Colors.redAccent,
            isDark: isDark,
            onTap: () => _showEditReminderDialog("Tire Rotation", "2025-12-20", isDark),
          ),
          const SizedBox(height: 32),

          // قسم: سجل الصيانة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppLang.tr(context, 'maintenance_history'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              ElevatedButton.icon(
                onPressed: () => _showMaintenanceDialog(isEdit: false, isDark: isDark),
                icon: const Icon(Icons.add, color: Colors.white, size: 16),
                label: Text(AppLang.tr(context, 'add_record'), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  minimumSize: const Size(0, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildMaintenanceCard(
            title: "Oil Change",
            desc: "Engine Oil 5W-30\nSynthetic oil replacement",
            date: "2025-09-15",
            price: "EGP 450",
            isDark: isDark,
            onTap: () => _showMaintenanceDialog(
                isEdit: true,
                isDark: isDark,
                initialTitle: "Oil Change",
                initialDesc: "Engine Oil 5W-30\nSynthetic oil replacement",
                initialDate: "2025-09-15",
                initialPrice: "450"
            ),
          ),
          _buildMaintenanceCard(
            title: "Tire Rotation",
            desc: "All Tires\nAll four tires rotated",
            date: "2025-07-20",
            price: "EGP 200",
            isDark: isDark,
            onTap: () => _showMaintenanceDialog(
                isEdit: true,
                isDark: isDark,
                initialTitle: "Tire Rotation",
                initialDesc: "All Tires\nAll four tires rotated",
                initialDate: "2025-07-20",
                initialPrice: "200"
            ),
          ),

          const SizedBox(height: 32),

          // زرار Service Centers
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyLocationsScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on_outlined, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text(AppLang.tr(context, 'service_centers'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.0)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // --- دوال مساعدة لرسم الأجزاء (Widgets) ---

  Widget _buildSectionHeader({required String title, required bool isDark, String? actionLabel, IconData? actionIcon, VoidCallback? onActionTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
        if (actionLabel != null && actionIcon != null && onActionTap != null)
          OutlinedButton.icon(
            onPressed: onActionTap,
            icon: Icon(actionIcon, size: 16, color: isDark ? Colors.white70 : AppColors.textSecondary),
            label: Text(actionLabel, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
          ),
      ],
    );
  }

  Widget _buildMyVehicleCard(bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditMyCarScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.04), blurRadius: 15, offset: const Offset(0, 8))
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _showCarImageFullScreen(isDark),
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight, borderRadius: BorderRadius.circular(16)),
                    child: const Center(child: Icon(Icons.directions_car, size: 50, color: AppColors.textHint)),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("TOYOTA", style: TextStyle(color: AppColors.textHint, fontSize: 12, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Corolla", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLang.tr(context, 'year'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text("2020", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLang.tr(context, 'mileage'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                              const SizedBox(height: 2),
                              Text("45,000 km", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black87)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0, // هيقلب left لوحده في العربي بفضل فلاتر
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, size: 16, color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard({
    required String title,
    required String date,
    required String daysLeft,
    required double progress,
    required List<Color> progressGradient,
    required Color glowColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 8, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: glowColor.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(Icons.notifications_none, color: glowColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                      const SizedBox(height: 4),
                      Text("${AppLang.tr(context, 'due_date')} $date", style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 13)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: glowColor.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: Text(daysLeft, style: TextStyle(color: glowColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 12,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: constraints.maxWidth * progress,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: progressGradient,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: glowColor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceCard({
    required String title,
    required String desc,
    required String date,
    required String price,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.01), blurRadius: 4, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight, shape: BoxShape.circle),
              child: const Icon(Icons.build_outlined, color: AppColors.textHint, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(desc, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 13, height: 1.5)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: AppColors.textHint),
                          const SizedBox(width: 6),
                          Text(date, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline, size: 14, color: Colors.redAccent),
                        label: Text(AppLang.tr(context, 'delete'), style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCarImageFullScreen(bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A1A) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Icon(Icons.directions_car, size: 150, color: AppColors.textHint)),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                    child: const Icon(Icons.close, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMaintenanceDialog({
    required bool isEdit,
    required bool isDark,
    String initialTitle = "",
    String initialDesc = "",
    String initialDate = "",
    String initialPrice = "",
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isEdit ? AppLang.tr(context, 'edit_record') : AppLang.tr(context, 'add_record'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildDialogTextField(AppLang.tr(context, 'service_name'), initialTitle, isDark, hint: "e.g., Oil Change", isFocused: true),
                  const SizedBox(height: 16),
                  _buildDialogTextField(AppLang.tr(context, 'due_date').replaceAll(":", ""), initialDate, isDark, hint: AppLang.tr(context, 'date_hint'), icon: Icons.calendar_today_outlined),
                  const SizedBox(height: 16),
                  _buildDialogTextField(AppLang.tr(context, 'cost_egp'), initialPrice, isDark, hint: "e.g., 450"),
                  const SizedBox(height: 16),

                  Text(AppLang.tr(context, 'description_details'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: initialDesc),
                      maxLines: 3,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      decoration: InputDecoration(
                        hintText: AppLang.tr(context, 'parts_used_notes'),
                        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                          ),
                          child: Text(AppLang.tr(context, 'cancel'), style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(isEdit ? AppLang.tr(context, 'save_changes') : AppLang.tr(context, 'add_record'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditReminderDialog(String initialTask, String initialDate, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLang.tr(context, 'edit_reminder'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildDialogTextField(AppLang.tr(context, 'task'), initialTask, isDark, hint: AppLang.tr(context, 'task'), isFocused: true),
                  const SizedBox(height: 16),
                  _buildDialogTextField(AppLang.tr(context, 'due_date').replaceAll(":", ""), initialDate, isDark, hint: AppLang.tr(context, 'date_hint'), icon: Icons.calendar_today_outlined),
                  const SizedBox(height: 16),

                  Text(AppLang.tr(context, 'notes_optional'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: TextField(
                      maxLines: 3,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                      decoration: InputDecoration(
                        hintText: AppLang.tr(context, 'additional_details'),
                        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                          ),
                          child: Text(AppLang.tr(context, 'cancel'), style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(AppLang.tr(context, 'save_changes'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogTextField(String label, String initialValue, bool isDark, {String hint = "", bool isFocused = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isFocused ? Colors.green : (isDark ? AppColors.borderDark : AppColors.borderLight), width: isFocused ? 2 : 1),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue),
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textHint),
              border: InputBorder.none,
              suffixIcon: icon != null ? Icon(icon, color: isDark ? Colors.white70 : Colors.black, size: 20) : null,
            ),
          ),
        ),
      ],
    );
  }
}