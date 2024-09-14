import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'themes/app_theme.dart';
import 'common/notification.dart';
import 'l10n/gen/app_localizations.dart';
import 'db/db.dart';

import 'widgets/lock_screen/lock_screen.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();

    /// App 生命周期
    _appLifecycleListener = AppLifecycleListener(
      onResume: () => print('App Resume'),
      onInactive: () => print('App Inactive'),
      onHide: () => print('App Hide'),
      onShow: () => print('App Show'),
      onPause: () {
        print('App Pause');
        runLockScreen();
      },
      onRestart: () => print('App Restart'),
      onDetach: () => print('App Detach'),
    );

    /// 初始化
    init();
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 沉浸模式（全屏模式）
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode(context)
          ? SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
            ),
    );

    return widget.child;
  }

  /// 应用初始化
  Future<void> init() async {
    // 初始化数据库
    await DB.instance.database;
    // 锁屏
    runLockScreen();
    // 通知权限判断显示
    allowedNotification();

    /// 通知测试
    NotificationController.cancelNotifications();
    sendNotification();
    sendScheduleNotification();
  }

  /// 锁屏
  Future<void> runLockScreen() async {
    if (!mounted) return;
    lockScreen(context);
  }

  /// 通知权限判断显示
  Future<void> allowedNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      if (!mounted) return;
      isAllowed = await displayNotificationRationale(context);
    }
  }

  /// 发送普通通知
  Future<void> sendNotification() async {
    final bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;
    if (!mounted) return;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'notification',
        title: S.of(context).local_notification_welcome_title,
        body: S.of(context).local_notification_welcome_body,
        actionType: ActionType.Default,
        category: NotificationCategory.Event,
      ),
    );
  }

  /// 发送定时计划通知
  Future<void> sendScheduleNotification() async {
    final String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) return;
    if (!mounted) return;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1, // 随机ID
        channelKey: 'notification',
        title: S.of(context).local_notification_schedule_title,
        body: S.of(context).local_notification_schedule_body,
        actionType: ActionType.Default,
        category: NotificationCategory.Event,
      ),
      schedule: NotificationCalendar(
        second: 0, // 当秒到达0时将会通知，意味着每个分钟的整点会通知
        timeZone: localTimeZone,
        allowWhileIdle: true,
        preciseAlarm: true,
        repeats: true,
      ),
    );
  }

  /// 通知权限
  static Future<bool> displayNotificationRationale(BuildContext context) async {
    bool userAuthorized = false;
    await showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => Theme(
        data: isDarkMode(context) ? ThemeData.dark() : ThemeData.light(),
        child: CupertinoAlertDialog(
          key: const Key('notification_rationale_dialog'),
          title: Text(S.of(context).local_notification_dialog_allow_title),
          content: Text(S.of(context).local_notification_dialog_allow_content),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              key: const Key('notification_rationale_close'),
              child: Text(S.of(context).local_notification_dialog_allow_cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              key: const Key('notification_rationale_ok'),
              child:
                  Text(S.of(context).local_notification_dialog_allow_confirm),
              onPressed: () {
                userAuthorized = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }
}
