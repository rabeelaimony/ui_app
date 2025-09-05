import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ];

  Map<String, String> get _localizedStrings {
    if (locale.languageCode == 'ar') {
      return _arabicStrings;
    }
    return _englishStrings;
  }

  String translate(String key) => _localizedStrings[key] ?? key;

  // Arabic strings
  static const Map<String, String> _arabicStrings = {
    'app_title': 'آية للإنترنت',
    'login': 'تسجيل الدخول',
    'username': 'اسم المستخدم',
    'password': 'كلمة المرور',
    'welcome': 'مرحباً بك',
    'account_status': 'حالة الحساب',
    'active': 'نشط',
    'expired': 'منتهي الصلاحية',
    'suspended': 'معلق',
    'subscription_type': 'نوع الاشتراك',
    'regular': 'عادي',
    'syndicate': 'نقابي',
    'days_remaining': 'الأيام المتبقية',
    'speed': 'السرعة',
    'data_usage': 'استهلاك البيانات',
    'remaining': 'المتبقي',
    'consumed': 'المستهلك',
    'additional_package': 'الباقة الإضافية',
    'control_panel': 'لوحة التحكم',
    'settings': 'الإعدادات',
    'notifications': 'الإشعارات',
    'language': 'اللغة',
    'theme': 'المظهر',
    'dark_mode': 'الوضع المظلم',
    'light_mode': 'الوضع المضيء',
    'change_password': 'تغيير كلمة المرور',
    'change_mobile': 'تغيير رقم الموبايل',
    'invoice_history': 'تاريخ الفواتير',
    'payment_history': 'تاريخ الدفعات',
    'technical_support': 'الدعم الفني',
    'speed_test': 'اختبار السرعة',
    'account_info': 'معلومات الحساب',
    'service_requests': 'طلبات الخدمة',
    'offers_packages': 'العروض والباقات',
  };

  // English strings
  static const Map<String, String> _englishStrings = {
    'app_title': 'Aya Internet',
    'login': 'Login',
    'username': 'Username',
    'password': 'Password',
    'welcome': 'Welcome',
    'account_status': 'Account Status',
    'active': 'Active',
    'expired': 'Expired',
    'suspended': 'Suspended',
    'subscription_type': 'Subscription Type',
    'regular': 'Regular',
    'syndicate': 'Syndicate',
    'days_remaining': 'Days Remaining',
    'speed': 'Speed',
    'data_usage': 'Data Usage',
    'remaining': 'Remaining',
    'consumed': 'Consumed',
    'additional_package': 'Additional Package',
    'control_panel': 'Control Panel',
    'settings': 'Settings',
    'notifications': 'Notifications',
    'language': 'Language',
    'theme': 'Theme',
    'dark_mode': 'Dark Mode',
    'light_mode': 'Light Mode',
    'change_password': 'Change Password',
    'change_mobile': 'Change Mobile Number',
    'invoice_history': 'Invoice History',
    'payment_history': 'Payment History',
    'technical_support': 'Technical Support',
    'speed_test': 'Speed Test',
    'account_info': 'Account Information',
    'service_requests': 'Service Requests',
    'offers_packages': 'Offers & Packages',
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .map((e) => e.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class LocalizationService {
  static LocalizationService? _instance;
  static LocalizationService get instance => _instance ??= LocalizationService._();
  
  LocalizationService._();

  Locale _locale = const Locale('ar', 'SA');
  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('locale') ?? 'ar';
    _locale = Locale(languageCode, languageCode == 'ar' ? 'SA' : 'US');
  }
}