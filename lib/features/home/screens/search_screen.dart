import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../widgets/filters_bottom_sheet.dart'; // 1. استدعاء ملف الفلاتر هنا

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // قائمة البحث الشائعة
  final List<String> popularSearches = [
    "Toyota Corolla 2025",
    "BMW X5 2025",
    "Hyundai Elantra 2025",
    "Mercedes GLE 2025",
    "Kia Sportage 2024",
    "Audi Q7 2025",
    "Toyota Camry 2024",
    "Kia Cerato 2025",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. الهيدر (شريط البحث)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // زر الرجوع
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // شريط البحث
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true, // فتح الكيبورد تلقائياً
                        decoration: const InputDecoration(
                          hintText: "Search cars...",
                          hintStyle: TextStyle(color: AppColors.textHint),
                          prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 2. زر الفلاتر (التعديل هنا ✅)
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const FiltersBottomSheet(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
            ),

            // 2. قائمة البحث الشائعة
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                "POPULAR SEARCHES",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textHint),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: popularSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.search, color: AppColors.textHint, size: 20),
                    title: Text(popularSearches[index], style: const TextStyle(fontSize: 16)),
                    onTap: () {
                      // لاحقاً سيتم إضافة كود الانتقال لنتائج البحث
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}