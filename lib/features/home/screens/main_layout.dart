import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'home_screen.dart'; // استدعاء ملف شاشة الهوم
import '../widgets/ai_chat_bottom_sheet.dart'; // استدعاء شات الذكاء الاصطناعي
import '../../compare/screens/compare_screen.dart'; // 1. التعديل هنا: استدعاء شاشة المقارنة

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // الشاشات الـ 5 اللي بنبدل بينهم
  final List<Widget> _screens = [
    const HomeScreen(),
    const CompareScreen(), // 2. التعديل هنا: استبدال النص بالشاشة الحقيقية
    const Center(child: Text("Parts Screen", style: TextStyle(fontSize: 20))),
    const Center(child: Text("My Car Screen", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Profile Screen", style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[_currentIndex], // عرض الشاشة حسب الاختيار

      // زرار الذكاء الاصطناعي العائم
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // فتح شات الذكاء الاصطناعي
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // عشان ياخد الارتفاع اللي حددناه
            backgroundColor: Colors.transparent,
            builder: (context) => const AiChatBottomSheet(),
          );
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(), // شكل دائري
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),

      // شريط التنقل السفلي
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // تغيير الشاشة عند الضغط
          });
        },
        type: BottomNavigationBarType.fixed, // تثبيت الأيقونات عشان مفيش حاجة تختفي
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
}