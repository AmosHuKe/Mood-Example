import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
import 'package:moodexample/app_theme.dart';

/// 操作按钮
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
      orientation: Orientation.portrait,
    );

    ///
    final double _width = width ?? 48.w;
    final double _height = height ?? 48.w;
    final Decoration _decoration = decoration ??
        BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppTheme.backgroundColor1,
              AppTheme.backgroundColor1,
            ],
          ),
          borderRadius: BorderRadius.circular(18.w),
        );

    ///
    return InkWell(
      child: Container(
        width: _width,
        height: _height,
        margin: margin,
        padding: padding,
        child: DecoratedBox(
          decoration: _decoration,
          child: child,
        ),
      ),
      onTap: onTap,
    );
  }
}
