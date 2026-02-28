import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس

class NearbyLocationsScreen extends StatefulWidget {
  const NearbyLocationsScreen({super.key});

  @override
  State<NearbyLocationsScreen> createState() => _NearbyLocationsScreenState();
}

class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
  bool isServiceCenterActive = true;

  @override
  Widget build(BuildContext context) {
    // تحديد الثيم الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // خلفية من الثيم
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 24, color: isDark ? Colors.white : Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLang.tr(context, 'nearby_locations'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.secondary)),
                      Text(AppLang.tr(context, 'service_and_showrooms'), style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.location_on, size: 48, color: AppColors.textHint),
                        Positioned(
                          top: 0,
                          left: -20,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            child: const Icon(Icons.build, color: Colors.white, size: 12),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -20,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                            child: const Icon(Icons.directions_car, color: Colors.white, size: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(AppLang.tr(context, 'interactive_map'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(AppLang.tr(context, 'shows_places_near_you'), style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildTabButton(
                    title: AppLang.tr(context, 'service_center'),
                    icon: Icons.build_outlined,
                    isActive: isServiceCenterActive,
                    isDark: isDark,
                    onTap: () => setState(() => isServiceCenterActive = true),
                  ),
                  const SizedBox(width: 12),
                  _buildTabButton(
                    title: AppLang.tr(context, 'showroom'),
                    icon: Icons.directions_car_outlined,
                    isActive: !isServiceCenterActive,
                    isDark: isDark,
                    onTap: () => setState(() => isServiceCenterActive = false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  if (isServiceCenterActive) ...[
                    _buildLocationCard(
                      name: "Elite Auto Service",
                      phone: "+20 2 1234 5678",
                      distance: "2.3 ${AppLang.tr(context, 'km_away')}",
                      icon: Icons.build_outlined,
                      iconColor: AppColors.primary,
                      isDark: isDark,
                    ),
                    _buildLocationCard(
                      name: "Premium Car Care",
                      phone: "+20 2 3456 7890",
                      distance: "3.7 ${AppLang.tr(context, 'km_away')}",
                      icon: Icons.build_outlined,
                      iconColor: AppColors.primary,
                      isDark: isDark,
                    ),
                  ] else ...[
                    _buildLocationCard(
                      name: "Toyota Showroom - Nasr City",
                      phone: "+20 2 2345 6789",
                      distance: "5.1 ${AppLang.tr(context, 'km_away')}",
                      icon: Icons.directions_car_outlined,
                      iconColor: AppColors.secondary,
                      isDark: isDark,
                    ),
                    _buildLocationCard(
                      name: "Hyundai Showroom - Heliopolis",
                      phone: "+20 2 4567 8901",
                      distance: "6.8 ${AppLang.tr(context, 'km_away')}",
                      icon: Icons.directions_car_outlined,
                      iconColor: AppColors.secondary,
                      isDark: isDark,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton({required String title, required IconData icon, required bool isActive, required bool isDark, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isActive ? Colors.transparent : (isDark ? const Color(0xFF333333) : AppColors.secondary),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : (isDark ? Colors.white70 : Colors.black),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard({required String name, required String phone, required String distance, required IconData icon, required Color iconColor, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : AppColors.secondary)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 14, color: AppColors.textHint),
                        const SizedBox(width: 4),
                        Text(phone, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textHint),
                        const SizedBox(width: 4),
                        Text(distance, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.near_me_outlined, color: Colors.white, size: 18),
              label: Text(AppLang.tr(context, 'get_directions'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}