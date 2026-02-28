import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // 1. استدعاء القاموس

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLang.tr(context, 'compare_vehicles'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                    Text(AppLang.tr(context, 'analyze_specs'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildCarColumn(context, "Toyota", "Corolla 2025", "EGP 520,000", isDark)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildCarColumn(context, "Kia", "Cerato 2025", "EGP 475,000", isDark)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _buildComparisonTable(context, isDark),

              _buildComparisonGuide(context, isDark),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarColumn(BuildContext context, String brand, String model, String price, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 50, color: AppColors.textHint)),
        ),
        const SizedBox(height: 16),
        Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
        Text(model, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 8),
        Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.close, size: 16, color: AppColors.textHint),
            label: Text(AppLang.tr(context, 'remove'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonTable(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildTableRow(AppLang.tr(context, 'specification'), "Corolla 2025", "Cerato 2025", isDark: isDark, isHeader: true),
          _buildTableRow(AppLang.tr(context, 'company'), "Toyota", "Kia", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'model'), "Corolla 2025", "Cerato 2025", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'year'), "2025", "2025", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'average_price'), "EGP 520,000", "EGP 475,000", isDark: isDark, val1Color: Colors.redAccent, val2Color: AppColors.primary),
          _buildTableRow(AppLang.tr(context, 'transmission'), "CVT", "Automatic", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'mileage'), "N/A", "N/A", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'hp'), "169", "147", isDark: isDark, val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow(AppLang.tr(context, 'cc'), "1800", "1600", isDark: isDark, val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow(AppLang.tr(context, 'torque'), "151 lb-ft", "132 lb-ft", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'luggage_capacity'), "371 L", "428 L", isDark: isDark),
          _buildTableRow(AppLang.tr(context, 'gear_shifts'), "7", "6", isDark: isDark, val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow(AppLang.tr(context, 'max_speed'), "180 km/h", "185 km/h", isDark: isDark),
        ],
      ),
    );
  }

  Widget _buildTableRow(String title, String val1, String val2, {required bool isDark, bool isHeader = false, Color? val1Color, Color? val2Color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? (isDark ? Colors.white : Colors.black) : (isDark ? Colors.white70 : AppColors.textSecondary),
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              val1,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: val1Color ?? (isDark ? Colors.white : Colors.black87),
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              val2,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: val2Color ?? (isDark ? Colors.white : Colors.black87),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonGuide(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLang.tr(context, 'comparison_guide'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(AppLang.tr(context, 'indicates_advantage'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.trending_down, color: Colors.redAccent, size: 20),
              const SizedBox(width: 8),
              Text(AppLang.tr(context, 'indicates_disadvantage'), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}