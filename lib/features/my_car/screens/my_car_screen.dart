import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'reminders_screen.dart';
import '../../nearby/screens/nearby_locations_screen.dart';

class MyCarScreen extends StatefulWidget {
  const MyCarScreen({super.key});

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoggedIn ? _buildLoggedInState() : _buildUnloggedState(),
      ),
    );
  }

  // ==========================================
  // 1. حالة عدم تسجيل الدخول (Unlogged State)
  // ==========================================
  Widget _buildUnloggedState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                child: const Icon(Icons.lock_outline, size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: 24),
              const Text("My Car", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text(
                "Log in or sign up to manage your vehicle, track maintenance history, and set reminders",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, height: 1.5),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.login, color: Colors.white, size: 20),
                  label: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  label: const Text("Sign Up", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.border),
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
  Widget _buildLoggedInState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الهيدر
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("My Car", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              SizedBox(height: 4),
              Text("Manage your vehicles", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 24),

          // قسم: بيانات العربية
          _buildSectionHeader(title: "My Vehicle"),
          const SizedBox(height: 16),
          _buildMyVehicleCard(),
          const SizedBox(height: 32),

          // قسم: التذكيرات القادمة
          _buildSectionHeader(
              title: "Upcoming Reminders",
              actionLabel: "Manage",
              actionIcon: Icons.settings_outlined,
              onActionTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RemindersScreen()),
                );
              }
          ),
          const SizedBox(height: 16),
          _buildReminderCard(
            title: "Oil Change",
            date: "2025-11-15",
            daysLeft: "-100 days",
            progress: 0.3,
            progressGradient: [AppColors.primary, const Color(0xFF4FC3F7)], // تدرج أزرق
            glowColor: AppColors.primary,
            onTap: () => _showEditReminderDialog("Oil Change", "2025-11-15"),
          ),
          _buildReminderCard(
            title: "Tire Rotation",
            date: "2025-12-20",
            daysLeft: "-65 days",
            progress: 0.8,
            progressGradient: [const Color(0xFFD32F2F), const Color(0xFFFF5252)], // تدرج أحمر
            glowColor: Colors.redAccent,
            onTap: () => _showEditReminderDialog("Tire Rotation", "2025-12-20"),
          ),
          const SizedBox(height: 32),

          // قسم: سجل الصيانة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Maintenance History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showMaintenanceDialog(isEdit: false),
                icon: const Icon(Icons.add, color: Colors.white, size: 16),
                label: const Text("Add Record", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
            onTap: () => _showMaintenanceDialog(
                isEdit: true,
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
            onTap: () => _showMaintenanceDialog(
                isEdit: true,
                initialTitle: "Tire Rotation",
                initialDesc: "All Tires\nAll four tires rotated",
                initialDate: "2025-07-20",
                initialPrice: "200"
            ),
          ),

          const SizedBox(height: 32),

          // زرار Service Centers بالتصميم الفاخر
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
                  const Text("Service Centers", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.0)),
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

  Widget _buildSectionHeader({required String title, String? actionLabel, IconData? actionIcon, VoidCallback? onActionTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        if (actionLabel != null && actionIcon != null && onActionTap != null)
          OutlinedButton.icon(
            onPressed: onActionTap,
            icon: Icon(actionIcon, size: 16, color: AppColors.textSecondary),
            label: Text(actionLabel, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: const BorderSide(color: AppColors.border),
            ),
          ),
      ],
    );
  }

  // التعديل: تكبير الكارت وإضافة ظلال ونصوص احترافية
  Widget _buildMyVehicleCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showCarImageFullScreen,
            child: Container(
              width: 120, // تكبير مساحة الصورة
              height: 100,
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
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
                const Text("Corolla", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Year", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                        SizedBox(height: 2),
                        Text("2020", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Mileage", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                        SizedBox(height: 2),
                        Text("45,000 km", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // التعديل: استبدال LinearProgressIndicator العادي بشريط احترافي مضيء
  Widget _buildReminderCard({
    required String title,
    required String date,
    required String daysLeft,
    required double progress,
    required List<Color> progressGradient,
    required Color glowColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))
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
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text("Due: $date", style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
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

            // تصميم التايمر الجديد (Progress Bar)
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 12, // شريط أسمك
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
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
                            color: glowColor.withOpacity(0.4), // تأثير التوهج
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 4, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
              child: const Icon(Icons.build_outlined, color: AppColors.textSecondary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
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
                        label: const Text("Delete", style: TextStyle(color: Colors.redAccent, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          side: const BorderSide(color: AppColors.border),
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

  void _showCarImageFullScreen() {
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
                    color: AppColors.surface,
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
    String initialTitle = "",
    String initialDesc = "",
    String initialDate = "",
    String initialPrice = "",
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                      Text(isEdit ? "Edit Record" : "Add Record", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildDialogTextField("Service Name", initialTitle, hint: "e.g., Oil Change", isFocused: true),
                  const SizedBox(height: 16),
                  _buildDialogTextField("Date", initialDate, hint: "mm/dd/yyyy", icon: Icons.calendar_today_outlined),
                  const SizedBox(height: 16),
                  _buildDialogTextField("Cost (EGP)", initialPrice, hint: "e.g., 450"),
                  const SizedBox(height: 16),

                  const Text("Description / Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: TextField(
                      controller: TextEditingController(text: initialDesc),
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Parts used, mechanic notes...",
                        hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
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
                            side: const BorderSide(color: AppColors.border),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
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
                          child: Text(isEdit ? "Save Changes" : "Add Record", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  void _showEditReminderDialog(String initialTask, String initialDate) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                      const Text("Edit Reminder", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildDialogTextField("Task", initialTask, hint: "Task Name", isFocused: true),
                  const SizedBox(height: 16),
                  _buildDialogTextField("Due Date", initialDate, hint: "Date", icon: Icons.calendar_today_outlined),
                  const SizedBox(height: 16),

                  const Text("Notes (Optional)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Additional details...",
                        hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
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
                            side: const BorderSide(color: AppColors.border),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
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
                          child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildDialogTextField(String label, String initialValue, {String hint = "", bool isFocused = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isFocused ? Colors.green : AppColors.border, width: isFocused ? 2 : 1),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              suffixIcon: icon != null ? Icon(icon, color: Colors.black, size: 20) : null,
            ),
          ),
        ),
      ],
    );
  }
}