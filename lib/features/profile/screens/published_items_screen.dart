import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import 'start_selling_screen.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء الذكاء الاصطناعي

class PublishedItemsScreen extends StatefulWidget {
  const PublishedItemsScreen({super.key});

  @override
  State<PublishedItemsScreen> createState() => _PublishedItemsScreenState();
}

class _PublishedItemsScreenState extends State<PublishedItemsScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ["All (0)", "Cars (0)", "Parts (0)", "Accessories (0)"];

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Published Items", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87)),
                SizedBox(height: 4),
                Text("Manage Your Listings", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // الـ Tabs (All, Cars, etc..)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFFEEEEEE)),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
                    ),
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // حالة الـ Empty State
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: const Color(0xFFF8F9FA), shape: BoxShape.circle, border: Border.all(color: const Color(0xFFEEEEEE))),
                    child: const Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),
                  const Text("No listings yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black87)),
                  const SizedBox(height: 8),
                  const Text("You haven't published any listings yet", style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 32),

                  // زرار بريميوم للـ Start Selling
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
                      child: const Text("Start Selling", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
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