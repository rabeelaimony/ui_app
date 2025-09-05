import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService extends ChangeNotifier {
  static AppService? _instance;
  static AppService get instance => _instance ??= AppService._();
  
  AppService._();

  // Theme Management
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  // Language Management
  Locale _locale = const Locale('ar', 'SA');
  Locale get locale => _locale;

  // User Management
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String _username = '';
  String get username => _username;

  // Account Data
  final UserAccount _userAccount = UserAccount();
  UserAccount get userAccount => _userAccount;

  // Notifications
  final List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;
  
  bool get hasUnreadNotifications => _notifications.any((n) => !n.isRead);
  int get unreadNotificationCount => _notifications.where((n) => !n.isRead).length;

  Future<void> initialize() async {
    await _loadTheme();
    await _loadLocale();
    await _loadUserState();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.name);
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  Future<void> login(String username, String password) async {
    // Simulate login - في التطبيق الحقيقي ستكون هناك API call
    if (username.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _username = username;
      
      // Load user data
      await _loadUserAccount(username);
      await _loadNotifications();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('username', username);
      
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _username = '';
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    await prefs.remove('username');
    
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme_mode') ?? 'system';
    _themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('locale') ?? 'ar';
    _locale = Locale(languageCode, languageCode == 'ar' ? 'SA' : 'US');
  }

  Future<void> _loadUserState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    _username = prefs.getString('username') ?? '';
    
    if (_isLoggedIn && _username.isNotEmpty) {
      await _loadUserAccount(_username);
    }
  }

  Future<void> _loadUserAccount(String username) async {
    // Simulate loading user data - في التطبيق الحقيقي ستكون هناك API call
    _userAccount.username = username;
    _userAccount.accountStatus = AccountStatus.active;
    _userAccount.subscriptionType = SubscriptionType.regular;
    _userAccount.daysRemaining = 25;
    _userAccount.speed = '100 Mbps';
    _userAccount.totalData = 500; // GB
    _userAccount.consumedData = 180; // GB
    _userAccount.hasAdditionalPackage = true;
    _userAccount.additionalData = 50; // GB
    _userAccount.consumedAdditional = 15; // GB
  }

  Future<void> _loadNotifications() async {
    // Simulate loading notifications - في التطبيق الحقيقي ستكون هناك API call
    _notifications.clear();
    _notifications.addAll([
      AppNotification(
        id: '1',
        type: NotificationType.accountActivity,
        title: 'تم شحن الحساب',
        message: 'تم شحن حسابك بنجاح لشهر إضافي',
        timestamp: '2024-12-15 14:30',
        isRead: false,
      ),
      AppNotification(
        id: '2',
        type: NotificationType.dataUsage,
        title: 'تحذير استهلاك البيانات',
        message: 'تم استهلاك 80% من باقة البيانات الأساسية',
        timestamp: '2024-12-14 10:15',
        isRead: false,
      ),
      AppNotification(
        id: '3',
        type: NotificationType.system,
        title: 'تحديث النظام',
        message: 'تم تطبيق تحديثات النظام بنجاح',
        timestamp: '2024-12-13 08:45',
        isRead: true,
      ),
      AppNotification(
        id: '4',
        type: NotificationType.payment,
        title: 'عملية دفع ناجحة',
        message: 'تم إضافة 20 GB إضافية لحسابك',
        timestamp: '2024-12-12 16:20',
        isRead: true,
      ),
    ]);
  }

  void markAllNotificationsAsRead() {
    for (final notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void markNotificationAsRead(String notificationId) {
    final notification = _notifications.firstWhere(
      (n) => n.id == notificationId,
      orElse: () => _notifications.first,
    );
    notification.isRead = true;
    notifyListeners();
  }
}

class UserAccount {
  String username = '';
  AccountStatus accountStatus = AccountStatus.active;
  SubscriptionType subscriptionType = SubscriptionType.regular;
  int daysRemaining = 0;
  String speed = '';
  double totalData = 0; // GB
  double consumedData = 0; // GB
  bool hasAdditionalPackage = false;
  double additionalData = 0; // GB
  double consumedAdditional = 0; // GB
  
  // معلومات إضافية
  double financialBalance = 15000; // SYP
  String mobileNumber = '0932123456';
  String province = 'دمشق';
  String district = 'أبو رمانة';
  String landlineNumber = '011-2234567';
  String registrationDate = '15/01/2020';
  String renewalDate = '15/12/2024';

  double get remainingData => totalData - consumedData;
  double get remainingAdditional => additionalData - consumedAdditional;
  double get dataUsagePercentage => consumedData / totalData;
  double get additionalUsagePercentage => 
      hasAdditionalPackage ? consumedAdditional / additionalData : 0.0;
}

enum AccountStatus {
  active,
  expired,
  suspended,
}

enum SubscriptionType {
  regular,
  syndicate,
}

extension AccountStatusExtension on AccountStatus {
  String get displayName {
    switch (this) {
      case AccountStatus.active:
        return 'نشط';
      case AccountStatus.expired:
        return 'منتهي الصلاحية';
      case AccountStatus.suspended:
        return 'معلق';
    }
  }

  String get displayNameEn {
    switch (this) {
      case AccountStatus.active:
        return 'Active';
      case AccountStatus.expired:
        return 'Expired';
      case AccountStatus.suspended:
        return 'Suspended';
    }
  }

  Color get color {
    switch (this) {
      case AccountStatus.active:
        return Colors.green;
      case AccountStatus.expired:
        return Colors.red;
      case AccountStatus.suspended:
        return Colors.orange;
    }
  }
}

extension SubscriptionTypeExtension on SubscriptionType {
  String get displayName {
    switch (this) {
      case SubscriptionType.regular:
        return 'عادي';
      case SubscriptionType.syndicate:
        return 'نقابي';
    }
  }

  String get displayNameEn {
    switch (this) {
      case SubscriptionType.regular:
        return 'Regular';
      case SubscriptionType.syndicate:
        return 'Syndicate';
    }
  }
}

// Notification Models
class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String timestamp;
  bool isRead;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

enum NotificationType {
  accountActivity,
  dataUsage,
  payment,
  system,
  maintenance,
}

extension NotificationTypeExtension on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.accountActivity:
        return Icons.account_circle;
      case NotificationType.dataUsage:
        return Icons.data_usage;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.system:
        return Icons.settings;
      case NotificationType.maintenance:
        return Icons.build;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.accountActivity:
        return Colors.blue;
      case NotificationType.dataUsage:
        return Colors.orange;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.system:
        return Colors.purple;
      case NotificationType.maintenance:
        return Colors.red;
    }
  }
}