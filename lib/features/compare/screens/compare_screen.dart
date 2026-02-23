import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // التعديل هنا: هيدر مخصص بيبدأ من الشمال زي باقي الشاشات
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Compare Vehicles", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text("Analyze side-by-side specifications", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),

              // 1. قسم العربيتين اللي بنقارنهم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // عشان لو اسم موديل أطول من التاني يبدأو من نفس المستوى
                  children: [
                    Expanded(child: _buildCarColumn("Toyota", "Corolla 2025", "EGP 520,000")),
                    const SizedBox(width: 16),
                    Expanded(child: _buildCarColumn("Kia", "Cerato 2025", "EGP 475,000")),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. جدول المقارنة
              _buildComparisonTable(),

              // 3. دليل الألوان (المميزات والعيوب)
              _buildComparisonGuide(),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // --- دوال مساعدة لرسم الشاشة ---

  // دالة لرسم عمود العربية
  Widget _buildCarColumn(String brand, String model, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // التعديل هنا: كبرنا الارتفاع وعرضناه للآخر عشان الصورة تبقى واضحة
        Container(
          height: 140, // كان 100
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16), // حواف أنعم
            border: Border.all(color: AppColors.border), // إطار خفيف
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 50, color: AppColors.textHint)), // كبرنا الأيقونة
        ),
        const SizedBox(height: 16),
        Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
        Text(model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)), // صغرنا الفونت سنة عشان الموبايلات الصغيرة
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.close, size: 16, color: AppColors.textSecondary),
            label: const Text("Remove", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }

  // دالة رسم الجدول بالكامل
  Widget _buildComparisonTable() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildTableRow("Specification", "Corolla 2025", "Cerato 2025", isHeader: true),
          _buildTableRow("Company", "Toyota", "Kia"),
          _buildTableRow("Model", "Corolla 2025", "Cerato 2025"),
          _buildTableRow("Year", "2025", "2025"),
          _buildTableRow("Average Price", "EGP 520,000", "EGP 475,000", val1Color: Colors.redAccent, val2Color: AppColors.primary),
          _buildTableRow("Transmission", "CVT", "Automatic"),
          _buildTableRow("Mileage", "N/A", "N/A"),
          _buildTableRow("HP", "169", "147", val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow("CC", "1800", "1600", val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow("Torque", "151 lb-ft", "132 lb-ft"),
          _buildTableRow("Luggage Capacity", "371 L", "428 L"),
          _buildTableRow("Gear Shifts", "7", "6", val1Color: AppColors.primary, val2Color: Colors.redAccent),
          _buildTableRow("Max Speed", "180 km/h", "185 km/h"),
        ],
      ),
    );
  }

  // دالة رسم صف واحد في الجدول
  Widget _buildTableRow(String title, String val1, String val2, {bool isHeader = false, Color? val1Color, Color? val2Color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal, color: isHeader ? Colors.black : AppColors.textSecondary, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              val1,
              style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal, color: val1Color ?? Colors.black, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              val2,
              style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal, color: val2Color ?? Colors.black, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // دالة رسم دليل الألوان تحت خالص
  Widget _buildComparisonGuide() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Comparison Guide", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.trending_up, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text("Indicates advantage", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.trending_down, color: Colors.redAccent, size: 20),
              SizedBox(width: 8),
              Text("Indicates disadvantage", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}