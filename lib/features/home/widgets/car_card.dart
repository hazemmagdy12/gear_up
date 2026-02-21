import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../screens/car_details_screen.dart'; // 1. استدعاء شاشة التفاصيل هنا

class CarCard extends StatelessWidget {
  final String brand;
  final String model;
  final String year;
  final String price;
  final String rating;
  final bool isTopRated;
  final bool isPromoted; // 2. ضفنا متغير يحدد هل ده إعلان ولا لأ

  const CarCard({
    super.key,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.rating,
    this.isTopRated = false,
    this.isPromoted = false, // الديفولت فولس
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 3. الانتقال لصفحة التفاصيل عند الضغط
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(
              brand: brand,
              model: model,
              price: price,
              rating: rating,
              isPromoted: isPromoted, // تمرير الحالة عشان رقم المشاهدات يظهر لو ده إعلان
            ),
          ),
        );
      },
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 50, color: AppColors.textHint),
                  ),
                ),
                if (isTopRated)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text("Top Rated", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Column(
                    children: [
                      _buildIconButton(Icons.favorite_border),
                      const SizedBox(height: 8),
                      _buildIconButton(Icons.compare_arrows),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(year, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(width: 4),
                      const Text("Average price", style: TextStyle(color: AppColors.textHint, fontSize: 10)),
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

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: AppColors.secondary),
    );
  }
}