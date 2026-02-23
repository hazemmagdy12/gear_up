import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class NearbyLocationsScreen extends StatefulWidget {
  const NearbyLocationsScreen({super.key});

  @override
  State<NearbyLocationsScreen> createState() => _NearbyLocationsScreenState();
}

class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
  // متغير عشان نبدل بين التابات (Service Center أو Showroom)
  bool isServiceCenterActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الهيدر
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Nearby Locations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                      Text("Service centers & showrooms", style: TextStyle(fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ],
              ),
            ),

            // 2. خريطة وهمية (Placeholder)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
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
                    const Text("Interactive Map", style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text("Shows service centers & showrooms near you", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. أزرار الفلترة (Tabs)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildTabButton(
                    title: "Service Center",
                    icon: Icons.build_outlined,
                    isActive: isServiceCenterActive,
                    onTap: () => setState(() => isServiceCenterActive = true),
                  ),
                  const SizedBox(width: 12),
                  _buildTabButton(
                    title: "Showroom",
                    icon: Icons.directions_car_outlined,
                    isActive: !isServiceCenterActive,
                    onTap: () => setState(() => isServiceCenterActive = false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 4. لستة الأماكن
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  if (isServiceCenterActive) ...[
                    _buildLocationCard(
                      name: "Elite Auto Service",
                      phone: "+20 2 1234 5678",
                      distance: "2.3 km away",
                      icon: Icons.build_outlined,
                      iconColor: AppColors.primary,
                    ),
                    _buildLocationCard(
                      name: "Premium Car Care",
                      phone: "+20 2 3456 7890",
                      distance: "3.7 km away",
                      icon: Icons.build_outlined,
                      iconColor: AppColors.primary,
                    ),
                  ] else ...[
                    _buildLocationCard(
                      name: "Toyota Showroom - Nasr City",
                      phone: "+20 2 2345 6789",
                      distance: "5.1 km away",
                      icon: Icons.directions_car_outlined,
                      iconColor: AppColors.secondary,
                    ),
                    _buildLocationCard(
                      name: "Hyundai Showroom - Heliopolis",
                      phone: "+20 2 4567 8901",
                      distance: "6.8 km away",
                      icon: Icons.directions_car_outlined,
                      iconColor: AppColors.secondary,
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

  // --- دوال مساعدة ---

  Widget _buildTabButton({required String title, required IconData icon, required bool isActive, required VoidCallback onTap}) {
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
                color: isActive ? Colors.transparent : AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: isActive ? Colors.white : Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard({required String name, required String phone, required String distance, required IconData icon, required Color iconColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4)),
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
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.secondary)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(phone, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(distance, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
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
              label: const Text("Get Directions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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