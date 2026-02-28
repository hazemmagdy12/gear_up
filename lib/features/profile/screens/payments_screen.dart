import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/localization/app_lang.dart'; // استدعاء القاموس
import '../../home/widgets/ai_chat_bottom_sheet.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                Text(AppLang.tr(context, 'payments'), style: const TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(AppLang.tr(context, 'manage_payments'), style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
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
                            AppLang.tr(context, 'payment_methods'),
                            style: TextStyle(
                              color: _selectedTab == 0 ? Colors.white : (isDark ? Colors.white70 : AppColors.textSecondary),
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
                            AppLang.tr(context, 'history'),
                            style: TextStyle(
                              color: _selectedTab == 1 ? Colors.white : (isDark ? Colors.white70 : AppColors.textSecondary),
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
            child: _selectedTab == 0 ? _buildPaymentMethodsView(isDark) : _buildHistoryView(isDark),
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

  Widget _buildPaymentMethodsView(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        _buildSavedMethodCard(icon: Icons.credit_card, iconColor: Colors.blue, title: "•••• 4242", subtitle: "Ahmed Mohamed\nExpires 12/26", isDefault: true, isDark: isDark),
        _buildSavedMethodCard(icon: Icons.account_balance_wallet_outlined, iconColor: Colors.purple, title: "InstaPay", subtitle: "Ahmed Mohamed\n01012345678", isDark: isDark),
        _buildSavedMethodCard(icon: Icons.phone_android, iconColor: Colors.red, title: "Vodafone Cash", subtitle: "Ahmed Mohamed\n01098765432", isDark: isDark),

        const SizedBox(height: 8),

        if (_addingMethodType == null)
          GestureDetector(
            onTap: () => _showAddPaymentOptions(isDark),
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
                  Text(AppLang.tr(context, 'add_payment_method'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                ],
              ),
            ),
          )
        else
          _buildAddMethodForm(isDark),

        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSavedMethodCard({required IconData icon, required Color iconColor, required String title, required String subtitle, bool isDefault = false, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.02), blurRadius: 8, offset: const Offset(0, 4))],
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
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black87)),
                    if (isDefault) ...[
                      const SizedBox(width: 8),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(AppLang.tr(context, 'default_method'), style: const TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold))),
                    ]
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: isDark ? Colors.white70 : AppColors.textSecondary, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: isDark ? Colors.white70 : AppColors.textSecondary),
        ],
      ),
    );
  }

  void _showAddPaymentOptions(bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLang.tr(context, 'select_payment_method'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 24),
                _buildTypeOption(AppLang.tr(context, 'credit_debit_card'), Icons.credit_card, "Card", isDark),
                _buildTypeOption("InstaPay", Icons.account_balance_wallet_outlined, "InstaPay", isDark), // أسم برند مبيترجمش
                _buildTypeOption("Vodafone Cash", Icons.phone_android, "VodafoneCash", isDark),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile _buildTypeOption(String title, IconData icon, String type, bool isDark) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
      onTap: () {
        Navigator.pop(context);
        setState(() => _addingMethodType = type);
      },
    );
  }

  Widget _buildAddMethodForm(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_addingMethodType == 'Card' ? AppLang.tr(context, 'add_card') : _addingMethodType == 'InstaPay' ? AppLang.tr(context, 'add_instapay') : AppLang.tr(context, 'add_vodafone_cash'), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 20),
          if (_addingMethodType == 'Card') ...[
            _buildTextField(label: AppLang.tr(context, 'card_number'), hint: "1234 5678 9012 3456", isDark: isDark),
            _buildTextField(label: AppLang.tr(context, 'cardholder_name'), hint: "Name as on card", isDark: isDark),
            Row(children: [Expanded(child: _buildTextField(label: AppLang.tr(context, 'expiry_date'), hint: "MM/YY", isDark: isDark)), const SizedBox(width: 16), Expanded(child: _buildTextField(label: AppLang.tr(context, 'cvv'), hint: "123", isDark: isDark))]),
          ] else ...[
            _buildTextField(label: AppLang.tr(context, 'phone_number'), hint: "01012345678", isDark: isDark),
            _buildTextField(label: AppLang.tr(context, 'name'), hint: "Full Name", isDark: isDark),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: () => setState(() => _addingMethodType = null), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text(AppLang.tr(context, 'add'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton(onPressed: () => setState(() => _addingMethodType = null), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.border)), child: Text(AppLang.tr(context, 'cancel'), style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, required bool isDark}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isDark ? Colors.white : Colors.black87)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE))),
            child: TextField(style: TextStyle(color: isDark ? Colors.white : Colors.black87), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14))),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryView(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        _buildTransactionCard(title: "BMW X5 2023 - Listing Fee", date: "January 20, 2025", amount: "-50 EGP", status: AppLang.tr(context, 'completed'), isPositive: false, isDark: isDark),
        _buildTransactionCard(title: "Featured Listing - 7 days", date: "January 18, 2025", amount: "-100 EGP", status: AppLang.tr(context, 'completed'), isPositive: false, isDark: isDark),
        _buildTransactionCard(title: "Ceramic Brake Pads - Listing Fee", date: "January 15, 2025", amount: "-50 EGP", status: AppLang.tr(context, 'pending'), isPositive: false, isDark: isDark),
        _buildTransactionCard(title: "Cancelled Listing Refund", date: "January 10, 2025", amount: "+50 EGP", status: AppLang.tr(context, 'completed'), isPositive: true, isDark: isDark),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTransactionCard({required String title, required String date, required String amount, required String status, required bool isPositive, required bool isDark}) {
    bool isCompleted = status == AppLang.tr(context, 'completed');
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: isDark ? AppColors.surfaceDark : Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isDark ? AppColors.borderDark : const Color(0xFFEEEEEE)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.01), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: TextStyle(fontSize: 14, color: isDark ? Colors.white : Colors.black87))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: isCompleted ? const Color(0xFFE8F5E9).withOpacity(isDark ? 0.1 : 1) : const Color(0xFFFFF3E0).withOpacity(isDark ? 0.1 : 1), borderRadius: BorderRadius.circular(12), border: Border.all(color: isCompleted ? const Color(0xFFC8E6C9).withOpacity(isDark ? 0.2 : 1) : const Color(0xFFFFE0B2).withOpacity(isDark ? 0.2 : 1))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(isCompleted ? Icons.check_circle_outline : Icons.schedule, color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFF57C00), size: 12),
                    const SizedBox(width: 4),
                    Text(status, style: TextStyle(color: isCompleted ? const Color(0xFF4CAF50) : const Color(0xFFF57C00), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
          const SizedBox(height: 12),
          Text(amount, style: TextStyle(color: isPositive ? const Color(0xFF4CAF50) : AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}