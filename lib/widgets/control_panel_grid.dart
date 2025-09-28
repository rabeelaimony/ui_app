import 'package:flutter/material.dart';

import 'package:ui_app/screens/settings_screen.dart';
import 'package:ui_app/services/app_service.dart';

class ControlPanelGrid extends StatelessWidget {
  final bool isArabic;

  const ControlPanelGrid({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final neonGreen = const Color(0xFF32FF7E);

    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.85,
      children: [
        _buildControlItem(
          context: context,
          icon: Icons.swap_horiz,
          title: isArabic ? 'بيانات الاستهلاك' : 'Usage Data',
          color: neonGreen,
          onTap: () => _showAccountData(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.bar_chart,
          title: isArabic ? 'بيانات الدخول' : 'Login Data',
          color: neonGreen,
          onTap: () => _showLoginData(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.receipt_outlined,
          title: isArabic ? 'البيان المالي' : 'Financial Statement',
          color: neonGreen,
          onTap: () => _showFinancialStatement(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.credit_card_outlined,
          title: isArabic ? 'شحن الحساب' : 'Recharge Account',
          color: neonGreen,
          onTap: () => _showRechargeAccount(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.refresh,
          title: isArabic ? 'تغيير نوع الحساب' : 'Change Account Type',
          color: neonGreen,
          onTap: () => _showChangeAccountType(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.push_pin,
          title: isArabic ? 'Static IP' : 'Static IP',
          color: neonGreen,
          onTap: () => _showStaticIP(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.lock_outline,
          title: isArabic ? 'تغيير كلمة السر' : 'Change Password',
          color: neonGreen,
          onTap: () => _showChangePassword(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.speed,
          title: isArabic ? 'تحويل السرعة' : 'Speed Conversion',
          color: neonGreen,
          onTap: () => _showSpeedAdjustment(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.error_outline,
          title: isArabic ? 'تجميد الحساب' : 'Freeze Account',
          color: neonGreen,
          onTap: () => _showSuspendAccount(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.north_east,
          title: isArabic ? 'شحن ترافيك إضافي' : 'Additional Traffic',
          color: neonGreen,
          onTap: () => _showTrafficTopup(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.add_box_outlined,
          title: isArabic ? 'تمديد ترافيك' : 'Extend Traffic',
          color: neonGreen,
          onTap: () => _showExtendTraffic(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.auto_fix_high,
          title: isArabic ? 'تمديد المالية' : 'Financial Extension',
          color: neonGreen,
          onTap: () => _showExtendFinancial(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.power_settings_new,
          title: isArabic ? 'إيقاف البوابة' : 'Gateway Off',
          color: neonGreen,
          onTap: () => _showDeactivateAccount(context),
        ),
        _buildControlItem(
          context: context,
          icon: Icons.tv_outlined,
          title: isArabic ? 'IPTV' : 'IPTV',
          color: neonGreen,
          onTap: () => _showIPTV(context),
        ),
      ],
    );
  }

  Widget _buildControlItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isDark
              ? Border.all(color: color.withValues(alpha: 0.3), width: 1)
              : null,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void _showAccountData(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'بيانات الحساب' : 'Account Data',
      content: isArabic
          ? 'عرض معلومات مفصلة عن حسابك ونشاطاتك'
          : 'View detailed information about your account and activities',
    );
  }

  void _showLoginData(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'بيانات الدخول' : 'Login Data',
      content: isArabic
          ? 'عرض سجل تسجيل الدخول وإحصائيات الاستخدام'
          : 'View login history and usage statistics',
    );
  }

  void _showFinancialStatement(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'البيان المالي' : 'Financial Statement',
      content: isArabic
          ? 'عرض تفصيلي للمعاملات المالية والفواتير'
          : 'Detailed view of financial transactions and bills',
    );
  }

  void _showRechargeAccount(BuildContext context) {
    final isArabic = this.isArabic;

    showDialog(
      context: context,
      builder: (context) => RechargeAccountDialog(isArabic: isArabic),
    );
  }

  void _showChangeAccountType(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'تغيير نوع الحساب' : 'Change Account Type',
      content: isArabic
          ? 'تغيير نوع حسابك (مفوتر، مدفوع مسبقاً، إلخ)'
          : 'Change your account type (postpaid, prepaid, etc)',
    );
  }

  void _showStaticIP(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'Static IP' : 'Static IP',
      content: isArabic
          ? 'إدارة عنوان IP الثابت الخاص بك'
          : 'Manage your static IP address',
    );
  }

  void _showSpeedAdjustment(BuildContext context) {
    final isArabic = this.isArabic;

    showDialog(
      context: context,
      builder: (context) => SpeedAdjustmentDialog(isArabic: isArabic),
    );
  }

  void _showSuspendAccount(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'تجميد الحساب' : 'Suspend Account',
      content: isArabic
          ? 'تجميد حسابك مؤقتاً للحفاظ على الرصيد'
          : 'Temporarily suspend your account to preserve balance',
    );
  }

  void _showChangePassword(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'تغيير كلمة السر' : 'Change Password',
      content: isArabic
          ? 'تغيير كلمة مرور حسابك لضمان الأمان'
          : 'Change your account password for security',
    );
  }

  void _showExtendFinancial(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'تمديد المالية' : 'Financial Extension',
      content: isArabic
          ? 'تمديد الرصيد المالي وإضافة مبالغ إضافية'
          : 'Extend financial balance and add additional amounts',
    );
  }

  void _showTrafficTopup(BuildContext context) {
    final isArabic = this.isArabic;

    showDialog(
      context: context,
      builder: (context) => TrafficTopupDialog(isArabic: isArabic),
    );
  }

  void _showExtendTraffic(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'تمديد ترافيك' : 'Extend Traffic',
      content: isArabic
          ? 'تمديد باقة البيانات الحالية'
          : 'Extend your current data package',
    );
  }

  void _showDeactivateAccount(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'إيقاف الحساب' : 'Deactivate Account',
      content: isArabic
          ? 'إيقاف حسابك بشكل دائم'
          : 'Permanently deactivate your account',
    );
  }

  void _showIPTV(BuildContext context) {
    _showFeatureDialog(
      context,
      title: isArabic ? 'IPTV' : 'IPTV',
      content: isArabic
          ? 'إدارة خدمة التلفزيون عبر الإنترنت'
          : 'Manage your Internet TV service',
    );
  }

  void _showFeatureDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isArabic ? 'موافق' : 'OK'),
          ),
        ],
      ),
    );
  }
}

// Traffic Top-up Dialog
class TrafficTopupDialog extends StatefulWidget {
  final bool isArabic;

  const TrafficTopupDialog({super.key, required this.isArabic});

  @override
  State<TrafficTopupDialog> createState() => _TrafficTopupDialogState();
}

class _TrafficTopupDialogState extends State<TrafficTopupDialog> {
  final AppService _appService = AppService.instance;
  int selectedPackageIndex = -1;

  final List<TrafficPackage> packages = [
    TrafficPackage(size: 10, price: 5000),
    TrafficPackage(size: 25, price: 10000),
    TrafficPackage(size: 50, price: 18000),
    TrafficPackage(size: 100, price: 32000),
  ];

  @override
  Widget build(BuildContext context) {
    final account = _appService.userAccount;
    final hasEnoughBalance = selectedPackageIndex >= 0
        ? account.financialBalance >= packages[selectedPackageIndex].price
        : false;

    return AlertDialog(
      title: Text(widget.isArabic ? 'شحن ترافيك إضافي' : 'Traffic Top-up'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.isArabic ? "الرصيد المالي" : "Balance"}: ${account.financialBalance.toInt()} ل.س',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.isArabic ? 'اختر الباقة:' : 'Select Package:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...packages.asMap().entries.map((entry) {
              final index = entry.key;
              final package = entry.value;
              final isSelected = selectedPackageIndex == index;
              final canAfford = account.financialBalance >= package.price;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: canAfford
                      ? () => setState(() => selectedPackageIndex = index)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green[50]
                          : (canAfford ? Colors.white : Colors.grey[100]),
                      border: Border.all(
                        color: isSelected
                            ? Colors.green
                            : (canAfford
                                  ? Colors.grey[300]!
                                  : Colors.grey[400]!),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${package.size} GB',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: canAfford ? Colors.black : Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${package.price} ل.س',
                          style: TextStyle(
                            color: canAfford ? Colors.green[700] : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.isArabic ? 'إلغاء' : 'Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedPackageIndex >= 0 && hasEnoughBalance
              ? () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.isArabic
                            ? 'تم شحن ${packages[selectedPackageIndex].size} GB بنجاح'
                            : '${packages[selectedPackageIndex].size} GB recharged successfully',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: hasEnoughBalance ? Colors.green : Colors.grey,
          ),
          child: Text(
            widget.isArabic ? 'شحن' : 'Recharge',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Speed Adjustment Dialog
class SpeedAdjustmentDialog extends StatefulWidget {
  final bool isArabic;

  const SpeedAdjustmentDialog({super.key, required this.isArabic});

  @override
  State<SpeedAdjustmentDialog> createState() => _SpeedAdjustmentDialogState();
}

class _SpeedAdjustmentDialogState extends State<SpeedAdjustmentDialog> {
  final AppService _appService = AppService.instance;
  String selectedAction = '';

  final List<String> speedOptions = [
    '50 Mbps',
    '100 Mbps',
    '200 Mbps',
    '500 Mbps',
  ];
  final int decreaseCost = 8000;
  final int increaseCost = 6000;

  @override
  Widget build(BuildContext context) {
    final account = _appService.userAccount;
    final currentSpeedIndex = speedOptions.indexOf(account.speed);

    return AlertDialog(
      title: Text(widget.isArabic ? 'تعديل السرعة' : 'Speed Adjustment'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.isArabic ? "الرصيد المالي" : "Balance"}: ${account.financialBalance.toInt()} ل.س',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.isArabic ? "السرعة الحالية" : "Current Speed"}: ${account.speed}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              '${widget.isArabic ? "كلفة التخفيض" : "Decrease Cost"}: $decreaseCost ل.س',
              style: const TextStyle(color: Colors.orange),
            ),
            Text(
              '${widget.isArabic ? "كلفة الرفع" : "Increase Cost"}: $increaseCost ل.س',
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              widget.isArabic ? 'السرعات المتاحة:' : 'Available Speeds:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...speedOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final speed = entry.value;
              final isCurrent = index == currentSpeedIndex;
              final isIncrease = index > currentSpeedIndex;
              final cost = isIncrease ? increaseCost : decreaseCost;
              final canAfford = account.financialBalance >= cost;

              if (isCurrent) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        speed,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.isArabic ? 'حالي' : 'Current',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: canAfford
                      ? () {
                          setState(() {
                            selectedAction =
                                '${speed}_${isIncrease ? 'increase' : 'decrease'}';
                          });
                        }
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedAction.startsWith(speed)
                          ? Colors.green[50]
                          : (canAfford ? Colors.white : Colors.grey[100]),
                      border: Border.all(
                        color: selectedAction.startsWith(speed)
                            ? Colors.green
                            : (canAfford
                                  ? Colors.grey[300]!
                                  : Colors.grey[400]!),
                        width: selectedAction.startsWith(speed) ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          speed,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: canAfford ? Colors.black : Colors.grey[600],
                          ),
                        ),
                        Text(
                          '$cost ل.س',
                          style: TextStyle(
                            color: canAfford
                                ? (isIncrease
                                      ? Colors.green[700]
                                      : Colors.orange[700])
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.isArabic ? 'إلغاء' : 'Cancel'),
        ),
        ElevatedButton(
          onPressed: selectedAction.isNotEmpty
              ? () {
                  final speed = selectedAction.split('_')[0];
                  final action = selectedAction.split('_')[1];
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.isArabic
                            ? 'تم تعديل السرعة إلى $speed بنجاح'
                            : 'Speed adjusted to $speed successfully',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedAction.isNotEmpty
                ? Colors.green
                : Colors.grey,
          ),
          child: Text(
            widget.isArabic ? 'تعديل' : 'Adjust',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Recharge Account Dialog
class RechargeAccountDialog extends StatefulWidget {
  final bool isArabic;

  const RechargeAccountDialog({super.key, required this.isArabic});

  @override
  State<RechargeAccountDialog> createState() => _RechargeAccountDialogState();
}

class _RechargeAccountDialogState extends State<RechargeAccountDialog> {
  final AppService _appService = AppService.instance;
  int selectedMonths = 1;

  final List<int> monthOptions = [1, 2, 3, 4, 5, 6];
  final double monthlyPrice = 15000; // Fixed monthly price

  @override
  Widget build(BuildContext context) {
    final account = _appService.userAccount;
    final totalPrice = selectedMonths * monthlyPrice;
    final hasEnoughBalance = account.financialBalance >= totalPrice;

    return AlertDialog(
      title: Text(widget.isArabic ? 'شحن الحساب' : 'Recharge Account'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.isArabic ? "الرصيد المالي" : "Balance"}: ${account.financialBalance.toInt()} ل.س',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.isArabic ? "السعر الشهري" : "Monthly Price"}: ${monthlyPrice.toInt()} ل.س',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              widget.isArabic ? 'عدد الأشهر:' : 'Number of Months:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...monthOptions.map((months) {
              final isSelected = selectedMonths == months;
              final price = months * monthlyPrice;
              final canAfford = account.financialBalance >= price;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: canAfford
                      ? () => setState(() => selectedMonths = months)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green[50]
                          : (canAfford ? Colors.white : Colors.grey[100]),
                      border: Border.all(
                        color: isSelected
                            ? Colors.green
                            : (canAfford
                                  ? Colors.grey[300]!
                                  : Colors.grey[400]!),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${months} ${widget.isArabic ? (months == 1 ? "شهر" : "أشهر") : (months == 1 ? "Month" : "Months")}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: canAfford ? Colors.black : Colors.grey[600],
                          ),
                        ),
                        Text(
                          '${price.toInt()} ل.س',
                          style: TextStyle(
                            color: canAfford ? Colors.green[700] : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hasEnoughBalance ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${widget.isArabic ? "المجموع" : "Total"}: ${totalPrice.toInt()} ل.س',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: hasEnoughBalance ? Colors.green[700] : Colors.red[700],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.isArabic ? 'إلغاء' : 'Cancel'),
        ),
        ElevatedButton(
          onPressed: hasEnoughBalance
              ? () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.isArabic
                            ? 'تم شحن الحساب لـ $selectedMonths ${selectedMonths == 1 ? "شهر" : "أشهر"} بنجاح'
                            : 'Account recharged for $selectedMonths ${selectedMonths == 1 ? "month" : "months"} successfully',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: hasEnoughBalance ? Colors.green : Colors.grey,
          ),
          child: Text(
            widget.isArabic ? 'شحن' : 'Recharge',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class TrafficPackage {
  final int size;
  final int price;

  TrafficPackage({required this.size, required this.price});
}
