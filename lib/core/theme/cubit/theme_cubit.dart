import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. الكلاس ده بيورث من Cubit ونوعه ThemeMode (يعني حالته يا فاتح يا غامق)
class ThemeCubit extends Cubit<ThemeMode> {

  // 2. أول ما الـ Cubit يشتغل، بيبدأ بالثيم الفاتح كافتراضي، وبينده على دالة تحميل الثيم المحفوظ
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  // 3. مفتاح الحفظ في ذاكرة الموبايل
  static const String _themeKey = 'isDarkMode';

  // 4. دالة بتجيب الثيم المحفوظ من الميموري
  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // بندور على المفتاح، لو ملقيناهوش بنفترض إنه false (يعني فاتح)
    final isDark = prefs.getBool(_themeKey) ?? false;
    // بنعمل emit (تحديث للحالة) بناءً على القيمة اللي لقيناها
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  // 5. دالة بتعكس الثيم (لو فاتح تخليه غامق والعكس) وبتحفظ الاختيار الجديد
  void toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;

    // بنحدث واجهة التطبيق فوراً
    emit(newTheme);

    // بنحفظ الاختيار الجديد في ذاكرة الموبايل عشان يفضل موجود لما نقفل الأبلكيشن
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, !isDark);
  }
}