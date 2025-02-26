import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../l10n/gen/app_localizations.dart';

/// 国际化日期
abstract final class LocaleDatetime {
  /// 年月日格式化
  ///
  /// - [datatime] 时间
  ///
  /// @return [String] 日期如：2000-01-01
  static String yMMMd(BuildContext context, String datatime) {
    final localeName = AppL10n.of(context).localeName;
    return datatime.isNotEmpty
        ? DateFormat.yMMMMd(localeName).format(DateFormat('yyyy-MM-dd').parse(datatime))
        : '';
  }
}
