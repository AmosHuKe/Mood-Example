import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'routes.dart';
import 'themes/app_theme.dart';
import 'l10n/gen/app_localizations.dart';

import 'providers/mood/mood_provider.dart';
import 'providers/statistic/statistic_provider.dart';
import 'providers/application/application_provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// 状态管理
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(create: (_) => StatisticProvider()),
      ],
      builder: (context, child) {
        final watchApplicationProvider = context.watch<ApplicationProvider>();

        return MaterialApp.router(
          // 网格
          debugShowMaterialGrid: false,
          // Debug标志
          debugShowCheckedModeBanner: false,
          // 打开性能监控，覆盖在屏幕最上面
          showPerformanceOverlay: false,
          // 语义视图（无障碍）
          showSemanticsDebugger: false,
          // 主题
          themeMode: watchApplicationProvider.themeMode,
          theme: AppTheme(getMultipleThemesMode(context))
              .multipleThemesLightMode(),
          darkTheme:
              AppTheme(getMultipleThemesMode(context)).multipleThemesDarkMode(),
          // 国际化
          supportedLocales: S.supportedLocales,
          localizationsDelegates: S.localizationsDelegates,
          locale: watchApplicationProvider.localeSystem
              ? null
              : watchApplicationProvider.locale,
          localeListResolutionCallback: (locales, supportedLocales) {
            print('当前地区语言$locales');
            print('设备支持的地区语言$supportedLocales');
            return null;
          },
          title: 'Mood',
          builder: FlutterSmartDialog.init(),
          routerConfig: Routes.config,
        );
      },
    );
  }
}
