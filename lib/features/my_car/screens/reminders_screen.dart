import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 24, color: isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLang.tr(context, 'upcoming_reminders'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      Text(AppLang.tr(context, 'manage_reminders'), style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showReminderDialog(context, isDark, isEdit: false),
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  label: Text(AppLang.tr(context, 'add_reminder'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildReminderItem(
                    context: context,
                    isDark: isDark,
                    title: "Oil Change", // داتا تجريبية
                    date: "November 15, 2025",
                    frequency: "Every 5,000 km",
                    statusText: "100 days overdue",
                    statusColor: Colors.redAccent,
                  ),
                  _buildReminderItem(
                    context: context,
                    isDark: isDark,
                    title: "Tire Rotation",
                    date: "December 20, 2025",
                    frequency: "Every 10,000 km",
                    statusText: "65 days overdue",
                    statusColor: Colors.redAccent,
                  ),
                  _buildReminderItem(
                    context: context,
                    isDark: isDark,
                    title: "Brake Inspection",
                    date: "January 5, 2026",
                    frequency: "Routine check",
                    statusText: "49 days overdue",
                    statusColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderItem({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String date,
    required String frequency,
    required String statusText,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.red.withOpacity(isDark ? 0.2 : 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.notifications_none, color: Colors.redAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text("${AppLang.tr(context, 'due_date')}$date", style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Text(frequency, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: statusColor.withOpacity(isDark ? 0.2 : 0.1), borderRadius: BorderRadius.circular(16)),
                      child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    Row(
                      children: [
                        _buildActionButton(
                          icon: Icons.edit_outlined,
                          isDark: isDark,
                          onTap: () => _showReminderDialog(
                            context,
                            isDark,
                            isEdit: true,
                            initialTask: title,
                            initialDate: date,
                            initialNotes: frequency,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.delete_outline,
                          isDark: isDark,
                          onTap: () => _showDeleteConfirmation(context, isDark),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required bool isDark, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: isDark ? Colors.white70 : AppColors.textSecondary),
      ),
    );
  }

  void _showReminderDialog(
      BuildContext context,
      bool isDark, {
        required bool isEdit,
        String initialTask = "",
        String initialDate = "",
        String initialNotes = "",
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
                      Text(isEdit ? AppLang.tr(context, 'edit_reminder') : AppLang.tr(context, 'add_reminder'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _buildDialogTextField(context, AppLang.tr(context, 'task'), AppLang.tr(context, 'task_hint'), isDark, initialValue: initialTask),
                  const SizedBox(height: 16),

                  _buildDialogTextField(context, AppLang.tr(context, 'due_date').replaceAll(":", ""), AppLang.tr(context, 'date_hint'), isDark, icon: Icons.calendar_today_outlined, initialValue: initialDate),
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
                      controller: TextEditingController(text: initialNotes),
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
                          child: Text(isEdit ? AppLang.tr(context, 'save_changes') : AppLang.tr(context, 'add_reminder'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  void _showDeleteConfirmation(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(AppLang.tr(context, 'delete_reminder'), style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          content: Text(AppLang.tr(context, 'delete_confirm_msg'), style: TextStyle(color: isDark ? Colors.white70 : Colors.black87)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLang.tr(context, 'cancel'), style: const TextStyle(color: AppColors.textHint)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLang.tr(context, 'reminder_deleted')),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(AppLang.tr(context, 'delete'), style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField(BuildContext context, String label, String hint, bool isDark, {IconData? icon, String initialValue = ""}) {
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
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue),
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
              border: InputBorder.none,
              suffixIcon: icon != null ? Icon(icon, color: isDark ? Colors.white70 : Colors.black, size: 20) : null,
            ),
          ),
        ),
      ],
    );
  }
}