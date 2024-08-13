import 'package:flutter/material.dart';

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
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double _width = width ?? 48;
    final double _height = height ?? 48;
    final Decoration _decoration = decoration ??
        BoxDecoration(
          color: AppTheme.backgroundColor1,
          borderRadius: BorderRadius.circular(18),
        );

    ///
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: _width,
          height: _height,
          margin: margin,
          padding: padding,
          decoration: _decoration,
          child: child,
        ),
      ),
    );
  }
}
