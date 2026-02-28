import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../local_storage/cache_helper.dart'; // ظبط المسار ده حسب مشروعك

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme(); // أول ما يشتغل يدور في الذاكرة
  }

  void _loadTheme() {
    bool? isDark = CacheHelper.getData(key: 'isDark');
    if (isDark != null && isDark) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      CacheHelper.saveData(key: 'isDark', value: true);
      emit(ThemeMode.dark);
    } else {
      CacheHelper.saveData(key: 'isDark', value: false);
      emit(ThemeMode.light);
    }
  }
}