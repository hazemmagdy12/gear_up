import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الهيدر (العنوان كبرناه لـ 22 عشان يبقى موحد)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Car Parts", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text("10 parts available", style: TextStyle(fontSize: 14, color: AppColors.textHint)),
                ],
              ),
            ),

            // 2. شريط البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 52, // زودنا الارتفاع سنة عشان البحث يبقى أوضح
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search parts...",
                    hintStyle: TextStyle(color: AppColors.textHint),
                    prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. الفلاتر والقوائم المنسدلة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  _buildDropdownMenu(
                    title: "Company",
                    items: [
                      "All Companies",
                      "Hyundai New Accent",
                      "Toyota Corolla",
                      "Honda Civic",
                      "Kia Cerato",
                      "Hyundai Elantra",
                      "BMW 3 Series"
                    ],
                  ),
                  const SizedBox(width: 12),
                  _buildDropdownMenu(
                    title: "Price",
                    items: ["Default", "Low to High", "High to Low"],
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: AppColors.border, thickness: 1),
            ),

            // 4. ليستة قطع الغيار (الكروت الكبيرة)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPartCard(
                    title: "CTR Front Arm Set\n(Korean)",
                    company: "Hyundai New Accent",
                    fits: "Fits: 2006-2011",
                    price: "EGP 1,350",
                  ),
                  _buildPartCard(
                    title: "Brake Pad Set",
                    company: "Toyota Corolla",
                    fits: "Fits: 2014-2020",
                    price: "EGP 850",
                  ),
                  _buildPartCard(
                    title: "Air Filter",
                    company: "Honda Civic",
                    fits: "Fits: 2016-2024",
                    price: "EGP 320",
                  ),
                  _buildPartCard(
                    title: "Oil Filter",
                    company: "Kia Cerato",
                    fits: "Fits: 2019-2025",
                    price: "EGP 250",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- دوال مساعدة ---

  Widget _buildDropdownMenu({required String title, required List<String> items}) {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(fontWeight: item == items.first ? FontWeight.bold : FontWeight.normal)),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF333333),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  // التعديل هنا: كبرنا الكارت ومساحة الصورة والخطوط
  Widget _buildPartCard({required String title, required String company, required String fits, required String price}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // كبرنا حجم الصورة لـ 100
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Icon(Icons.settings, color: AppColors.textHint, size: 40)),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, height: 1.2)),
                const SizedBox(height: 6),
                Text(company, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 4),
                Text(fits, style: const TextStyle(color: AppColors.textHint, fontSize: 13)),
                const SizedBox(height: 12),
                Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),

          const Icon(Icons.favorite_border, color: AppColors.textSecondary, size: 26),
        ],
      ),
    );
  }
}