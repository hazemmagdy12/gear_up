import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // 1. التأكد من تهيئة بيئة فلاتر
  WidgetsFlutterBinding.ensureInitialized();

  // 2. تشغيل فايربيز (عشان التطبيق يربط بقاعدة البيانات)
  await Firebase.initializeApp();

  // 3. تشغيل التطبيق
  runApp(const GearUpApp());
}

class GearUpApp extends StatelessWidget {
  const GearUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // شلنا علامة debug الحمراء
      title: 'Gear Up',
      theme: ThemeData(
        // الألوان الأساسية للتطبيق (مؤقتاً)
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TestScreen(),
    );
  }
}

// شاشة مؤقتة للتجربة
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gear Up ⚙️")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Welcome to Gear Up!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("Firebase Connected Successfully ✅", style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}