import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../home/widgets/ai_chat_bottom_sheet.dart'; // استدعاء الذكاء الاصطناعي

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int _selectedTab = 0;
  String? _addingMethodType;

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
                Text("Payments", style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Manage Payments", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedTab = 0;
                        _addingMethodType = null;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Payment Methods",
                            style: TextStyle(
                              color: _selectedTab == 0 ? Colors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedTab = 1;
                        _addingMethodType = null;
                      }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1 ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "History",
                            style: TextStyle(
                              color: _selectedTab == 1 ? Colors.white : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Expanded(
            child: _selectedTab == 0 ? _buildPaymentMethodsView() : _buildHistoryView(),
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

  Widget _buildPaymentMethodsView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        _buildSavedMethodCard(icon: Icons.credit_card, iconColor: Colors.blue, title: "•••• 4242", subtitle: "Ahmed Mohamed\nExpires 12/26", isDefault: true),
        _buildSavedMethodCard(icon: Icons.account_balance_wallet_outlined, iconColor: Colors.purple, title: "InstaPay", subtitle: "Ahmed Mohamed\n01012345678"),
        _buildSavedMethodCard(icon: Icons.phone_android, iconColor: Colors.red, title: "Vodafone Cash", subtitle: "Ahmed Mohamed\n01098765432"),

        const SizedBox(height: 8),

        // التعديل: زرار فخم لإضافة وسيلة دفع
        if (_addingMethodType == null)
          GestureDetector(
            onTap: _showAddPaymentOptions,
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text("Add Payment Method", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                ],
              ),
            ),
          )
        else
          _buildAddMethodForm(),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSavedMethodCard({required IconData icon, required Color iconColor, required String title, required String subtitle, bool isDefault = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle), child: Icon(icon, color: Colors.white, size: 20)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Text("Default", style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold))),
                    ]
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  void _showAddPaymentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Select Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                _buildTypeOption("Credit / Debit Card", Icons.credit_card, "Card"),
                _buildTypeOption("InstaPay", Icons.account_balance_wallet_outlined, "InstaPay"),
                _buildTypeOption("Vodafone Cash", Icons.phone_android, "VodafoneCash"),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile _buildTypeOption(String title, IconData icon, String type) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: () {
        Navigator.pop(context);
        setState(() => _addingMethodType = type);
      },
    );
  }

  Widget _buildAddMethodForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_addingMethodType == 'Card' ? "Add Card" : _addingMethodType == 'InstaPay' ? "Add InstaPay" : "Add Vodafone Cash", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          if (_addingMethodType == 'Card') ...[
            _buildTextField(label: "Card Number", hint: "1234 5678 9012 3456"),
            _buildTextField(label: "Cardholder Name", hint: "Name as on card"),
            Row(children: [Expanded(child: _buildTextField(label: "Expiry Date", hint: "MM/YY")), const SizedBox(width: 16), Expanded(child: _buildTextField(label: "CVV", hint: "123"))]),
          ] else ...[
            _buildTextField(label: "Phone Number", hint: "01012345678"),
            _buildTextField(label: "Name", hint: "Full Name"),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => setState(() => _addingMethodType = null), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton(onPressed: () => setState(() => _addingMethodType = null), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), side: const BorderSide(color: AppColors.border)), child: const Text("Cancel", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEEEEEE))),
            child: TextField(decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14))),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        _buildTransactionCard(title: "BMW X5 2023 - Listing Fee", date: "January 20, 2025", amount: "-50 EGP", status: "Completed", isPositive: false),
        _buildTransactionCard(title: "Featured Listing - 7 days", date: "January 18, 2025", amount: "-100 EGP", status: "Completed", isPositive: false),
        _buildTransactionCard(title: "Ceramic Brake Pads - Listing Fee", date: "January 15, 2025", amount: "-50 EGP", status: "Pending", isPositive: false),
        _buildTransactionCard(title: "Cancelled Listing Refund", date: "January 10, 2025", amount: "+50 EGP", status: "Completed", isPositive: true),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTransactionCard({required String title, required String date, required String amount, required String status, required bool isPositive}) {
    bool isCompleted = status == "Completed";
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFEEEEEE)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: isCompleted ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(12), border: Border.all(color: isCompleted ? const Color(0xFFC8E6C9) : const Color(0xFFFFE0B2))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isCompleted ? Icons.check_circle_outline : Icons.schedule, color: isCompleted ? const Color(0xFF2E7D32) : const Color(0xFFF57C00), size: 12),
                    const SizedBox(width: 4),
                    Text(status, style: TextStyle(color: isCompleted ? const Color(0xFF2E7D32) : const Color(0xFFF57C00), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          const SizedBox(height: 12),
          Text(amount, style: TextStyle(color: isPositive ? const Color(0xFF2E7D32) : AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}