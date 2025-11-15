import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';

/// 底部详情内容弹出
Future<T?> showModalBottomDetail<T>({required BuildContext context, required Widget child}) {
  final isDark = AppTheme(context).isDarkMode;

  return showModalBottomSheet<T>(
    context: context,
    barrierColor: isDark ? Colors.black45 : Colors.black54,
    shape: const RoundedRectangleBorder(
      borderRadius: .only(topLeft: .circular(32), topRight: .circular(32)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const .symmetric(horizontal: 12),
        child: Column(
          children: [
            Semantics(
              button: true,
              label: '返回',
              onTap: () => context.pop(),
              child: Container(
                key: const .new('widget_move_modal_bottom_sheet'),
                margin: const .all(12),
                height: 4,
                width: 24,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2B3034) : Colors.grey,
                  borderRadius: .circular(8),
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
