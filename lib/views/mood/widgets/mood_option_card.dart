import 'package:flutter/material.dart';
import '../../../themes/app_theme.dart';
import '../../../widgets/animation/animation.dart';

/// 心情选择卡片
class MoodOptionCard extends StatelessWidget {
  const MoodOptionCard({super.key, this.icon, this.title});

  /// 图标
  final String? icon;

  /// 标题
  final String? title;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;

    return AnimatedPress(
      child: SizedBox(
        width: 128,
        height: 128,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF202427) : Colors.white,
            borderRadius: .circular(32),
          ),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Padding(
                padding: const .only(bottom: 6),
                child: Text(icon ?? '', style: const .new(fontSize: 32)),
              ),
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 16,
                  fontWeight: .w400, // dart format
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
