import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import 'car_details_screen.dart'; // 1. استدعاء شاشة التفاصيل

class ViewAllCarsScreen extends StatelessWidget {
  final String title;

  const ViewAllCarsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // داتا وهمية
    final List<Map<String, String>> mockCars = [
      {"brand": "BMW", "model": "X5 2025", "year": "2025", "price": "EGP 1,850,000", "rating": "4.9"},
      {"brand": "Toyota", "model": "Corolla", "year": "2025", "price": "EGP 520,000", "rating": "4.7"},
      {"brand": "Hyundai", "model": "Elantra", "year": "2025", "price": "EGP 485,000", "rating": "4.5"},
      {"brand": "Mercedes", "model": "C-Class", "year": "2024", "price": "EGP 1,600,000", "rating": "4.8"},
      {"brand": "Nissan", "model": "Sunny", "year": "2023", "price": "EGP 310,000", "rating": "4.2"},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // شيلنا الزرار الافتراضي
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back, size: 24, color: isDark ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر الفخم على جمب الشاشة
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 10.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w900,
                      fontSize: 32, // خط كبير وفخم
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLang.tr(context, 'explore_premium_selection') != 'explore_premium_selection'
                        ? AppLang.tr(context, 'explore_premium_selection')
                        : "Explore our premium selection", // نص فرعي مؤقت لو مش متضاف في القاموس
                    style: TextStyle(
                      color: isDark ? Colors.white54 : AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            // لستة العربيات
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: mockCars.length,
                separatorBuilder: (context, index) => const SizedBox(height: 28), // مسافة أكبر بين الكروت
                itemBuilder: (context, index) {
                  final car = mockCars[index];
                  return _buildLargeCarCard(
                    context: context,
                    isDark: isDark,
                    brand: car["brand"]!,
                    model: car["model"]!,
                    year: car["year"]!,
                    price: car["price"]!,
                    rating: car["rating"]!,
                  );
                },
              ),
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

  // الكارت بعد التكبير والتطويل وربطه بالـ Navigation
  Widget _buildLargeCarCard({
    required BuildContext context,
    required bool isDark,
    required String brand,
    required String model,
    required String year,
    required String price,
    required String rating,
  }) {
    // 2. تفعيل الضغط على الكارت
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(
              brand: brand,
              model: model,
              price: price,
              rating: rating,
              isPromoted: title.contains('Promoted') || title.contains('ممولة'),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(28), // حواف أنعم
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8)
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 230, // 3. تطويل الكارت (كان 180 خليته 230)
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Icon(Icons.directions_car, size: 90, color: AppColors.textHint)),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(
                    children: [
                      _buildIconButton(Icons.favorite_border, isDark),
                      const SizedBox(height: 12),
                      _buildIconButton(Icons.compare_arrows, isDark),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: _buildTopRatedBadge(context, isDark),
                ),
              ],
            ),
            const SizedBox(height: 20), // مسافة أكبر تتنفس

            Text(brand.toUpperCase(), style: const TextStyle(color: AppColors.textHint, fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: isDark ? Colors.white : Colors.black87)),
                Icon(Icons.arrow_forward_ios, color: isDark ? Colors.white54 : AppColors.textHint, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(year, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 15, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 20),
                    const SizedBox(width: 6),
                    Text(rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 22)),
                const SizedBox(width: 8),
                Text(AppLang.tr(context, 'average_price'), style: TextStyle(color: isDark ? Colors.white54 : AppColors.textHint, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF38404B) : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Icon(icon, size: 22, color: isDark ? Colors.white : AppColors.secondary),
    );
  }

  Widget _buildTopRatedBadge(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.primary : AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(AppLang.tr(context, 'top_rated'), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}