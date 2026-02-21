import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../widgets/car_card.dart';
import '../widgets/filters_bottom_sheet.dart';
import 'search_screen.dart';

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

              _buildQuickActions(),
              const SizedBox(height: 32),

              // 1. القسم المميز (الخلفية الصفراء)
              _buildPromotedSection(),
              const SizedBox(height: 24),

              // 2. قسم العربيات الأعلى تقييماً
              _buildSectionWrapper(
                title: "Top Rated New Cars",
                subtitle: "Best rated vehicles in 2025",
                content: _buildCarList(), // الديفولت هنا false
              ),
              const SizedBox(height: 24),

              // 3. قسم الأخبار
              _buildSectionWrapper(
                title: "News",
                subtitle: "Latest news and updates",
                actionText: "More ➔",
                content: _buildNewsList(),
              ),
              const SizedBox(height: 24),

              // 4. قسم العربيات الجديدة
              _buildSectionWrapper(
                title: "New Cars",
                subtitle: "Latest models from top brands",
                actionText: "View All ➔",
                content: _buildCarList(), // الديفولت هنا false
              ),
              const SizedBox(height: 24),

              // 5. قسم العربيات المستعملة
              _buildSectionWrapper(
                title: "Used Cars",
                subtitle: "Quality pre-owned vehicles",
                actionText: "View All ➔",
                content: _buildCarList(), // الديفولت هنا false
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWrapper({required String title, required String subtitle, required Widget content, String? actionText}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8FF),
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
                Text(actionText, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary))
              else
                Row(
                  children: const [
                    Icon(Icons.chevron_left, color: AppColors.textHint),
                    Icon(Icons.chevron_right, color: AppColors.secondary),
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
                  Icon(Icons.chevron_left, color: AppColors.textHint),
                  Icon(Icons.chevron_right, color: AppColors.secondary),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text("Premium featured listings", style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          const SizedBox(height: 16),

          // التعديل هنا: بعتنا (true) عشان نقول للكروت إن دي إعلانات
          _buildCarList(isPromotedSection: true),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return SizedBox(
      height: 290,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildNewsCard(
            date: "Oct 20, 2025",
            title: "Toyota Unveils All-New 2025 Camry Hybrid",
            desc: "Toyota introduces the next generation of its popular sedan with enhanced fuel efficiency.",
          ),
          _buildNewsCard(
            date: "Oct 18, 2025",
            title: "BMW X5 Facelift Revealed",
            desc: "The new BMW X5 comes with updated tech and a sharper exterior design for 2025.",
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({required String date, required String title, required String desc}) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Center(child: Icon(Icons.article_outlined, size: 40, color: AppColors.textHint)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // التعديل هنا: خلينا الدالة تستقبل متغير بيحدد هل ده قسم الإعلانات ولا لأ
  Widget _buildCarList({bool isPromotedSection = false}) {
    return SizedBox(
      height: 300,
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
            isPromoted: isPromotedSection, // بنمرر الحالة للكارت
          ),
          CarCard(
            brand: "Toyota",
            model: "Corolla",
            year: "2025",
            price: "EGP 520,000",
            rating: "4.7",
            isTopRated: true,
            isPromoted: isPromotedSection, // بنمرر الحالة للكارت
          ),
          CarCard(
            brand: "Hyundai",
            model: "Elantra",
            year: "2025",
            price: "EGP 485,000",
            rating: "4.5",
            isTopRated: false,
            isPromoted: isPromotedSection, // بنمرر الحالة للكارت
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

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionCard("Saved Cars", Icons.favorite_border, Colors.black),
        _buildActionCard("Saved Parts", Icons.build_outlined, Colors.purpleAccent),
        _buildActionCard("Find Nearby", Icons.location_on_outlined, Colors.redAccent),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color iconColor) {
    return Expanded(
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
    );
  }
}