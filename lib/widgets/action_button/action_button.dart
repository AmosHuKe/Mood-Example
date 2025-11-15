import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

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
    final _width = width ?? kToolbarHeight;
    final _height = height ?? kToolbarHeight;
    final _decoration =
        decoration ??
        BoxDecoration(color: AppTheme.staticBackgroundColor1, borderRadius: .circular(18));

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
