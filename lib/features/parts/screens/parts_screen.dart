import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تحديد الثيم الحالي
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // خلفية من الثيم
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLang.tr(context, 'car_parts'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                  Text("10 ${AppLang.tr(context, 'parts_available')}", style: const TextStyle(fontSize: 14, color: AppColors.textHint)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 52,
                // التعديل 1: قص أي لون بيحاول يخرج بره الحواف الدائرية
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent),
                ),
                child: TextField(
                  style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  // التعديل 2: سنترة النص مع الأيقونة
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: AppLang.tr(context, 'search_parts'),
                    hintStyle: const TextStyle(color: AppColors.textHint),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textHint),

                    // التعديل 3: إخفاء خلفية حقل الإدخال الافتراضية
                    filled: true,
                    fillColor: Colors.transparent,

                    border: InputBorder.none,
                    focusedBorder: InputBorder.none, // منع ظهور خطوط وقت الكتابة
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF333333) : AppColors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  _buildDropdownMenu(
                    title: AppLang.tr(context, 'company'),
                    isDark: isDark,
                    items: [
                      AppLang.tr(context, 'all_companies'),
                      "Hyundai New Accent",
                      "Toyota Corolla",
                      "Honda Civic",
                      "Kia Cerato",
                      "Hyundai Elantra",
                      "BMW 3 Series"
                    ],
                  ),
                  const SizedBox(width: 12),
                  _buildDropdownMenu(
                    title: AppLang.tr(context, 'price'),
                    isDark: isDark,
                    items: [AppLang.tr(context, 'default_sort'), AppLang.tr(context, 'low_to_high'), AppLang.tr(context, 'high_to_low')],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: isDark ? AppColors.borderDark : AppColors.borderLight, thickness: 1),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPartCard(
                    context: context,
                    isDark: isDark,
                    title: "CTR Front Arm Set\n(Korean)",
                    company: "Hyundai New Accent",
                    fits: "2006-2011",
                    price: "EGP 1,350",
                  ),
                  _buildPartCard(
                    context: context,
                    isDark: isDark,
                    title: "Brake Pad Set",
                    company: "Toyota Corolla",
                    fits: "2014-2020",
                    price: "EGP 850",
                  ),
                  _buildPartCard(
                    context: context,
                    isDark: isDark,
                    title: "Air Filter",
                    company: "Honda Civic",
                    fits: "2016-2024",
                    price: "EGP 320",
                  ),
                  _buildPartCard(
                    context: context,
                    isDark: isDark,
                    title: "Oil Filter",
                    company: "Kia Cerato",
                    fits: "2019-2025",
                    price: "EGP 250",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu({required String title, required List<String> items, required bool isDark}) {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      color: isDark ? AppColors.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDark ? AppColors.borderDark : Colors.transparent),
      ),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: item == items.first ? FontWeight.bold : FontWeight.normal
            )),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 6),
            Icon(Icons.keyboard_arrow_down, color: isDark ? Colors.white : Colors.black87, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPartCard({required BuildContext context, required bool isDark, required String title, required String company, required String fits, required String price}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.borderLight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Icon(Icons.settings, color: AppColors.textHint, size: 40)),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, height: 1.2, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 6),
                Text(company, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 4),
                Text("${AppLang.tr(context, 'fits')}$fits", style: const TextStyle(color: AppColors.textHint, fontSize: 13)),
                const SizedBox(height: 12),
                Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
          ),

          Icon(Icons.favorite_border, color: isDark ? Colors.white70 : AppColors.textSecondary, size: 26),
        ],
      ),
    );
  }
}