import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
import 'package:moodexample/themes/app_theme.dart';

/// 操作按钮
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.semanticsLabel,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    required this.child,
    this.onTap,
  }) : super(key: key);

  /// 语义描述
  final String? semanticsLabel;
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
    );

    ///
    final double getWidth = width ?? 48.w;
    final double getHeight = height ?? 48.w;
    final Decoration getDecoration = decoration ??
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
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: getWidth,
          height: getHeight,
          margin: margin,
          padding: padding,
          child: DecoratedBox(
            decoration: getDecoration,
            child: child,
          ),
        ),
      ),
    );
  }
}
