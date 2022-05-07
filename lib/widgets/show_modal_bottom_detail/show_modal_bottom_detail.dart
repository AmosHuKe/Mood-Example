import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
import 'package:moodexample/app_theme.dart';

/// 底部详情内容弹出
Future<T?> showModalBottomDetail<T>({
  required BuildContext context,
  required Widget child,
}) {
  // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
  ScreenUtil.init(
    context,
    designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    orientation: Orientation.portrait,
  );
  return showModalBottomSheet(
    context: context,
    barrierColor:
        isDarkMode(context) ? Colors.grey.withOpacity(0.3) : Colors.black54,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.w),
        topRight: Radius.circular(32.w),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12.w),
              height: 4.w,
              width: 24.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode(context)
                        ? [
                            const Color(0xFF2B3034),
                            const Color(0xFF2B3034),
                          ]
                        : [
                            Colors.grey,
                            Colors.grey,
                          ],
                  ),
                  borderRadius: BorderRadius.circular(8.w),
                ),
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      );
    },
  );
}
