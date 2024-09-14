import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';
import 'package:moodexample/config/multiple_themes.dart';

import 'package:moodexample/widgets/animation/animation.dart';

import 'package:moodexample/providers/application/application_provider.dart';

/// 主题设置
class SettingTheme extends StatelessWidget {
  const SettingTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 主题外观设置
        Padding(
          padding: const EdgeInsets.only(left: 6, top: 6, bottom: 14),
          child: Text(
            S.of(context).app_setting_theme_appearance,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        const DarkThemeBody(),
        const SizedBox(height: 36),

        /// 多主题设置-可浅色、深色模式独立配色方案
        Padding(
          padding: const EdgeInsets.only(left: 6, top: 6, bottom: 14),
          child: Text(
            S.of(context).app_setting_theme_themes,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        const MultipleThemesBody(),
        const SizedBox(height: 48),
      ],
    );
  }
}

/// 主题外观设置
class DarkThemeBody extends StatelessWidget {
  const DarkThemeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationProvider>(
      builder: (_, applicationProvider, child) {
        final themeMode = applicationProvider.themeMode;
        return Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          runSpacing: 16,
          spacing: 16,
          children: [
            ThemeCard(
              title: S.of(context).app_setting_theme_appearance_system,
              selected: themeMode == ThemeMode.system,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: isDarkMode(context)
                          ? const Color(0xFFF6F8FA)
                          : const Color(0xFF111315),
                      child: Text(
                        'Aa',
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.black87
                              : const Color(0xFFEFEFEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: isDarkMode(context)
                          ? const Color(0xFF111315)
                          : const Color(0xFFF6F8FA),
                      child: Text(
                        'Aa',
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? const Color(0xFFEFEFEF)
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () => applicationProvider.themeMode = ThemeMode.system,
            ),
            ThemeCard(
              title: S.of(context).app_setting_theme_appearance_light,
              selected: themeMode == ThemeMode.light,
              child: Container(
                alignment: Alignment.center,
                color: const Color(0xFFF6F8FA),
                child: const Text(
                  'Aa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () => applicationProvider.themeMode = ThemeMode.light,
            ),
            ThemeCard(
              title: S.of(context).app_setting_theme_appearance_dark,
              selected: themeMode == ThemeMode.dark,
              child: Container(
                alignment: Alignment.center,
                color: const Color(0xFF111315),
                child: const Text(
                  'Aa',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              onTap: () => applicationProvider.themeMode = ThemeMode.dark,
            ),
          ],
        );
      },
    );
  }
}

/// 多主题设置
class MultipleThemesBody extends StatefulWidget {
  const MultipleThemesBody({super.key});

  @override
  State<MultipleThemesBody> createState() => _MultipleThemesBodyState();
}

class _MultipleThemesBodyState extends State<MultipleThemesBody> {
  @override
  Widget build(BuildContext context) {
    /// 获取多主题Key
    final List appMultipleThemesModeKey = [];
    appMultipleThemesMode
        .forEach((key, value) => appMultipleThemesModeKey.add(key));

    return Consumer<ApplicationProvider>(
      builder: (_, applicationProvider, child) {
        final multipleThemesMode = applicationProvider.multipleThemesMode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            runSpacing: 16,
            spacing: 16,
            children: List.generate(
              appMultipleThemesModeKey.length,
              (generator) {
                final String key = appMultipleThemesModeKey[generator];
                final Color primaryColor =
                    appMultipleThemesMode[key]!.lightTheme().primaryColor;
                return MultipleThemesCard(
                  key: Key('widget_multiple_themes_card_$key'),
                  selected: multipleThemesMode == key,
                  child: Container(
                    alignment: Alignment.center,
                    color: primaryColor,
                  ),
                  onTap: () {
                    print('主题:$key');
                    applicationProvider.multipleThemesMode = key;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// 多主题卡片
class MultipleThemesCard extends StatelessWidget {
  const MultipleThemesCard({
    super.key,
    this.child,
    this.selected,
    this.onTap,
  });

  /// 卡片内容
  final Widget? child;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected ?? false;
    return AnimatedPress(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: isSelected
                        ? Border.all(
                            width: 3,
                            color: isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                          )
                        : Border.all(
                            width: 3,
                            color: isDarkMode(context)
                                ? Colors.white12
                                : Colors.black12,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: child,
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (!isSelected) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 12, bottom: 12),
                      child: Icon(
                        Remix.checkbox_circle_fill,
                        size: 20,
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 主题模式卡片
class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    this.child,
    this.title,
    this.selected,
    this.onTap,
  });

  /// 卡片内容
  final Widget? child;

  /// 卡片标题
  final String? title;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selected ?? false;
    return AnimatedPress(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 100,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: isSelected
                        ? Border.all(
                            width: 3,
                            color: isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                          )
                        : Border.all(
                            width: 3,
                            color: isDarkMode(context)
                                ? Colors.white12
                                : Colors.black12,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: ExcludeSemantics(child: child),
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (!isSelected) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: Icon(
                        Remix.checkbox_circle_fill,
                        size: 20,
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
