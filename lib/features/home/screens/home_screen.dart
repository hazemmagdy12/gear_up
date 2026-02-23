import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../widgets/car_card.dart';
import '../widgets/filters_bottom_sheet.dart';
import 'search_screen.dart';
import '../../nearby/screens/nearby_locations_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 24),

              _buildQuickActions(context),
              const SizedBox(height: 32),

              _buildPromotedSection(),
              const SizedBox(height: 24),

              _buildSectionWrapper(
                title: "Top Rated New Cars",
                subtitle: "Best rated vehicles in 2025",
                actionText: "View More",
                bgColor: const Color(0xFFF0F4FF),
                content: _buildCarList(),
              ),
              const SizedBox(height: 24),

              // قسم الأخبار بعد التعديل
              _buildSectionWrapper(
                title: "News",
                subtitle: "Latest news and updates",
                actionText: "View More",
                bgColor: const Color(0xFFF8F9FA),
                content: _buildNewsList(),
              ),
              const SizedBox(height: 24),

              _buildSectionWrapper(
                title: "New Cars",
                subtitle: "Latest models from top brands",
                actionText: "View More",
                bgColor: const Color(0xFFEEF2F5),
                content: _buildCarList(),
              ),
              const SizedBox(height: 24),

              _buildSectionWrapper(
                title: "Used Cars",
                subtitle: "Quality pre-owned vehicles",
                actionText: "View More",
                bgColor: const Color(0xFFF5F6F8),
                content: _buildCarList(),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWrapper({
    required String title,
    required String subtitle,
    required Widget content,
    String? actionText,
    Color bgColor = const Color(0xFFF4F8FF),
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                ],
              ),
              if (actionText != null)
                Row(
                  children: [
                    Text(actionText, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary, fontSize: 13)),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 12),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildPromotedSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Promoted",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD35400)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF39C12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Featured Listings", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                children: const [
                  Text("View More", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 12),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text("Premium featured listings", style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 16),

          _buildCarList(isPromotedSection: true),
        ],
      ),
    );
  }

  // التعديل هنا: زودنا ارتفاع اللستة عشان الكارت الجديد ياخد مساحته براحته
  Widget _buildNewsList() {
    return SizedBox(
      height: 380,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildNewsCard(
            date: "Oct 20, 2025",
            title: "Toyota Unveils All-New 2025 Camry Hybrid",
            desc: "Toyota introduces the next generation of its popular sedan with enhanced fuel efficiency and a sleek new exterior design.",
          ),
          _buildNewsCard(
            date: "Oct 18, 2025",
            title: "BMW X5 Facelift Revealed for 2025",
            desc: "The new BMW X5 comes with updated tech, a sharper exterior design, and improved powertrain options for 2025.",
          ),
        ],
      ),
    );
  }

  // التعديل هنا: كبرنا الكارت ومساحة الصورة والخطوط
  Widget _buildNewsCard({required String date, required String title, required String desc}) {
    return Container(
      width: 320, // كبرنا عرض الكارت
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // حواف أنعم
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160, // كبرنا مساحة الصورة
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Center(child: Icon(Icons.article_outlined, size: 50, color: AppColors.textHint)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0), // زودنا المسافات الداخلية
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(color: AppColors.textHint, fontSize: 13)),
                const SizedBox(height: 12),
                Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 12),
                Text(
                    desc,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                    maxLines: 3, // سمحنا للمحتوى ياخد 3 سطور
                    overflow: TextOverflow.ellipsis
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarList({bool isPromotedSection = false}) {
    return SizedBox(
      height: 340,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          CarCard(
            brand: "BMW",
            model: "X5 2025",
            year: "2025",
            price: "EGP 1,850,000",
            rating: "4.9",
            isTopRated: true,
            isPromoted: isPromotedSection,
          ),
          CarCard(
            brand: "Toyota",
            model: "Corolla",
            year: "2025",
            price: "EGP 520,000",
            rating: "4.7",
            isTopRated: true,
            isPromoted: isPromotedSection,
          ),
          CarCard(
            brand: "Hyundai",
            model: "Elantra",
            year: "2025",
            price: "EGP 485,000",
            rating: "4.5",
            isTopRated: false,
            isPromoted: isPromotedSection,
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(12)),
          child: Image.asset('assets/images/logo.png', height: 24, width: 24),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: const [
                  Icon(Icons.search, color: AppColors.textHint),
                  SizedBox(width: 8),
                  Text("Search cars...", style: TextStyle(color: AppColors.textHint)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const FiltersBottomSheet(),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.secondary, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionCard(
          title: "Saved Cars",
          icon: Icons.favorite_border,
          iconColor: Colors.black,
          onTap: () {},
        ),
        _buildActionCard(
          title: "Saved Parts",
          icon: Icons.build_outlined,
          iconColor: AppColors.primary,
          onTap: () {},
        ),
        _buildActionCard(
          title: "Find Nearby",
          icon: Icons.location_on_outlined,
          iconColor: const Color(0xFFE57373), // الأحمر الهادي اللي اتفقنا عليه
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyLocationsScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({required String title, required IconData icon, required Color iconColor, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}