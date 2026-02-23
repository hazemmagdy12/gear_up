import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class CarDetailsScreen extends StatelessWidget {
  final String brand;
  final String model;
  final String price;
  final String rating;
  final bool isPromoted;

  const CarDetailsScreen({
    super.key,
    required this.brand,
    required this.model,
    required this.price,
    required this.rating,
    this.isPromoted = false,
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
                  const SizedBox(height: 32),

                  const Text("Specifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 16),
                  _buildSpecsGrid(),
                  const SizedBox(height: 32),

                  const Text("About this vehicle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Text(
                    "The $brand $model (2025) is a brand new vehicle featuring a powerful 335 HP engine with 3000cc capacity. With its Automatic transmission and 8 gear shifts, this car delivers exceptional performance and efficiency. The vehicle can reach a maximum speed of 250 km/h and offers 650 L of luggage capacity, making it perfect for both daily commutes and long journeys.",
                    style: const TextStyle(color: AppColors.textSecondary, height: 1.6, fontSize: 14),
                  ),
                  const SizedBox(height: 32),

                  _buildCompareButton(),
                  const SizedBox(height: 24),

                  if (isPromoted) _buildViewsCounter(),
                  if (isPromoted) const SizedBox(height: 32),

                  const Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
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

  // 1. صورة العربية
  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 320,
          decoration: const BoxDecoration(
            color: AppColors.surface,
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 120, color: AppColors.textHint)),
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Row(
                children: [
                  // التعديل هنا: غيرنا أيقونة الشير لـ ios_share عشان شكلها أشيك وأحدث
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                    child: const Icon(Icons.ios_share, color: Colors.black, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
                    child: const Icon(Icons.favorite_border, color: Colors.black, size: 22),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isPromoted)
          Positioned(
            bottom: 20,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 16),
                  SizedBox(width: 6),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                brand.toUpperCase(),
                style: const TextStyle(color: AppColors.textHint, fontSize: 14, letterSpacing: 2.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                model,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 28, height: 1.1),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text(" (124 reviews)", style: TextStyle(color: AppColors.textHint, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 22)),
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
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.4,
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
        _buildSpecCard("Luggage", "650 L"),
      ],
    );
  }

  Widget _buildSpecCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
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
        icon: const Icon(Icons.compare_arrows, color: Colors.white, size: 22),
        label: const Text("Added to Comparison", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 8,
          shadowColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  // 5. عداد المشاهدات
  Widget _buildViewsCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.visibility_outlined, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("2,543", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5)),
              SizedBox(height: 2),
              Text("Total Views", style: TextStyle(color: Colors.white70, fontSize: 13)),
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Write a Review", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Row(
                children: List.generate(5, (index) => const Icon(Icons.star_border, color: Colors.amber, size: 28)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEAEAEA)),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Share your experience with this car...",
                    hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
                    border: InputBorder.none,
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: Colors.white, size: 16),
                  label: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Text("JD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("Oct 20, 2025", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                    ),
                    const SizedBox(height: 10),
                    const Text("Luxurious and powerful. The driving experience is absolutely phenomenal!", style: TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 14)),
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