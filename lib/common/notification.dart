import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  /// 初始化
  static Future<void> initializeLocalNotifications() async {
    final awesomeNotifications = AwesomeNotifications();
    final channels = [
      NotificationChannel(
        channelKey: 'notification',
        channelName: '通知',
        channelDescription: 'Mood通知',
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: GroupAlertBehavior.Children,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Private,
      ),
    ];
    await awesomeNotifications.initialize('resource://drawable/app_icon', channels, debug: true);
  }

  // 重置小红点计数器
  static Future<void> resetBadgeCounter() async => AwesomeNotifications().resetGlobalBadge();

  /// 关闭并取消所有通知和计划
  static Future<void> cancelNotifications() async => AwesomeNotifications().cancelAll();
}
