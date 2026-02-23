import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
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
        width: 280, // التعديل هنا: كبرنا العرض
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
                  height: 180, // التعديل هنا: كبرنا مساحة الصورة
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 70, color: AppColors.textHint), // كبرنا الأيقونة
                  ),
                ),
                if (isTopRated)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text("Top Rated", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
                  Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 14)), // كبرنا الفونت
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), // كبرنا الموديل
                      const Icon(Icons.chevron_right, color: AppColors.textHint, size: 24),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(year, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)), // كبرنا السعر
                      const SizedBox(width: 4),
                      const Text("Average price", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
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
      padding: const EdgeInsets.all(8), // كبرنا زرار القلب والمقارنة شوية
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: AppColors.secondary),
    );
  }
}