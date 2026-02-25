import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'home_screen.dart';
import '../widgets/ai_chat_bottom_sheet.dart';
import '../../compare/screens/compare_screen.dart';
import '../../parts/screens/parts_screen.dart';
import '../../my_car/screens/my_car_screen.dart';
import '../../profile/screens/profile_screen.dart'; // 1. استدعاء شاشة البروفايل

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // ==========================================
  // متغيرات التحكم في زرار الذكاء الاصطناعي العائم
  // ==========================================
  double? _aiButtonX;
  double? _aiButtonY;
  bool _isAiHidden = false; // هل الزرار مخفي؟
  bool _isHiddenLeft = false; // هل استخبى في الشمال ولا اليمين؟

  // الشاشات الـ 5 اللي بنبدل بينهم
  final List<Widget> _screens = [
    const HomeScreen(),
    const CompareScreen(),
    const PartsScreen(),
    const MyCarScreen(),
    const ProfileScreen(), // 2. التعديل هنا: شاشة البروفايل الحقيقية
  ];

  @override
  Widget build(BuildContext context) {
    // تحديد المكان المبدئي للزرار أول مرة الشاشة تفتح
    if (_aiButtonX == null || _aiButtonY == null) {
      final size = MediaQuery.of(context).size;
      _aiButtonX = size.width - 80; // على اليمين
      _aiButtonY = size.height - 180; // فوق شريط التنقل السفلي بشوية
    }

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          // 1. الشاشة الرئيسية اللي شغالة حالياً
          SafeArea(child: _screens[_currentIndex]),

          // 2. زرار الذكاء الاصطناعي العائم أو السهم الجانبي
          if (_isAiHidden)
            _buildHiddenAiArrow()
          else
            _buildDraggableAiButton(),
        ],
      ),

      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.compare_arrows), label: "Compare"),
          BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: "Parts"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car_outlined), label: "My Car"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // --- دوال مساعدة لزرار الذكاء الاصطناعي ---

  // دالة الزرار وهو ظاهر وقابل للسحب
  Widget _buildDraggableAiButton() {
    return Positioned(
      left: _aiButtonX,
      top: _aiButtonY,
      child: GestureDetector(
        // دالة السحب: بتحدث الإحداثيات وتتأكد إمتى تخفي الزرار
        onPanUpdate: (details) {
          setState(() {
            final size = MediaQuery.of(context).size;
            _aiButtonX = _aiButtonX! + details.delta.dx;
            _aiButtonY = (_aiButtonY! + details.delta.dy).clamp(0.0, size.height - 160);

            // لو اليوزر سحب الزرار للحافة اليمين أوي
            if (_aiButtonX! >= size.width - 60) {
              _isAiHidden = true;
              _isHiddenLeft = false; // استخبى في اليمين
            }
            // لو اليوزر سحب الزرار للحافة الشمال أوي
            else if (_aiButtonX! <= 10) {
              _isAiHidden = true;
              _isHiddenLeft = true; // استخبى في الشمال
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

  // دالة السهم الجانبي لما الزرار يكون مخفي
  Widget _buildHiddenAiArrow() {
    return Positioned(
      // بنحدد مكان السهم بناءً على هو استخبى يمين ولا شمال
      left: _isHiddenLeft ? 0 : null,
      right: _isHiddenLeft ? null : 0,
      top: _aiButtonY,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isAiHidden = false; // إظهار الزرار تاني
            // نرجع الزرار لمكان مرئي شوية عشان ميختفيش تاني علطول
            _aiButtonX = _isHiddenLeft ? 30.0 : MediaQuery.of(context).size.width - 90;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            // تدوير الحواف بيختلف حسب اتجاه السهم
            borderRadius: _isHiddenLeft
                ? const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16))
                : const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  // اتجاه الظل بيختلف
                  offset: Offset(_isHiddenLeft ? 2 : -2, 2)
              ),
            ],
          ),
          // اتجاه الأيقونة بيختلف
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