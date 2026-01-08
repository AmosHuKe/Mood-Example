import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class Utils {
  /// 格式化日期时间
  ///
  /// - [datetime] 日期时间
  /// - [format] 时间格式，与 [DateFormat] 规则相同
  ///
  /// @return [String] 日期
  static String datetimeFormatToString(DateTime datetime, {String? format}) =>
      DateFormat(format ?? 'yyyy-MM-dd').format(datetime).substring(0, 10);

  /// 解析日期时间
  ///
  /// - [datetime] 日期时间
  /// - [format] 时间格式，与 [DateFormat] 规则相同
  ///
  /// @return [String] 日期
  static String datetimeParseToString(String datetime, {String? format}) =>
      DateFormat(format ?? 'yyyy-MM-dd').parse(datetime).toString().substring(0, 10);

  /// 统计颜色块
  static const List<Color> statisticColors = [
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

  /// 测试模式
  ///
  /// `--dart-define=test_mode=true`
  static bool get envTestMode => const bool.fromEnvironment('test_mode', defaultValue: false);
}

/// 内容基础 Base64 转换
///
/// [value] 内容
class ValueBase64 {
  ValueBase64(this.value);
  String value;
  String encode() => base64Encode(utf8.encode(value));
  String decode() => utf8.decode(base64Decode(value));
}
