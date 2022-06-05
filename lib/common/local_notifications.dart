import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

enum ChannelID {
  /// 初始化相关
  init,

  /// 默认相关
  defaultMood,
}

class LocalNotifications {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Function({String? payload})? onSelectNotification;
  LocalNotifications({this.onSelectNotification({String? payload})?});

  /// 初始化
  void init() async {
    /// 本地通知初始化
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // Android 初始化通知需要在 android\app\src\main\res\drawable 存在 app_icon.png
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  /// 选择通知时触发
  void selectNotification(String? payload) async {
    if (onSelectNotification != null) {
      onSelectNotification!(payload: payload);
      return;
    }

    if (payload != null) {
      debugPrint('本地通知 notification payload: $payload');
    }
    debugPrint('本地通知 selectNotification');
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    debugPrint('本地通知 onDidReceiveLocalNotification');
  }

  /// 发送本地通知
  void send(
    int id,
    String? title,
    String? body, {
    required ChannelID channelId,
    required String channelName,
    String? channelDescription,
    String? payload,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId.toString(),
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  /// 定时计划发送本地通知
  void sendZonedSchedule(
    int id,
    String? title,
    String? body, {
    required ChannelID channelId,
    required String channelName,
    String? channelDescription,
    String? payload,
    required Duration duration,
  }) async {
    /// 时区初始化
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(duration),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId.toString(),
          channelName,
          channelDescription: channelDescription,
        ),
      ),
      androidAllowWhileIdle: true,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
