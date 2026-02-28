import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../../home/widgets/ai_chat_bottom_sheet.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedCategory = 0;

  final Map<String, GlobalKey> _categoryKeys = {
    "General": GlobalKey(),
    "Features": GlobalKey(),
    "My Car": GlobalKey(),
    "Parts": GlobalKey(),
    "Account": GlobalKey(),
    "Service": GlobalKey(),
    "Settings": GlobalKey(),
  };

  void _scrollToCategory(String categoryKey) {
    if (categoryKey == 'all') return;

    // بنجيب الكلمة الإنجليزي المقابلة للمفتاح عشان الـ Keys مبنية على الإنجليزي
    String englishCategory = _getEnglishCategoryFromKey(categoryKey);
    final key = _categoryKeys[englishCategory];

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  String _getEnglishCategoryFromKey(String key) {
    switch (key) {
      case 'general': return 'General';
      case 'features': return 'Features';
      case 'my_car': return 'My Car';
      case 'parts': return 'Parts';
      case 'account_information': return 'Account'; // Account -> account_information in translation
      case 'service': return 'Service';
      case 'settings': return 'Settings';
      default: return 'General';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // قائمة الفئات بنجيبها من القاموس
    final List<Map<String, String>> categories = [
      {'key': 'all', 'title': AppLang.tr(context, 'all')},
      {'key': 'general', 'title': AppLang.tr(context, 'general')},
      {'key': 'features', 'title': AppLang.tr(context, 'features')},
      {'key': 'my_car', 'title': AppLang.tr(context, 'my_car')},
      {'key': 'account_information', 'title': AppLang.tr(context, 'account_information').split(' ')[0]}, // هناخد أول كلمة بس
      {'key': 'parts', 'title': AppLang.tr(context, 'parts')},
      {'key': 'service', 'title': AppLang.tr(context, 'service')},
      {'key': 'settings', 'title': AppLang.tr(context, 'settings')},
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
        title: Text(AppLang.tr(context, 'help_center'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? AppColors.borderDark : Colors.transparent),
              ),
              child: TextField(
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: InputDecoration(
                  hintText: AppLang.tr(context, 'search_help'),
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildContactCard(Icons.chat_bubble_outline, AppLang.tr(context, 'chat_support'), isDark)),
                const SizedBox(width: 16),
                Expanded(child: _buildContactCard(Icons.phone_outlined, AppLang.tr(context, 'call_us'), isDark)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildContactCard(Icons.email_outlined, AppLang.tr(context, 'email_us'), isDark)),
                const SizedBox(width: 16),
                Expanded(child: _buildContactCard(Icons.book_outlined, AppLang.tr(context, 'user_guide'), isDark)),
              ],
            ),
            const SizedBox(height: 32),

            Text(AppLang.tr(context, 'categories'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCategory = index);
                      _scrollToCategory(categories[index]['key']!);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12), // هيقلب لفت لوحده في العربي
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E7D32) : AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          categories[index]['title']!,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                const Icon(Icons.help_outline, color: Color(0xFF2E7D32), size: 20),
                const SizedBox(width: 8),
                Text(AppLang.tr(context, 'faq'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
              ],
            ),
            const SizedBox(height: 16),

            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["General"], category: AppLang.tr(context, 'general'), question: AppLang.tr(context, 'faq_q1'), answer: AppLang.tr(context, 'faq_a1'), isExpanded: true),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["Features"], category: AppLang.tr(context, 'features'), question: AppLang.tr(context, 'faq_q2'), answer: AppLang.tr(context, 'faq_a2')),
            _buildFaqItem(context: context, isDark: isDark, category: AppLang.tr(context, 'features'), question: AppLang.tr(context, 'faq_q3'), answer: AppLang.tr(context, 'faq_a3')),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["My Car"], category: AppLang.tr(context, 'my_car'), question: AppLang.tr(context, 'faq_q4'), answer: AppLang.tr(context, 'faq_a4')),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["Parts"], category: AppLang.tr(context, 'parts'), question: AppLang.tr(context, 'faq_q5'), answer: AppLang.tr(context, 'faq_a5')),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["Account"], category: AppLang.tr(context, 'account_information').split(' ')[0], question: AppLang.tr(context, 'faq_q6'), answer: AppLang.tr(context, 'faq_a6')),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["Service"], category: AppLang.tr(context, 'service'), question: AppLang.tr(context, 'faq_q7'), answer: AppLang.tr(context, 'faq_a7')),
            _buildFaqItem(context: context, isDark: isDark, key: _categoryKeys["Settings"], category: AppLang.tr(context, 'settings'), question: AppLang.tr(context, 'faq_q8'), answer: AppLang.tr(context, 'faq_a8')),
            _buildFaqItem(context: context, isDark: isDark, category: AppLang.tr(context, 'features'), question: AppLang.tr(context, 'faq_q9'), answer: AppLang.tr(context, 'faq_a9')),
            _buildFaqItem(context: context, isDark: isDark, category: AppLang.tr(context, 'account_information').split(' ')[0], question: AppLang.tr(context, 'faq_q10'), answer: AppLang.tr(context, 'faq_a10')),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A2235) : const Color(0xFFC0D2E4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLang.tr(context, 'still_need_help'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined, color: Color(0xFF2E7D32), size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLang.tr(context, 'phone'), style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12)),
                          Text("+1 (800) 123-4567", style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined, color: Color(0xFF2E7D32), size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLang.tr(context, 'email'), style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 12)),
                          Text("support@gearup.com", style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
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

  Widget _buildContactCard(IconData icon, String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required BuildContext context, required bool isDark, Key? key, required String category, required String question, required String answer, bool isExpanded = false}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          iconColor: isDark ? Colors.white : Colors.black,
          collapsedIconColor: isDark ? Colors.white : Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(category, style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Text(question, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(answer, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, height: 1.5, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}