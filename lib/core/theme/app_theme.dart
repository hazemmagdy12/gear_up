import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      // إعدادات الخطوط الافتراضية
      fontFamily: 'Roboto', // أو أي خط تحبه

      // ستايل الأزرار الموحد (Elevated Button)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // لون الخلفية أزرق
          foregroundColor: Colors.white,      // لون الكلام أبيض
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // الحواف الدائرية زي التصميم
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // ارتفاع الزرار
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ستايل حقول الكتابة (Text Form Field)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface, // الرمادي الفاتح
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // من غير حدود سوداء
        ),
        hintStyle: const TextStyle(color: AppColors.textHint),
      ),
    );
  }
}