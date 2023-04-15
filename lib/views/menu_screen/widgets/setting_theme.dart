import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/db/preferences_db.dart';
import 'package:moodexample/config/multiple_themes.dart';
import 'package:moodexample/widgets/animation/animation.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 主题设置
class SettingTheme extends StatefulWidget {
  const SettingTheme({super.key});

  @override
  State<SettingTheme> createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 主题外观设置
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            S.of(context).app_setting_theme_appearance,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),

        const DarkThemeBody(),
        SizedBox(height: 36.w),

        /// 多主题设置-可浅色、深色模式独立配色方案
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            S.of(context).app_setting_theme_themes,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),

        const MultipleThemesBody(),
        SizedBox(height: 48.w)
      ],
    );
  }
}

/// 主题外观设置
class DarkThemeBody extends StatefulWidget {
  const DarkThemeBody({super.key});

  @override
  State<DarkThemeBody> createState() => _DarkThemeBodyState();
}

class _DarkThemeBodyState extends State<DarkThemeBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final themeMode = applicationViewModel.themeMode;
        return Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          runSpacing: 16.w,
          spacing: 16.w,
          children: [
            DarkThemeCard(
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
                        "Aa",
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.black87
                              : const Color(0xFFEFEFEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
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
                        "Aa",
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? const Color(0xFFEFEFEF)
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await PreferencesDB()
                    .setAppThemeDarkMode(applicationViewModel, "system");
              },
            ),
            DarkThemeCard(
              title: S.of(context).app_setting_theme_appearance_light,
              selected: themeMode == ThemeMode.light,
              child: Container(
                alignment: Alignment.center,
                color: const Color(0xFFF6F8FA),
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              onTap: () async {
                await PreferencesDB()
                    .setAppThemeDarkMode(applicationViewModel, "light");
              },
            ),
            DarkThemeCard(
              title: S.of(context).app_setting_theme_appearance_dark,
              selected: themeMode == ThemeMode.dark,
              child: Container(
                alignment: Alignment.center,
                color: const Color(0xFF111315),
                child: Text(
                  "Aa",
                  style: TextStyle(
                    color: const Color(0xFFEFEFEF),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              onTap: () async {
                await PreferencesDB()
                    .setAppThemeDarkMode(applicationViewModel, "dark");
              },
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
    List appMultipleThemesModeKey = [];
    appMultipleThemesMode
        .forEach((key, value) => appMultipleThemesModeKey.add(key));
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final multipleThemesMode = applicationViewModel.multipleThemesMode;
        return Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            runSpacing: 16.w,
            spacing: 16.w,
            children: List.generate(
              appMultipleThemesModeKey.length,
              (generator) {
                String key = appMultipleThemesModeKey[generator];
                Color primaryColor =
                    appMultipleThemesMode[key]![AppMultipleThemesMode.light]!
                        .primaryColor;
                return MultipleThemesCard(
                  key: Key("widget_multiple_themes_card_$key"),
                  selected: multipleThemesMode == key,
                  child: Container(
                    alignment: Alignment.center,
                    color: primaryColor,
                  ),
                  onTap: () async {
                    debugPrint("主题:$key");
                    await PreferencesDB()
                        .setMultipleThemesMode(applicationViewModel, key);
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
  /// 卡片内容
  final Widget? child;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final Function()? onTap;

  const MultipleThemesCard({
    Key? key,
    this.child,
    this.selected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = selected ?? false;
    return AnimatedPress(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: isSelected
                        ? Border.all(
                            width: 3.w,
                            color: isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                          )
                        : Border.all(
                            width: 3.w,
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
                      padding: EdgeInsets.only(right: 12.w, bottom: 12.w),
                      child: Icon(
                        Remix.checkbox_circle_fill,
                        size: 20.sp,
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

/// 深色模式卡片
class DarkThemeCard extends StatelessWidget {
  /// 卡片内容
  final Widget? child;

  /// 卡片标题
  final String? title;

  /// 是否选中
  final bool? selected;

  /// 点击触发
  final Function()? onTap;

  const DarkThemeCard({
    Key? key,
    this.child,
    this.title,
    this.selected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = selected ?? false;
    return AnimatedPress(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: 100.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.w),
                    border: isSelected
                        ? Border.all(
                            width: 3.w,
                            color: isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                          )
                        : Border.all(
                            width: 3.w,
                            color: isDarkMode(context)
                                ? Colors.white12
                                : Colors.black12,
                          ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.w),
                    child: ExcludeSemantics(child: child),
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (!isSelected) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w, bottom: 8.w),
                      child: Icon(
                        Remix.checkbox_circle_fill,
                        size: 20.sp,
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: Text(
                title ?? "",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
