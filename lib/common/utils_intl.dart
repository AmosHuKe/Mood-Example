import 'package:intl/intl.dart';

/// 国际化日期
class LocaleDatetime {
  /// [年月日]
  ///
  /// @param {String} format 时间格式
  ///
  /// @return {String} 日期
  String yMMMd(String format) {
    return format.isEmpty
        ? ""
        : DateFormat.yMMMMd().format(DateFormat("yyyy-MM-dd").parse(format));
  }
}
