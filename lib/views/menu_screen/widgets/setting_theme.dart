import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/db/preferences_db.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 主题设置
class SettingTheme extends StatefulWidget {
  const SettingTheme({Key? key}) : super(key: key);

  @override
  _SettingThemeState createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            S.of(context).app_setting_theme_appearance,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),

        /// 主题外观设置
        Consumer<ApplicationViewModel>(
          builder: (_, applicationViewModel, child) {
            final _themeMode = applicationViewModel.themeMode;
            return Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              runSpacing: 16.w,
              spacing: 16.w,
              children: [
                DarkThemeCard(
                  title: S.of(context).app_setting_theme_appearance_system,
                  selected: _themeMode == ThemeMode.system,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDarkMode(context)
                                  ? [
                                      const Color(0xFFF6F8FA),
                                      const Color(0xFFF6F8FA)
                                    ]
                                  : [
                                      const Color(0xFF111315),
                                      const Color(0xFF111315)
                                    ],
                            ),
                          ),
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDarkMode(context)
                                  ? [
                                      const Color(0xFF111315),
                                      const Color(0xFF111315)
                                    ]
                                  : [
                                      const Color(0xFFF6F8FA),
                                      const Color(0xFFF6F8FA)
                                    ],
                            ),
                          ),
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
                    print("跟随系统");
                    await PreferencesDB()
                        .setAppThemeDarkMode(context, "system");
                  },
                ),
                DarkThemeCard(
                  title: S.of(context).app_setting_theme_appearance_light,
                  selected: _themeMode == ThemeMode.light,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF6F8FA), Color(0xFFF6F8FA)],
                      ),
                    ),
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
                    print("普通模式");
                    await PreferencesDB().setAppThemeDarkMode(context, "light");
                  },
                ),
                DarkThemeCard(
                  title: S.of(context).app_setting_theme_appearance_dark,
                  selected: _themeMode == ThemeMode.dark,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF111315), Color(0xFF111315)],
                      ),
                    ),
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
                    print("深色模式");
                    await PreferencesDB().setAppThemeDarkMode(context, "dark");
                  },
                ),
              ],
            );
          },
        ),
      ],
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
    bool _selected = selected ?? false;
    return InkWell(
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
                  border: _selected
                      ? Border.all(
                          width: 3.w,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
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
                  child: child,
                ),
              ),
              Builder(
                builder: (_) {
                  if (!_selected) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w, bottom: 8.w),
                    child: Icon(
                      Remix.checkbox_circle_fill,
                      size: 20.sp,
                      color: isDarkMode(context) ? Colors.white : Colors.black,
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
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
