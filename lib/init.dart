import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/common/notification.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/db/db.dart';
import 'package:moodexample/db/preferences_db.dart';
import 'package:moodexample/widgets/lock_screen/lock_screen.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  void initState() {
    super.initState();
    AppLifecycleListener(
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
    init();
    // 通知测试
    NotificationController.cancelNotifications();
    sendNotification();
    sendScheduleNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  /// 应用初始化
  void init() async {
    final MoodViewModel moodViewModel =
        Provider.of<MoodViewModel>(context, listen: false);
    final ApplicationViewModel applicationViewModel =
        Provider.of<ApplicationViewModel>(context, listen: false);

    /// 初始化数据库
    await DB.db.database;

    /// 锁屏
    runLockScreen();

    /// 设置心情类别默认值
    final bool setMoodCategoryDefaultresult =
        await MoodViewModel().setMoodCategoryDefault();
    if (setMoodCategoryDefaultresult) {
      /// 获取所有心情类别
      MoodService.getMoodCategoryAll(moodViewModel);
    }

    /// 触发获取APP主题深色模式
    PreferencesDB().getAppThemeDarkMode(applicationViewModel);

    /// 触发获取APP多主题模式
    PreferencesDB().getMultipleThemesMode(applicationViewModel);

    /// 触发获取APP地区语言
    PreferencesDB().getAppLocale(applicationViewModel);

    /// 触发获取APP地区语言是否跟随系统
    PreferencesDB().getAppIsLocaleSystem(applicationViewModel);

    /// 通知权限判断显示
    allowedNotification();
  }

  /// 锁屏
  void runLockScreen() async {
    if (!mounted) return;
    lockScreen(context);
  }

  /// 通知权限判断显示
  void allowedNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      if (!mounted) return;
      isAllowed = await displayNotificationRationale(context);
    }
  }

  /// 发送普通通知
  void sendNotification() async {
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
  void sendScheduleNotification() async {
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
