import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../themes/app_theme.dart';

/// 通知相关
class NotificationViewModel extends ChangeNotifier {
  NotificationViewModel({required AwesomeNotifications awesomeNotifications})
    : _awesomeNotifications = awesomeNotifications {
    init();
  }

  final AwesomeNotifications _awesomeNotifications;

  /// 通知测试
  Future<void> sendTest(BuildContext context) async {
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (isAllowed) {
      await cancelNotificationAll();
      await sendNotification(context);
      await sendScheduleNotification(context);
    }
  }

  /// 通知初始化
  Future<void> init() async {
    final channels = <NotificationChannel>[
      .new(
        channelKey: 'notification',
        channelName: '通知',
        channelDescription: 'Mood 通知',
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: .Children,
        importance: .High,
        defaultPrivacy: .Private,
      ),
    ];
    await _awesomeNotifications.initialize('resource://drawable/app_icon', channels, debug: true);
  }

  /// 关闭并取消所有通知和计划
  Future<void> cancelNotificationAll() async => _awesomeNotifications.cancelAll();

  /// 重置小红点计数器
  Future<void> resetBadgeCounter() async => _awesomeNotifications.resetGlobalBadge();

  /// 通知权限判断显示
  Future<void> allowedNotification(BuildContext context) async {
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) {
      WidgetsBinding.instance.endOfFrame.then((_) async {
        if (context.mounted) {
          await _showNotificationRationale(context);
        }
      });
    }
  }

  /// 发送普通通知
  Future<void> sendNotification(BuildContext context) async {
    final appL10n = AppL10n.of(context);
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) return;

    await _awesomeNotifications.createNotification(
      content: .new(
        id: 1,
        channelKey: 'notification',
        title: appL10n.local_notification_welcome_title,
        body: appL10n.local_notification_welcome_body,
        actionType: .Default,
        category: .Event,
      ),
    );
  }

  /// 发送定时计划通知
  Future<void> sendScheduleNotification(BuildContext context) async {
    final appL10n = AppL10n.of(context);
    final localTimeZone = await _awesomeNotifications.getLocalTimeZoneIdentifier();
    final isAllowed = await _awesomeNotifications.isNotificationAllowed();
    if (!isAllowed) return;

    await _awesomeNotifications.createNotification(
      content: .new(
        id: -1, // 随机ID
        channelKey: 'notification',
        title: appL10n.local_notification_schedule_title,
        body: appL10n.local_notification_schedule_body,
        actionType: .Default,
        category: .Event,
      ),
      schedule: NotificationCalendar(
        second: 0, // 当秒到达 0 时将会通知，意味着每个分钟的整点会通知
        timeZone: localTimeZone,
        allowWhileIdle: true,
        preciseAlarm: true,
        repeats: true,
      ),
    );
  }

  /// 通知权限
  Future<bool> _showNotificationRationale(BuildContext context) async {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    var userAuthorized = false;

    await showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: isDark ? .dark() : .light(),
          child: CupertinoAlertDialog(
            key: const .new('notification_rationale_dialog'),
            title: Text(appL10n.local_notification_dialog_allow_title),
            content: Text(appL10n.local_notification_dialog_allow_content),
            actions: <CupertinoDialogAction>[
              .new(
                key: const .new('notification_rationale_close'),
                child: Text(appL10n.local_notification_dialog_allow_cancel),
                textStyle: .new(color: theme.textTheme.bodyMedium?.color),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                key: const .new('notification_rationale_ok'),
                isDefaultAction: true,
                child: Text(appL10n.local_notification_dialog_allow_confirm),
                textStyle: .new(color: theme.textTheme.bodyMedium?.color),
                onPressed: () {
                  userAuthorized = true;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
    return userAuthorized && await _awesomeNotifications.requestPermissionToSendNotifications();
  }
}
