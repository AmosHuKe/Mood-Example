import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:moodexample/themes/app_theme.dart';

/// 底部详情内容弹出
Future<T?> showModalBottomDetail<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: isDarkMode(context) ? Colors.black45 : Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.w),
        topRight: Radius.circular(32.w),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            Semantics(
              button: true,
              label: '返回',
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                key: const Key('widget_move_modal_bottom_sheet'),
                margin: EdgeInsets.all(12.w),
                height: 4.w,
                width: 24.w,
                decoration: BoxDecoration(
                  color: isDarkMode(context)
                      ? const Color(0xFF2B3034)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8.w),
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      );
    },
  );
}
