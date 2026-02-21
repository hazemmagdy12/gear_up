import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart'; // تأكد إن المسار ده مظبوط عندك

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Compare Vehicles", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. قسم العربيتين اللي بنقارنهم
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(child: _buildCarColumn("Toyota", "Corolla 2025", "EGP 520,000")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildCarColumn("Kia", "Cerato 2025", "EGP 475,000")),
                ],
              ),
            ),

            // 2. جدول المقارنة
            _buildComparisonTable(),

            // 3. دليل الألوان (المميزات والعيوب)
            _buildComparisonGuide(),

            const SizedBox(height: 100), // مسافة عشان شريط التنقل السفلي ميغطيش الكلام
          ],
        ),
      ),
    );
  }

  // --- دوال مساعدة لرسم الشاشة ---

  // دالة لرسم عمود العربية (صورة + بيانات + زرار مسح)
  Widget _buildCarColumn(String brand, String model, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.surface, // مكان مؤقت للصورة
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 40, color: AppColors.textHint)),
        ),
        const SizedBox(height: 12),
        Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
        Text(model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.close, size: 16, color: AppColors.textSecondary),
            label: const Text("Remove", style: TextStyle(color: AppColors.textSecondary)),
            style: OutlinedButton.styleFrom(
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
          // عنوان الجدول
          _buildTableRow("Specification", "Corolla 2025", "Cerato 2025", isHeader: true),

          // الصفوف العادية
          _buildTableRow("Company", "Toyota", "Kia"),
          _buildTableRow("Model", "Corolla 2025", "Cerato 2025"),
          _buildTableRow("Year", "2025", "2025"),

          // الصفوف اللي فيها تلوين للميزة والعيب
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

  // دالة رسم صف واحد في الجدول (عشان منكررش الكود 13 مرة)
  Widget _buildTableRow(String title, String val1, String val2, {bool isHeader = false, Color? val1Color, Color? val2Color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)), // خط تحت كل صف
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