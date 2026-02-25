import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ["All", "General", "Features", "My Car", "Account", "Parts", "Service", "Settings"];

  // مفاتيح (Keys) عشان السكرول يروح لمكان معين
  final Map<String, GlobalKey> _categoryKeys = {
    "General": GlobalKey(),
    "Features": GlobalKey(),
    "My Car": GlobalKey(),
    "Parts": GlobalKey(),
    "Account": GlobalKey(),
    "Service": GlobalKey(),
    "Settings": GlobalKey(),
  };

  void _scrollToCategory(String category) {
    if (category == "All") return;
    final key = _categoryKeys[category];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1, // عشان يخلي السؤال في بداية الشاشة تقريباً
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Help Center", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
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
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search for help...",
                  hintStyle: TextStyle(color: AppColors.textHint),
                  prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildContactCard(Icons.chat_bubble_outline, "Chat Support")),
                const SizedBox(width: 16),
                Expanded(child: _buildContactCard(Icons.phone_outlined, "Call Us")),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildContactCard(Icons.email_outlined, "Email Us")),
                const SizedBox(width: 16),
                Expanded(child: _buildContactCard(Icons.book_outlined, "User Guide")),
              ],
            ),
            const SizedBox(height: 32),

            const Text("Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCategory = index);
                      _scrollToCategory(_categories[index]); // التنقل التلقائي
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E7D32) : AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
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
              children: const [
                Icon(Icons.help_outline, color: Color(0xFF2E7D32), size: 20),
                SizedBox(width: 8),
                Text("Frequently Asked Questions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),

            // إضافة الـ Keys لأول سؤال في كل قسم
            _buildFaqItem(key: _categoryKeys["General"], category: "General", question: "How do I search for a car?", answer: "You can search for cars by browsing...", isExpanded: true),
            _buildFaqItem(key: _categoryKeys["Features"], category: "Features", question: "How do I save a car to my favorites?", answer: "Tap the heart icon on any car card..."),
            _buildFaqItem(category: "Features", question: "How does the comparison feature work?", answer: "Select up to 3 cars by tapping..."),
            _buildFaqItem(key: _categoryKeys["My Car"], category: "My Car", question: "Can I track my car maintenance?", answer: "Yes! Go to your Profile, then \"My Car\"..."),
            _buildFaqItem(key: _categoryKeys["Parts"], category: "Parts", question: "How do I find car parts?", answer: "Visit the Car Parts section..."),
            _buildFaqItem(key: _categoryKeys["Account"], category: "Account", question: "How do I reset my password?", answer: "On the login screen, tap \"Forgot Password?\"..."),
            _buildFaqItem(key: _categoryKeys["Service"], category: "Service", question: "Where can I find service centers near me?", answer: "Go to the Map section..."),
            _buildFaqItem(key: _categoryKeys["Settings"], category: "Settings", question: "How do I enable dark mode?", answer: "Navigate to Settings..."),
            _buildFaqItem(category: "Features", question: "What is the AI Chat Agent?", answer: "The AI Chat Agent is your virtual assistant..."),
            _buildFaqItem(category: "Account", question: "How do I change my profile information?", answer: "Go to your Profile page..."),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFC0D2E4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Still need help?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined, color: Color(0xFF2E7D32), size: 20),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Phone", style: TextStyle(color: Colors.black54, fontSize: 12)),
                          Text("+1 (800) 123-4567", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
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
                        children: const [
                          Text("Email", style: TextStyle(color: Colors.black54, fontSize: 12)),
                          Text("support@gearup.com", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
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
      // تعديل زرار الـ AI الفخم
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
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
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFaqItem({Key? key, required String category, required String question, required String answer, bool isExpanded = false}) {
    return Container(
      key: key, // مفتاح السكرول
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
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
              Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black)),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(answer, style: const TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}