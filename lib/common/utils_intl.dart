import 'package:intl/intl.dart';

/// 国际化日期
class LocaleDatetime {
  /// 年月日格式化
  ///
  /// [format] 时间格式
  ///
  /// @return [String] 日期如：2000-01-01
  static String yMMMd(String format) => format.isNotEmpty
      ? DateFormat.yMMMMd().format(DateFormat('yyyy-MM-dd').parse(format))
      : '';
}
