// dart format width=80
import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'l10n/gen/app_localizations.dart';
import 'router.dart';
import 'shared/config/multiple_theme_mode.dart';
import 'shared/providers/application_provider.dart';
import 'shared/themes/app_theme.dart';
import 'shared/utils/log_utils.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      ApplicationProvider,
      ({
        ThemeMode themeMode,
        MultipleThemeMode multipleThemeMode,
        bool localeSystem,
        Locale locale,
      })
    >(
      selector: (_, applicationProvider) {
        return (
          themeMode: applicationProvider.themeMode,
          multipleThemeMode: applicationProvider.multipleThemeMode,
          localeSystem: applicationProvider.localeSystem,
          locale: applicationProvider.locale,
        );
      },
      builder: (context, data, child) {
        final appTheme = AppTheme(context);
        return MaterialApp.router(
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          showSemanticsDebugger: false,
          themeMode: appTheme.themeMode,
          theme: appTheme.lightTheme(),
          darkTheme: appTheme.darkTheme(),
          supportedLocales: AppL10n.supportedLocales,
          localizationsDelegates: AppL10n.localizationsDelegates,
          locale: data.localeSystem ? null : data.locale,
          localeListResolutionCallback: (locales, supportedLocales) {
            Log.instance.info('App 当前的语言环境：$locales');
            Log.instance.info('App 支持的语言环境：$supportedLocales');
            return null;
          },
          title: 'Mood',
          builder: FlutterSmartDialog.init(),
          routerConfig: AppRouter.config,
        );
      },
    );
  }
}
