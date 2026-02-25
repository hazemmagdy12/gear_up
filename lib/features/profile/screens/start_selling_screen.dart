import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء الذكاء الاصطناعي

class StartSellingScreen extends StatefulWidget {
  const StartSellingScreen({super.key});

  @override
  State<StartSellingScreen> createState() => _StartSellingScreenState();
}

class _StartSellingScreenState extends State<StartSellingScreen> {
  String _selectedItemType = "Car";
  String? _selectedTransmission;
  String? _selectedCondition;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Start Selling", style: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text("Choose item type and add details", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
            const SizedBox(height: 32),

            // 1. اختيار نوع الإعلان
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEEEEEE)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
                    child: Icon(
                      _selectedItemType == "Car" ? Icons.directions_car_outlined :
                      _selectedItemType == "Car Part" ? Icons.build_outlined : Icons.add_circle_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(_selectedItemType, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black87)),
                  const Spacer(),
                  TextButton(
                    onPressed: _showTypeSelectionSheet,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Change", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. قسم رفع الصور
            const Text("Photos", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 12),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE0E0E0), style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_a_photo_outlined, color: AppColors.textHint, size: 28),
                  SizedBox(height: 8),
                  Text("Add Photo", style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text("0/10 photos - Add clear photos from different angles", style: TextStyle(color: AppColors.textHint, fontSize: 12)),
            const SizedBox(height: 32),

            // 3. الحقول الأساسية المشتركة
            _buildTextField(label: "Title", hint: "Enter an attractive title"),
            _buildTextField(label: "Price (EGP)", hint: "Enter price", isNumber: true),

            // 4. الحقول المتغيرة
            if (_selectedItemType == "Car") ...[
              Row(
                children: [
                  Expanded(child: _buildTextField(label: "Company", hint: "e.g., BMW")),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(label: "Model", hint: "e.g., X5")),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _buildTextField(label: "Year", hint: "2024", isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(label: "Mileage", hint: "km", isNumber: true)),
                ],
              ),
              _buildDropdownField(
                label: "Transmission", hint: "Select type", value: _selectedTransmission, items: ["Automatic", "Manual"],
                onChanged: (val) => setState(() => _selectedTransmission = val),
              ),
            ] else ...[
              _buildTextField(label: "Part/Accessory Name", hint: "e.g., Ceramic Brake Pads"),
              _buildTextField(label: "Compatibility", hint: "e.g., BMW X5 2020-2024"),
              _buildDropdownField(
                label: "Condition", hint: "Select condition", value: _selectedCondition, items: ["New", "Used", "Refurbished"],
                onChanged: (val) => setState(() => _selectedCondition = val),
              ),
            ],

            // 5. الوصف
            _buildTextField(label: "Description", hint: "Add a detailed description...", maxLines: 4),
            const SizedBox(height: 24),

            // 6. زرار النشر الفخم المليان
            GestureDetector(
              onTap: () {
                // كود النشر
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Publish Listing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.5)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
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

  Widget _buildTextField({required String label, required String hint, bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA), // خلفية رمادي فاتح بريميوم
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: TextField(
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({required String label, required String hint, required String? value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(hint, style: const TextStyle(color: AppColors.textHint, fontSize: 14)),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTypeSelectionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Select Item Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black87)),
                const SizedBox(height: 24),
                _buildTypeOption("Car", Icons.directions_car_outlined),
                _buildTypeOption("Car Part", Icons.build_outlined),
                _buildTypeOption("Accessory", Icons.add_circle_outline),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypeOption(String title, IconData icon) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
      onTap: () {
        setState(() => _selectedItemType = title);
        Navigator.pop(context);
      },
    );
  }
}