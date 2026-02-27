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
    // السطر ده هو السحر: بيعرف إحنا شغالين دارك ولا لايت مود
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // بيسحب لون الخلفية من الـ Theme تلقائي
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context, isDark),
              const SizedBox(height: 24),

              _buildQuickActions(context, isDark),
              const SizedBox(height: 36),

              _buildPromotedSection(isDark),
              const SizedBox(height: 28),

              _buildSectionWrapper(
                isDark: isDark,
                title: "Top Rated New Cars",
                subtitle: "Best rated vehicles in 2025",
                actionText: "View More",
                // ألوان مختلفة تتناسب مع الدارك مود
                bgColor: isDark ? const Color(0xFF1A2235) : const Color(0xFFF0F4FF),
                content: _buildCarList(),
              ),
              const SizedBox(height: 28),

              _buildSectionWrapper(
                isDark: isDark,
                title: "News & Insights",
                subtitle: "Latest automotive updates",
                actionText: "View More",
                bgColor: isDark ? AppColors.surfaceDark : const Color(0xFFF8F9FA),
                content: _buildNewsList(isDark),
              ),
              const SizedBox(height: 28),

              _buildSectionWrapper(
                isDark: isDark,
                title: "New Cars",
                subtitle: "Latest models from top brands",
                actionText: "View More",
                bgColor: isDark ? const Color(0xFF1E262B) : const Color(0xFFEEF2F5),
                content: _buildCarList(),
              ),
              const SizedBox(height: 28),

              _buildSectionWrapper(
                isDark: isDark,
                title: "Used Cars",
                subtitle: "Quality pre-owned vehicles",
                actionText: "View More",
                bgColor: isDark ? const Color(0xFF222222) : const Color(0xFFF5F6F8),
                content: _buildCarList(),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWrapper({
    required bool isDark,
    required String title,
    required String subtitle,
    required Widget content,
    String? actionText,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
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
                  Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : AppColors.secondary)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : AppColors.textSecondary, fontWeight: FontWeight.w500)),
                ],
              ),
              if (actionText != null)
                Row(
                  children: [
                    Text(actionText, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? AppColors.primary : AppColors.secondary, fontSize: 13)),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, color: isDark ? AppColors.primary : AppColors.secondary, size: 12),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }

  Widget _buildPromotedSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF332B1A) : const Color(0xFFFFF9E6), // لون غامق يناسب البروموتيد
        borderRadius: BorderRadius.circular(28),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFFD35400)),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF39C12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Featured Listings", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("View More", style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.secondary, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: isDark ? Colors.white : AppColors.secondary, size: 12),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text("Premium featured listings", style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const SizedBox(height: 24),

          _buildCarList(isPromotedSection: true),
        ],
      ),
    );
  }

  Widget _buildNewsList(bool isDark) {
    return SizedBox(
      height: 420,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          _buildNewsCard(
            isDark: isDark,
            date: "Oct 20, 2025",
            title: "Toyota Unveils All-New 2025 Camry Hybrid",
            desc: "Toyota introduces the next generation of its popular sedan with enhanced fuel efficiency, a sleek new exterior design, and an upgraded tech interior.",
          ),
          _buildNewsCard(
            isDark: isDark,
            date: "Oct 18, 2025",
            title: "BMW X5 Facelift Revealed for 2025",
            desc: "The new BMW X5 comes with updated tech, a sharper exterior design, and improved powertrain options for 2025 to lead the luxury SUV market.",
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard({required bool isDark, required String date, required String title, required String desc}) {
    return Container(
      width: 340,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent), // حد خفيف في الدارك
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.06), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: const Center(child: Icon(Icons.newspaper_rounded, size: 70, color: AppColors.textHint)),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
                  child: Text(date, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, height: 1.3, color: isDark ? Colors.white : Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 12),
                Text(
                    desc,
                    style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14, height: 1.5),
                    maxLines: 3,
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
      height: 380,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: [
          CarCard(brand: "BMW", model: "X5 2025", year: "2025", price: "EGP 1,850,000", rating: "4.9", isTopRated: true, isPromoted: isPromotedSection),
          CarCard(brand: "Toyota", model: "Corolla", year: "2025", price: "EGP 520,000", rating: "4.7", isTopRated: true, isPromoted: isPromotedSection),
          CarCard(brand: "Hyundai", model: "Elantra", year: "2025", price: "EGP 485,000", rating: "4.5", isTopRated: false, isPromoted: isPromotedSection),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight), borderRadius: BorderRadius.circular(14)),
          child: Image.asset('assets/images/logo.png', height: 26, width: 26),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const SearchScreen(), transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 52,
              decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : Colors.white, border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight), borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: const [
                  Icon(Icons.search, color: AppColors.textHint, size: 22),
                  SizedBox(width: 8),
                  Text("Search cars...", style: TextStyle(color: AppColors.textHint, fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        GestureDetector(
          onTap: () {
            showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const FiltersBottomSheet());
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.tune, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionCard(
          isDark: isDark,
          title: "Saved Cars",
          icon: Icons.favorite_border,
          iconColor: isDark ? Colors.white : Colors.black87,
          onTap: () {},
        ),
        _buildActionCard(
          isDark: isDark,
          title: "Saved Parts",
          icon: Icons.build_outlined,
          iconColor: AppColors.primary,
          onTap: () {},
        ),
        _buildActionCard(
          isDark: isDark,
          title: "Find Nearby",
          icon: Icons.location_on_outlined,
          iconColor: const Color(0xFFE57373),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyLocationsScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildActionCard({required bool isDark, required String title, required IconData icon, required Color iconColor, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.02), blurRadius: 6, offset: const Offset(0, 3))],
          ),
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 30),
              const SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}