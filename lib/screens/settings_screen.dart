import 'package:flutter/material.dart';
import 'package:ui_app/services/app_service.dart';
import 'package:ui_app/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AppService _appService = AppService.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = _appService.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'الإعدادات' : 'Settings'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Section
            _buildSettingsSection(
              title: isArabic ? 'اللغة' : 'Language',
              children: [_buildLanguageTile()],
            ),

            const SizedBox(height: 24),

            // Account Section
            _buildSettingsSection(
              title: isArabic ? 'الحساب' : 'Account',
              children: [
                _buildSettingsTile(
                  icon: Icons.lock_outline,
                  title: isArabic ? 'تغيير كلمة المرور' : 'Change Password',
                  onTap: _showChangePasswordDialog,
                ),
                _buildSettingsTile(
                  icon: Icons.phone_outlined,
                  title: isArabic
                      ? 'تغيير رقم الموبايل'
                      : 'Change Mobile Number',
                  onTap: _showChangeMobileDialog,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Support Section
            _buildSettingsSection(
              title: isArabic ? 'الدعم' : 'Support',
              children: [
                _buildSettingsTile(
                  icon: Icons.help_outline,
                  title: isArabic ? 'المساعدة' : 'Help',
                  onTap: () {
                    // Implement help
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.contact_support_outlined,
                  title: isArabic ? 'اتصل بنا' : 'Contact Us',
                  onTap: () {
                    // Implement contact
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: isArabic ? 'حول التطبيق' : 'About App',
                  onTap: _showAboutDialog,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Logout Section
            _buildSettingsSection(
              title: isArabic ? 'الحساب' : 'Account',
              children: [
                _buildSettingsTile(
                  icon: Icons.logout,
                  title: isArabic ? 'تسجيل الخروج' : 'Logout',
                  textColor: Colors.red,
                  iconColor: Colors.red,
                  onTap: _logout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLanguageTile() {
    final isArabic = _appService.locale.languageCode == 'ar';

    return ListenableBuilder(
      listenable: _appService,
      builder: (context, _) {
        return ListTile(
          leading: const Icon(Icons.language),
          title: Text(isArabic ? 'اللغة' : 'Language'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isArabic ? 'العربية' : 'English',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: _showLanguageDialog,
        );
      },
    );
  }

  Widget _buildThemeTile() {
    final isArabic = _appService.locale.languageCode == 'ar';

    return ListenableBuilder(
      listenable: _appService,
      builder: (context, _) {
        String themeName;
        if (isArabic) {
          switch (_appService.themeMode) {
            case ThemeMode.light:
              themeName = 'فاتح';
              break;
            case ThemeMode.dark:
              themeName = 'مظلم';
              break;
            case ThemeMode.system:
              themeName = 'النظام';
              break;
          }
        } else {
          switch (_appService.themeMode) {
            case ThemeMode.light:
              themeName = 'Light';
              break;
            case ThemeMode.dark:
              themeName = 'Dark';
              break;
            case ThemeMode.system:
              themeName = 'System';
              break;
          }
        }

        return ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: Text(isArabic ? 'المظهر' : 'Theme'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                themeName,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
          onTap: _showThemeDialog,
        );
      },
    );
  }

  void _showLanguageDialog() {
    final isArabic = _appService.locale.languageCode == 'ar';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'اختيار اللغة' : 'Choose Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('العربية'),
              onTap: () {
                _appService.setLocale(const Locale('ar', 'SA'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('English'),
              onTap: () {
                _appService.setLocale(const Locale('en', 'US'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    final isArabic = _appService.locale.languageCode == 'ar';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'اختيار المظهر' : 'Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(isArabic ? 'فاتح' : 'Light'),
              onTap: () {
                _appService.setThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(isArabic ? 'مظلم' : 'Dark'),
              onTap: () {
                _appService.setThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_system_daydream),
              title: Text(isArabic ? 'النظام' : 'System'),
              onTap: () {
                _appService.setThemeMode(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    final isArabic = _appService.locale.languageCode == 'ar';
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'تغيير كلمة المرور' : 'Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isArabic
                    ? 'كلمة المرور الحالية'
                    : 'Current Password',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isArabic ? 'كلمة المرور الجديدة' : 'New Password',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isArabic ? 'إلغاء' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement password change
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isArabic
                        ? 'تم تغيير كلمة المرور بنجاح'
                        : 'Password changed successfully',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(isArabic ? 'تغيير' : 'Change'),
          ),
        ],
      ),
    );
  }

  void _showChangeMobileDialog() {
    final isArabic = _appService.locale.languageCode == 'ar';
    final mobileController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'تغيير رقم الموبايل' : 'Change Mobile Number'),
        content: TextField(
          controller: mobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: isArabic ? 'رقم الموبايل الجديد' : 'New Mobile Number',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isArabic ? 'إلغاء' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement mobile change
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isArabic
                        ? 'تم تغيير رقم الموبايل بنجاح'
                        : 'Mobile number changed successfully',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(isArabic ? 'تغيير' : 'Change'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    final isArabic = _appService.locale.languageCode == 'ar';

    showAboutDialog(
      context: context,
      applicationName: isArabic ? 'آية للإنترنت' : 'Aya Internet',
      applicationVersion: '1.0.0',
      applicationLegalese: isArabic
          ? '© 2024 شركة آية لخدمات الإنترنت'
          : '© 2024 Aya Internet Services',
      children: [
        Text(
          isArabic
              ? 'تطبيق آية للإنترنت يوفر لك إدارة شاملة لحسابك وخدماتك'
              : 'Aya Internet app provides comprehensive management of your account and services',
        ),
      ],
    );
  }

  void _logout() async {
    final isArabic = _appService.locale.languageCode == 'ar';

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
        content: Text(
          isArabic
              ? 'هل أنت متأكد من تسجيل الخروج؟'
              : 'Are you sure you want to logout?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(isArabic ? 'إلغاء' : 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(isArabic ? 'تسجيل الخروج' : 'Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _appService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }
}
