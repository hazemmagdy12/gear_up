import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../../home/widgets/ai_chat_bottom_sheet.dart';

class EditMyCarScreen extends StatefulWidget {
  const EditMyCarScreen({super.key});

  @override
  State<EditMyCarScreen> createState() => _EditMyCarScreenState();
}

class _EditMyCarScreenState extends State<EditMyCarScreen> {
  final TextEditingController _brandController = TextEditingController(text: "TOYOTA");
  final TextEditingController _modelController = TextEditingController(text: "Corolla");
  final TextEditingController _yearController = TextEditingController(text: "2020");
  final TextEditingController _mileageController = TextEditingController(text: "45000");

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLang.tr(context, 'edit_my_vehicle'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLang.tr(context, 'vehicle_details'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 4),
            Text(AppLang.tr(context, 'update_car_info'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 32),

            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 140,
                        height: 100,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE), width: 2),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: const Center(
                          child: Icon(Icons.directions_car, size: 50, color: AppColors.textHint),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? AppColors.surfaceDark : Colors.white, width: 3),
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(AppLang.tr(context, 'change_vehicle_photo'), style: const TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 40),

            _buildLabelField(AppLang.tr(context, 'car_brand'), Icons.branding_watermark_outlined, _brandController, isDark),
            const SizedBox(height: 24),
            _buildLabelField(AppLang.tr(context, 'car_model'), Icons.directions_car_outlined, _modelController, isDark),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildLabelField(AppLang.tr(context, 'manufacturing_year'), Icons.calendar_today_outlined, _yearController, isDark, isNumber: true)),
                const SizedBox(width: 16),
                Expanded(child: _buildLabelField(AppLang.tr(context, 'mileage_km'), Icons.speed_outlined, _mileageController, isDark, isNumber: true)),
              ],
            ),
            const SizedBox(height: 50),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(AppLang.tr(context, 'cancel'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      shadowColor: AppColors.primary.withOpacity(0.5),
                    ),
                    child: Text(AppLang.tr(context, 'save_changes'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
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

  Widget _buildLabelField(String label, IconData icon, TextEditingController controller, bool isDark, {bool isNumber = false}) {
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
            color: isDark ? const Color(0xFF1E1E1E) : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          ),
          child: TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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