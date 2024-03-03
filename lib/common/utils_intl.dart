import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

import 'package:moodexample/l10n/gen/app_localizations.dart';

/// 国际化日期
class LocaleDatetime {
  /// 年月日格式化
  ///
  /// [format] 时间格式
  ///
  /// @return [String] 日期如：2000-01-01
  static String yMMMd(BuildContext context, String format) => format.isNotEmpty
      ? DateFormat.yMMMMd(S.of(context).localeName).format(
          DateFormat('yyyy-MM-dd').parse(format),
        )
      : '';
}
