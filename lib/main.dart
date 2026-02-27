import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استدعاء البلوك
import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart'; // استدعاء المخ اللي لسه عاملينه
import 'features/intro/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GearUpApp());
}

class GearUpApp extends StatelessWidget {
  const GearUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. غلفنا التطبيق بـ BlocProvider عشان الـ ThemeCubit يكون مقروء في أي شاشة
    return BlocProvider(
      create: (context) => ThemeCubit(),
      // 2. استخدمنا BlocBuilder عشان يتصنت على أي تغيير في الـ ThemeMode
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gear Up',

            // الثيم الفاتح بتاعنا
            theme: AppTheme.lightTheme,

            // الثيم الغامق (مؤقتاً هنستخدم الديفولت لحد ما نعملك واحد بريميوم)
            darkTheme: ThemeData.dark(),

            // هنا بنقول للتطبيق: "اسمع كلام الـ Cubit في تحديد الثيم"
            themeMode: themeMode,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}