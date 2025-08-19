import 'package:flutter/material.dart';

/// 空占位
class Empty extends StatelessWidget {
  const Empty({
    super.key,
    required this.icon,
    this.size,
    this.opacity = 0.1,
    this.padding = const EdgeInsets.all(0),
  });

  final IconData icon;
  final double? size;

  /// 透明度
  final double opacity;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      child: Opacity(
        alwaysIncludeSemantics: true,
        opacity: opacity,
        child: Column(
          children: [
            Padding(
              padding: padding,
              child: Icon(
                icon,
                size: size,
                color: theme.textTheme.bodyMedium?.color,
                semanticLabel: '空内容',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
