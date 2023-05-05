import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
import 'package:moodexample/themes/app_theme.dart';

/// 操作按钮
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.semanticsLabel,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    required this.child,
    this.onTap,
  });

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
    final double getWidth = width ?? 48.w;
    final double getHeight = height ?? 48.w;
    final Decoration getDecoration = decoration ??
        BoxDecoration(
          color: AppTheme.backgroundColor1,
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
