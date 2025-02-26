// dart format width=80
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'l10n/gen/app_localizations.dart';
import 'shared/config/multiple_theme_mode.dart';
import 'shared/view_models/application_view_model.dart';
import 'themes/app_theme.dart';
import 'router.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      ApplicationViewModel,
      ({
        ThemeMode themeMode,
        MultipleThemeMode multipleThemeMode,
        bool localeSystem,
        Locale locale,
      })
    >(
      selector: (_, applicationViewModel) {
        return (
          themeMode: applicationViewModel.themeMode,
          multipleThemeMode: applicationViewModel.multipleThemeMode,
          localeSystem: applicationViewModel.localeSystem,
          locale: applicationViewModel.locale,
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
            print('App 当前的语言环境：$locales');
            print('App 支持的语言环境：$supportedLocales');
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
