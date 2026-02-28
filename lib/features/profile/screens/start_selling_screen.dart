import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../../home/widgets/ai_chat_bottom_sheet.dart';

class StartSellingScreen extends StatefulWidget {
  const StartSellingScreen({super.key});

  @override
  State<StartSellingScreen> createState() => _StartSellingScreenState();
}

class _StartSellingScreenState extends State<StartSellingScreen> {
  // بنخلي القيمة المبدئية 'type_car' كمفتاح عشان نترجمها صح
  String _selectedItemTypeKey = 'type_car';
  String? _selectedTransmissionKey;
  String? _selectedConditionKey;

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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLang.tr(context, 'start_selling_title'), style: const TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text(AppLang.tr(context, 'choose_item_type'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 32),

            // 1. اختيار نوع الإعلان
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surface, shape: BoxShape.circle),
                    child: Icon(
                      _selectedItemTypeKey == 'type_car' ? Icons.directions_car_outlined :
                      _selectedItemTypeKey == 'type_part' ? Icons.build_outlined : Icons.add_circle_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(AppLang.tr(context, _selectedItemTypeKey), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _showTypeSelectionSheet(isDark),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      backgroundColor: isDark ? const Color(0xFF2A2A2A) : AppColors.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(AppLang.tr(context, 'change'), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. قسم رفع الصور
            Text(AppLang.tr(context, 'photos'), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 12),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFE0E0E0), style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_a_photo_outlined, color: AppColors.textHint, size: 28),
                  const SizedBox(height: 8),
                  Text(AppLang.tr(context, 'add_photo'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(AppLang.tr(context, 'photo_hint'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
            const SizedBox(height: 32),

            // 3. الحقول الأساسية
            _buildTextField(label: AppLang.tr(context, 'title'), hint: AppLang.tr(context, 'title_hint'), isDark: isDark),
            _buildTextField(label: AppLang.tr(context, 'price_egp'), hint: AppLang.tr(context, 'price_hint'), isNumber: true, isDark: isDark),

            // 4. الحقول المتغيرة
            if (_selectedItemTypeKey == 'type_car') ...[
              Row(
                children: [
                  Expanded(child: _buildTextField(label: AppLang.tr(context, 'company'), hint: "e.g., BMW", isDark: isDark)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(label: AppLang.tr(context, 'model'), hint: "e.g., X5", isDark: isDark)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildTextField(label: AppLang.tr(context, 'year'), hint: "2024", isNumber: true, isDark: isDark)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(label: AppLang.tr(context, 'mileage'), hint: "km", isNumber: true, isDark: isDark)),
                ],
              ),
              _buildDropdownField(
                label: AppLang.tr(context, 'transmission'),
                hint: AppLang.tr(context, 'transmission_hint'),
                valueKey: _selectedTransmissionKey,
                itemKeys: ['automatic', 'manual'],
                isDark: isDark,
                onChanged: (val) => setState(() => _selectedTransmissionKey = val),
              ),
            ] else ...[
              _buildTextField(label: AppLang.tr(context, 'part_name'), hint: AppLang.tr(context, 'part_hint'), isDark: isDark),
              _buildTextField(label: AppLang.tr(context, 'compatibility'), hint: AppLang.tr(context, 'compat_hint'), isDark: isDark),
              _buildDropdownField(
                label: AppLang.tr(context, 'condition'),
                hint: AppLang.tr(context, 'condition_hint'),
                valueKey: _selectedConditionKey,
                itemKeys: ['new_condition', 'used_condition', 'refurbished'],
                isDark: isDark,
                onChanged: (val) => setState(() => _selectedConditionKey = val),
              ),
            ],

            // 5. الوصف
            _buildTextField(label: AppLang.tr(context, 'description'), hint: AppLang.tr(context, 'desc_hint'), maxLines: 4, isDark: isDark),
            const SizedBox(height: 24),

            // 6. زرار النشر
            GestureDetector(
              onTap: () {
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
                  children: [
                    Text(AppLang.tr(context, 'publish_listing'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
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

  Widget _buildTextField({required String label, required String hint, required bool isDark, bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
            ),
            child: TextField(
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              maxLines: maxLines,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({required String label, required String hint, required String? valueKey, required List<String> itemKeys, required bool isDark, required ValueChanged<String?> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: valueKey,
                hint: Text(hint, style: const TextStyle(color: AppColors.textHint, fontSize: 14)),
                isExpanded: true,
                dropdownColor: isDark ? AppColors.surfaceDark : Colors.white,
                icon: Icon(Icons.keyboard_arrow_down, color: isDark ? Colors.white : Colors.black),
                items: itemKeys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(AppLang.tr(context, key), style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTypeSelectionSheet(bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLang.tr(context, 'select_item_type'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 24),
                _buildTypeOption('type_car', Icons.directions_car_outlined, isDark),
                _buildTypeOption('type_part', Icons.build_outlined, isDark),
                _buildTypeOption('type_accessory', Icons.add_circle_outline, isDark),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeOption(String key, IconData icon, bool isDark) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surface, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(AppLang.tr(context, key), style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
      onTap: () {
        setState(() => _selectedItemTypeKey = key);
        Navigator.pop(context);
      },
    );
  }
}