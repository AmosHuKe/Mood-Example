import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
import 'package:vibration/vibration.dart';

/// 工具

/// 获取当前日期时间
///
/// @param {String} format 时间格式
///
/// @return {String} 日期
String getDatetimeNow(format) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat(format).format(now);
  return formattedDate.toString();
}

/// 震动
Future<void> vibrate() async {
  debugPrint("~~~ 震动 ~~~");
  Vibration.vibrate(duration: 10);
}

/// 统计颜色块
const List<Color> statisticColors = [
  Color(0xFFf94144),
  Color(0xFFf3722c),
  Color(0xFFf8961e),
  Color(0xFFf9844a),
  Color(0xFFf9c74f),
  Color(0xFF43aa8b),
  Color(0xFF4d908e),
  Color(0xFF577590),
  Color(0xFF277da1),
  Color(0xFF90be6d),
  Color(0xFF84a98c),
  Color(0xFF52796f),
  Color(0xFF354f52),
  Color(0xFF2f3e46),
  Color(0xFF606c38),
  Color(0xFF283618),
  Color(0xFFdda15e),
  Color(0xFFbc6c25),
];
