import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

/// 工具

/// 获取当前日期时间
///
/// [format] 时间格式，与 [DateFormat] 规则相同
///
/// @return [String] 日期
String getDatetimeNow(String format) {
  final DateTime now = DateTime.now();
  final String formattedDate = DateFormat(format).format(now);
  return formattedDate.toString();
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

/// 内容基础加密/解密转换
///
/// [value] 内容
class ValueConvert {
  ValueConvert(this.value);
  String value;
  String encode() => base64Encode(utf8.encode(value));
  String decode() => utf8.decode(base64Decode(value));
}
