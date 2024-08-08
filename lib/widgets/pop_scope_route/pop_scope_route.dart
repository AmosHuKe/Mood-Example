import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:moodexample/l10n/gen/app_localizations.dart';

/// 导航返回拦截
class PopScopeRoute extends StatefulWidget {
  const PopScopeRoute({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PopScopeRoute> createState() => _PopScopeRouteState();
}

class _PopScopeRouteState extends State<PopScopeRoute> {
  DateTime? lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        if (didPop) return;
        SmartDialog.showToast(S.of(context).widgets_will_pop_scope_route_toast);
        if (lastPressedAt == null ||
            DateTime.now().difference(lastPressedAt!) >
                const Duration(seconds: 1)) {
          // 两次点击间隔超过1秒则重新计时
          lastPressedAt = DateTime.now();
          return;
        }
        SystemNavigator.pop();
      },
      child: widget.child,
    );
  }
}
