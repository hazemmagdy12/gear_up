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
    this.rating = "4.8",
    this.isPromoted = false,
  });

  @override
  Widget build(BuildContext context) {
    // 1. تحديد الثيم الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 2. استخدام لون الخلفية من الثيم
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(context, isDark),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(isDark),
                  const SizedBox(height: 40),

                  Text("Specifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 20),
                  _buildSpecsGrid(isDark),
                  const SizedBox(height: 40),

                  Text("About this vehicle", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 16),
                  Text(
                    "The $brand $model (2025) is a premium vehicle featuring a powerful 335 HP engine with 3000cc capacity. With its Automatic transmission and 8 gear shifts, this car delivers exceptional performance and efficiency. The vehicle can reach a maximum speed of 250 km/h and offers 650 L of luggage capacity, making it perfect for both daily commutes and long journeys.",
                    style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.8, fontSize: 15),
                  ),
                  const SizedBox(height: 40),

                  _buildCompareButton(),
                  const SizedBox(height: 32),

                  if (isPromoted) ...[
                    _buildViewsCounter(),
                    const SizedBox(height: 40),
                  ],

                  Text("Reviews", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 20),
                  _buildReviewSection(isDark),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context, bool isDark) {
    return Stack(
      children: [
        Container(
          height: 380,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight, // لون خلفية الصورة
          ),
          child: const Center(child: Icon(Icons.directions_car, size: 160, color: AppColors.textHint)),
        ),
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.1), blurRadius: 10)]),
                  child: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black, size: 24),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.1), blurRadius: 10)]),
                    child: Icon(Icons.ios_share, color: isDark ? Colors.white : Colors.black, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.1), blurRadius: 10)]),
                    child: Icon(Icons.favorite_border, color: isDark ? Colors.white : Colors.black, size: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (isPromoted)
          Positioned(
            bottom: 24,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text("Top Rated", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          )
      ],
    );
  }

  Widget _buildTitleSection(bool isDark) {
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
                style: const TextStyle(color: AppColors.textHint, fontSize: 16, letterSpacing: 2.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                model,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, height: 1.2, color: isDark ? Colors.white : Colors.black87), // لون الموديل
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                  const SizedBox(width: 6),
                  Text(rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : Colors.black87)),
                  const Text("  •  124 reviews", style: TextStyle(color: AppColors.textHint, fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 26)),
            const SizedBox(height: 6),
            const Text("Average price", style: TextStyle(color: AppColors.textHint, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecsGrid(bool isDark) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildSpecCard("Company", brand, isDark),
        _buildSpecCard("Model", model, isDark),
        _buildSpecCard("Year", "2025", isDark),
        _buildSpecCard("HP", "335", isDark),
        _buildSpecCard("CC", "3000", isDark),
        _buildSpecCard("Torque", "330 lb-ft", isDark),
        _buildSpecCard("Transmission", "Automatic", isDark),
        _buildSpecCard("Luggage", "650 L", isDark),
      ],
    );
  }

  Widget _buildSpecCard(String title, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E262B) : const Color(0xFFF8F9FA), // لون كارت المواصفات
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textHint, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: isDark ? Colors.white : Colors.black87), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildCompareButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.compare_arrows, color: Colors.white, size: 24),
        label: const Text("Added to Comparison", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 20),
          elevation: 10,
          shadowColor: AppColors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildViewsCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.visibility_outlined, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("2,543", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2.0)),
              SizedBox(height: 4),
              Text("Total Views", style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.03), blurRadius: 15, offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Write a Review", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: isDark ? Colors.white : Colors.black87)),
              const SizedBox(height: 16),
              Row(
                children: List.generate(5, (index) => const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.star_border, color: Colors.amber, size: 32),
                )),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
                ),
                child: TextField(
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87), // لون الكتابة
                  decoration: InputDecoration(
                    hintText: "Share your experience with this car...",
                    hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 15),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: Colors.white, size: 18),
                  label: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E262B) : const Color(0xFFF8F9FA),
            border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: const Text("JD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("John Doe", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: isDark ? Colors.white : Colors.black87)),
                        const Text("Oct 20, 2025", style: TextStyle(color: AppColors.textHint, fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 18)),
                    ),
                    const SizedBox(height: 12),
                    Text("Luxurious and powerful. The driving experience is absolutely phenomenal! Highly recommend this model.", style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.6, fontSize: 15)),
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