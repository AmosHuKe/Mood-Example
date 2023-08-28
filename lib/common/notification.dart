import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  /// 初始化
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/app_icon',
      [
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
      ],
      debug: true,
    );
  }

  // 重置小红点计数器
  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  /// 关闭并取消所有通知和计划
  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
