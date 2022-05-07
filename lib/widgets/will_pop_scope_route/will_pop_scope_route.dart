import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moodexample/app_theme.dart';

/// 导航返回拦截
class WillPopScopeRoute extends StatefulWidget {
  /// 子组件
  final Widget child;

  const WillPopScopeRoute({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _WillPopScopeRouteState createState() => _WillPopScopeRouteState();
}

class _WillPopScopeRouteState extends State<WillPopScopeRoute> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
      orientation: Orientation.portrait,
    );
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
          msg: "再按一次退出",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 12.sp,
        );
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
