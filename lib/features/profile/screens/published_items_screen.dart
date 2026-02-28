import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import 'start_selling_screen.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart';

class PublishedItemsScreen extends StatefulWidget {
  const PublishedItemsScreen({super.key});

  @override
  State<PublishedItemsScreen> createState() => _PublishedItemsScreenState();
}

class _PublishedItemsScreenState extends State<PublishedItemsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // بنجيب الكلمات من القاموس ونضيف جنبها الرقم الوهمي
    final List<String> tabs = [
      "${AppLang.tr(context, 'tab_all')} (0)",
      "${AppLang.tr(context, 'tab_cars')} (0)",
      "${AppLang.tr(context, 'tab_parts')} (0)",
      "${AppLang.tr(context, 'tab_accessories')} (0)"
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLang.tr(context, 'published_items'), style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 4),
                Text(AppLang.tr(context, 'manage_listings'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : (isDark ? AppColors.surfaceDark : Colors.white),
                      border: Border.all(color: isSelected ? AppColors.primary : (isDark ? AppColors.borderDark : const Color(0xFFEEEEEE))),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.textSecondary),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA), shape: BoxShape.circle, border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE))),
                    child: const Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLang.tr(context, 'no_listings_yet'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 8),
                  Text(AppLang.tr(context, 'haven_not_published'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary)),
                  const SizedBox(height: 32),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StartSellingScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Text(AppLang.tr(context, 'start_selling'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AiChatBottomSheet(),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
      ),
    );
  }
}