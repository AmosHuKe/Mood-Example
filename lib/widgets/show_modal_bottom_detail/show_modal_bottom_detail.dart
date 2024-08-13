import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:moodexample/themes/app_theme.dart';

/// 底部详情内容弹出
Future<T?> showModalBottomDetail<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    barrierColor: isDarkMode(context) ? Colors.black45 : Colors.black54,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Semantics(
              button: true,
              label: '返回',
              onTap: () => context.pop(),
              child: Container(
                key: const Key('widget_move_modal_bottom_sheet'),
                margin: const EdgeInsets.all(12),
                height: 4,
                width: 24,
                decoration: BoxDecoration(
                  color: isDarkMode(context)
                      ? const Color(0xFF2B3034)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
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
