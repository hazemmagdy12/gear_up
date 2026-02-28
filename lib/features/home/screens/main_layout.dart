import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import 'home_screen.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import '../../compare/screens/compare_screen.dart';
import '../../parts/screens/parts_screen.dart';
import '../../my_car/screens/my_car_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  double? _aiButtonX;
  double? _aiButtonY;
  bool _isAiHidden = false;
  bool _isHiddenLeft = false;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CompareScreen(),
    const PartsScreen(),
    const MyCarScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_aiButtonX == null || _aiButtonY == null) {
      final size = MediaQuery.of(context).size;
      _aiButtonX = size.width - 80;
      _aiButtonY = size.height - 180;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
          SafeArea(child: _screens[_currentIndex]),

          if (_isAiHidden)
            _buildHiddenAiArrow(isDark)
          else
            _buildDraggableAiButton(isDark),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: isDark ? Colors.white : AppColors.primary,
        unselectedItemColor: isDark ? Colors.white54 : AppColors.textHint,
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        elevation: 10,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: AppLang.tr(context, 'home')),
          BottomNavigationBarItem(icon: const Icon(Icons.compare_arrows), label: AppLang.tr(context, 'compare')),
          BottomNavigationBarItem(icon: const Icon(Icons.build_outlined), label: AppLang.tr(context, 'parts')),
          BottomNavigationBarItem(icon: const Icon(Icons.directions_car_outlined), label: AppLang.tr(context, 'my_car')),
          BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: AppLang.tr(context, 'profile')),
        ],
      ),
    );
  }

  // --- دوال مساعدة لزرار الذكاء الاصطناعي ---

  Widget _buildDraggableAiButton(bool isDark) {
    return Positioned(
      left: _aiButtonX,
      top: _aiButtonY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            final size = MediaQuery.of(context).size;
            _aiButtonX = _aiButtonX! + details.delta.dx;
            _aiButtonY = (_aiButtonY! + details.delta.dy).clamp(0.0, size.height - 160);

            if (_aiButtonX! >= size.width - 60) {
              _isAiHidden = true;
              _isHiddenLeft = false;
            }
            else if (_aiButtonX! <= 10) {
              _isAiHidden = true;
              _isHiddenLeft = true;
            }
          });
        },
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AiChatBottomSheet(),
            );
          },
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: const CircleBorder(),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  Widget _buildHiddenAiArrow(bool isDark) {
    return Positioned(
      left: _isHiddenLeft ? 0 : null,
      right: _isHiddenLeft ? null : 0,
      top: _aiButtonY,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isAiHidden = false;
            _aiButtonX = _isHiddenLeft ? 30.0 : MediaQuery.of(context).size.width - 90;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: _isHiddenLeft
                ? const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16))
                : const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.4 : 0.2),
                  blurRadius: 4,
                  offset: Offset(_isHiddenLeft ? 2 : -2, 2)
              ),
            ],
          ),
          child: Icon(
              _isHiddenLeft ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16
          ),
        ),
      ),
    );
  }
}