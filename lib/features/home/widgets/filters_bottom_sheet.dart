import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLang.tr(context, 'filters'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textHint),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLang.tr(context, 'company').toUpperCase(), style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption("Toyota", isDark), // بيانات تجريبية مش هنترجمها
                    _buildFilterOption("Hyundai", isDark),
                    _buildFilterOption("BMW", isDark),
                    _buildFilterOption("Kia", isDark),

                    const SizedBox(height: 24),

                    Text(AppLang.tr(context, 'model').toUpperCase(), style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption("Corolla", isDark),
                    _buildFilterOption("Elantra", isDark),
                    _buildFilterOption("X5", isDark),
                    _buildFilterOption("Sportage", isDark),

                    const SizedBox(height: 24),

                    Text(AppLang.tr(context, 'price').toUpperCase(), style: const TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption(AppLang.tr(context, 'high_to_low'), isDark),
                    _buildFilterOption(AppLang.tr(context, 'low_to_high'), isDark),
                    _buildFilterOption(AppLang.tr(context, 'under_500k'), isDark, isSelected: true),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String text, bool isDark, {bool isSelected = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : (isDark ? const Color(0xFF2A2A2A) : Colors.white),
        border: Border.all(color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : AppColors.borderLight)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black87),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}