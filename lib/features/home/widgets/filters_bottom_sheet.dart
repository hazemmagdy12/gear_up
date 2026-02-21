import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // بناخد 80% من طول الشاشة عشان الفلاتر تاخد راحتها
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الهيدر (كلمة Filters وزرار القفل)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textHint),
                  onPressed: () => Navigator.pop(context), // بيقفل الشاشة
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 2. المحتوى (بياخد سكرول عشان لو الفلاتر كترت)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // قسم الشركات
                    const Text("COMPANY", style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption("Toyota"),
                    _buildFilterOption("Hyundai"),
                    _buildFilterOption("BMW"),
                    _buildFilterOption("Kia"),

                    const SizedBox(height: 24),

                    // قسم الموديلات
                    const Text("MODEL", style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption("Corolla"),
                    _buildFilterOption("Elantra"),
                    _buildFilterOption("X5"),
                    _buildFilterOption("Sportage"),

                    const SizedBox(height: 24),

                    // قسم الأسعار (عاملين واحد فيه IsSelected عشان يظهر باللون الأزرق زي التصميم)
                    const Text("PRICE", style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildFilterOption("High to Low"),
                    _buildFilterOption("Low to High"),
                    _buildFilterOption("Under 500K", isSelected: true),

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

  // دالة صغيرة لرسم كل خيار عشان منكررش الكود
  Widget _buildFilterOption(String text, {bool isSelected = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}