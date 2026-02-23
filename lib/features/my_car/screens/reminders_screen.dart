import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الهيدر (زرار الرجوع والعنوان)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Upcoming Reminders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      Text("Manage your car maintenance reminders", style: TextStyle(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ],
              ),
            ),

            // 2. زرار إضافة تذكير جديد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showReminderDialog(context, isEdit: false),
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  label: const Text("Add Reminder", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. لستة التذكيرات
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildReminderItem(
                    context: context,
                    title: "Oil Change",
                    date: "November 15, 2025",
                    frequency: "Every 5,000 km",
                    statusText: "100 days overdue",
                    statusColor: Colors.redAccent,
                  ),
                  _buildReminderItem(
                    context: context,
                    title: "Tire Rotation",
                    date: "December 20, 2025",
                    frequency: "Every 10,000 km",
                    statusText: "65 days overdue",
                    statusColor: Colors.redAccent,
                  ),
                  _buildReminderItem(
                    context: context,
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

  // --- دوال مساعدة ---

  // دالة رسم كارت التذكير
  Widget _buildReminderItem({
    required BuildContext context,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.notifications_none, color: Colors.redAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("Due: $date", style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Text(frequency, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // حالة التذكير (Pill)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                      child: Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    // زراير التعديل والمسح
                    Row(
                      children: [
                        _buildActionButton(
                          icon: Icons.edit_outlined,
                          onTap: () => _showReminderDialog(
                            context,
                            isEdit: true,
                            initialTask: title,
                            initialDate: date,
                            initialNotes: frequency,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.delete_outline,
                          onTap: () => _showDeleteConfirmation(context),
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

  // زرار صغير للتعديل أو المسح
  Widget _buildActionButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColors.textSecondary),
      ),
    );
  }

  // ==========================================
  // نافذة إضافة أو تعديل تذكير
  // ==========================================
  void _showReminderDialog(
      BuildContext context, {
        required bool isEdit,
        String initialTask = "",
        String initialDate = "",
        String initialNotes = "",
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
                      Text(isEdit ? "Edit Reminder" : "Add Reminder", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: AppColors.textHint)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // التعديل هنا: تمرير initialValue
                  _buildDialogTextField("Task", "e.g., Oil Change, Tire Rotation", initialValue: initialTask),
                  const SizedBox(height: 16),

                  _buildDialogTextField("Due Date", "mm/dd/yyyy", icon: Icons.calendar_today_outlined, initialValue: initialDate),
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
                    child: TextField(
                      controller: TextEditingController(text: initialNotes), // التعديل هنا: تمرير الداتا للـ TextField
                      maxLines: 3,
                      decoration: const InputDecoration(
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
                          child: Text(isEdit ? "Save Changes" : "Add Reminder", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  // ==========================================
  // نافذة تأكيد المسح (Delete Confirmation)
  // ==========================================
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Delete Reminder", style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text("Are you sure you want to delete this reminder? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: AppColors.textHint)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Reminder deleted successfully!"),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Delete", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // دالة مساعدة لحقول الإدخال
  Widget _buildDialogTextField(String label, String hint, {IconData? icon, String initialValue = ""}) {
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
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: TextEditingController(text: initialValue), // التعديل هنا: ربط الكنترولر بالقيمة
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
              border: InputBorder.none,
              suffixIcon: icon != null ? Icon(icon, color: Colors.black, size: 20) : null,
            ),
          ),
        ),
      ],
    );
  }
}