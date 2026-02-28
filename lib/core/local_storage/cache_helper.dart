import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // الدالة دي بنناديها أول ما الأبلكيشن يفتح عشان نجهز الذاكرة
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // حفظ داتا (سواء كانت String, bool, int)
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return false;
  }

  // قراءة الداتا
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // مسح داتا معينة
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}