import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../local_storage/cache_helper.dart'; // ظبط المسار ده حسب مشروعك

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadLocale(); // أول ما يشتغل يدور في الذاكرة
  }

  void _loadLocale() {
    String? languageCode = CacheHelper.getData(key: 'languageCode');
    if (languageCode != null) {
      emit(Locale(languageCode));
    } else {
      emit(const Locale('en')); // الإنجليزي هو الديفولت
    }
  }

  void changeLanguage(String languageCode) {
    if (state.languageCode != languageCode) {
      CacheHelper.saveData(key: 'languageCode', value: languageCode);
      emit(Locale(languageCode));
    }
  }
}