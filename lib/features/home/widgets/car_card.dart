import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../screens/car_details_screen.dart';

class CarCard extends StatelessWidget {
  final String brand;
  final String model;
  final String year;
  final String price;
  final String rating;
  final bool isTopRated;
  final bool isPromoted;

  const CarCard({
    super.key,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.rating,
    this.isTopRated = false,
    this.isPromoted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              isPromoted: isPromoted,
            ),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: isPromoted
                  ? const Color(0xFFF39C12).withOpacity(isDark ? 0.3 : 0.15)
                  : Colors.black.withOpacity(isDark ? 0.2 : 0.06),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 90, color: AppColors.textHint),
                  ),
                ),
                if (isTopRated)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        // التعديل هنا: شيلنا اللون الأسود وخليناه ياخد اللون الأزرق الأساسي للتطبيق عشان ينور في اللايت مود
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(AppLang.tr(context, 'top_rated'), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(brand.toUpperCase(), style: const TextStyle(color: AppColors.textHint, fontSize: 13, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          model,
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: isDark ? Colors.white : Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.textHint, size: 24),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(year, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 15, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 18),
                          const SizedBox(width: 4),
                          Text(rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 20)),
                      const SizedBox(width: 6),
                      Text(AppLang.tr(context, 'average_price'), style: TextStyle(color: isDark ? Colors.white54 : AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF38404B) : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Icon(icon, size: 20, color: isDark ? Colors.white : AppColors.secondary),
    );
  }
}