import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class CarDetailsScreen extends StatelessWidget {
  final String brand;
  final String model;
  final String price;
  final String rating;
  final bool isPromoted; // الشرط اللي بيحدد دي عربية عادية ولا إعلان

  const CarDetailsScreen({
    super.key,
    required this.brand,
    required this.model,
    required this.price,
    required this.rating,
    this.isPromoted = false, // الديفولت بتاعها False
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(context),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(),
                  const SizedBox(height: 24),

                  const Text("Specifications", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildSpecsGrid(),
                  const SizedBox(height: 24),

                  const Text("About this vehicle", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  const SizedBox(height: 8),
                  Text(
                    "The $brand $model (2025) is a brand new vehicle featuring a powerful 335 HP engine with 3000cc capacity. With its Automatic transmission and 8 gear shifts, this car delivers exceptional performance and efficiency. The vehicle can reach a maximum speed of 250 km/h and offers 650 L of luggage capacity, making it perfect for both daily commutes and long journeys.",
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  _buildCompareButton(),
                  const SizedBox(height: 24),

                  // ظهور عدد المشاهدات لو العربية دي إعلان فقط
                  if (isPromoted) _buildViewsCounter(),
                  if (isPromoted) const SizedBox(height: 24),

                  const Text("Reviews", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildReviewSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. صورة العربية والزراير العلوية
  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 280,
          decoration: const BoxDecoration(
            color: AppColors.surface, // خلفية مؤقتة لحد الصور الحقيقية
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 100, color: AppColors.textHint)),
        ),
        Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.share_outlined, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 110,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: const [
                Icon(Icons.star, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text("Top Rated", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        )
      ],
    );
  }

  // 2. العنوان والسعر
  Widget _buildTitleSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(brand, style: const TextStyle(color: AppColors.textHint, fontSize: 14)),
            const SizedBox(height: 4),
            Text(model, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text(" (124 reviews)", style: TextStyle(color: AppColors.textHint, fontSize: 14)),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 4),
            const Text("Average price", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  // 3. شبكة المواصفات
  Widget _buildSpecsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildSpecCard("Company", brand),
        _buildSpecCard("Model", model),
        _buildSpecCard("Year", "2025"),
        _buildSpecCard("HP", "335"),
        _buildSpecCard("CC", "3000"),
        _buildSpecCard("Torque", "330 lb-ft"),
        _buildSpecCard("Transmission", "Automatic"),
        _buildSpecCard("Luggage Capacity", "650 L"),
        _buildSpecCard("Gear Shifts", "8"),
        _buildSpecCard("Maximum Speed", "250 km/h"),
      ],
    );
  }

  Widget _buildSpecCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  // 4. زرار المقارنة
  Widget _buildCompareButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.compare_arrows, color: Colors.white),
        label: const Text("Added to Comparison", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  // 5. عداد المشاهدات (بيظهر في الإعلانات بس)
  Widget _buildViewsCounter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF), // لبني فاتح
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: const Icon(Icons.visibility, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("2,543", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
              Text("Views", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  // 6. التقييمات
  Widget _buildReviewSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Write a Review", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 24)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Share your experience with this car...",
                    border: InputBorder.none,
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 16),
                label: const Text("Submit Review", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                child: const Text("JO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("John D.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Oct 20, 2025", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                    ),
                    const SizedBox(height: 8),
                    const Text("Luxurious and powerful. Amazing driving experience!", style: TextStyle(color: AppColors.textSecondary, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}