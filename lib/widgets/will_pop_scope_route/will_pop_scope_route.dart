import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:moodexample/generated/l10n.dart';

/// 导航返回拦截
class WillPopScopeRoute extends StatefulWidget {
  const WillPopScopeRoute({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<WillPopScopeRoute> createState() => _WillPopScopeRouteState();
}

class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SmartDialog.showToast(S.of(context).widgets_will_pop_scope_route_toast);
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}
