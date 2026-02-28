import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/localization/cubit/locale_cubit.dart';
import 'core/local_storage/cache_helper.dart';
import 'features/auth/cubit/auth_cubit.dart'; // 1. استدعاء AuthCubit
import 'features/intro/screens/splash_screen.dart';
import 'features/home/screens/main_layout.dart'; // 2. استدعاء الشاشة الرئيسية

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await Firebase.initializeApp();

  // 3. نقرأ الـ UID من الكاش قبل ما نرسم الشاشات
  String? uid = CacheHelper.getData(key: 'uid');

  // 4. نحدد الشاشة الافتراضية بناءً على وجود الـ UID
  Widget startWidget;
  if (uid != null) {
    startWidget = const MainLayout(); // لو مسجل دخول، يدخل على الرئيسية علطول
  } else {
    startWidget = const SplashScreen(); // لو مش مسجل، يبدأ من السبلاش
  }

  runApp(GearUpApp(startWidget: startWidget));
}

class GearUpApp extends StatelessWidget {
  final Widget startWidget; // نستقبل الشاشة الافتراضية هنا

  const GearUpApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => AuthCubit()), // حقن الـ AuthCubit
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Gear Up',

                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,

                locale: locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                home: startWidget, // 5. نمرر الشاشة المحددة بناءً على الكاش
              );
            },
          );
        },
      ),
    );
  }
}