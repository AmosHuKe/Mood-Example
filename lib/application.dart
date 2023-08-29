import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/widgets/will_pop_scope_route/will_pop_scope_route.dart';
import 'package:moodexample/home_screen.dart';
import 'init.dart';

import 'package:moodexample/providers/mood/mood_provider.dart';
import 'package:moodexample/providers/statistic/statistic_provider.dart';
import 'package:moodexample/providers/application/application_provider.dart';

import 'package:moodexample/views/menu_screen/menu_screen_left.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    /// 路由
    final router = FluroRouter();
    Routes.configureRoutes(router);

    return MultiProvider(
      /// 状态管理
      providers: [
        ChangeNotifierProvider(create: (_) => MoodProvider()),
        ChangeNotifierProvider(create: (_) => StatisticProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      builder: (context, child) {
        final watchApplicationProvider = context.watch<ApplicationProvider>();

        return ScreenUtilInit(
          designSize: const Size(AppTheme.wdp, AppTheme.hdp),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
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
              darkTheme: AppTheme(getMultipleThemesMode(context))
                  .multipleThemesDarkMode(),
              // 路由钩子
              onGenerateRoute: router.generator,
              // 国际化
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: watchApplicationProvider.localeSystem
                  ? null
                  : watchApplicationProvider.locale,
              localeListResolutionCallback: (locales, supportedLocales) {
                print('当前地区语言$locales');
                print('设备支持的地区语言$supportedLocales');
                return null;
              },
              title: 'Mood',
              navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
              // Home
              home: const WillPopScopeRoute(
                child: Init(
                  child: MenuPage(key: Key('widget_menu_page')),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// 外层抽屉菜单
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _drawerController = ZoomDrawerController();

    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: const MenuScreenLeft(),
      mainScreen: const MainScreenBody(),
      borderRadius: 36.w,
      showShadow: true,
      disableDragGesture: false,
      mainScreenTapClose: true,
      openCurve: Curves.easeOut,
      closeCurve: Curves.fastOutSlowIn,
      drawerShadowsBackgroundColor:
          isDarkMode(context) ? Colors.black26 : Colors.white38,
      menuBackgroundColor: isDarkMode(context)
          ? Theme.of(context).primaryColor.withAlpha(155)
          : Theme.of(context).primaryColor,
      angle: 0,
      mainScreenScale: 0.3,
      slideWidth: MediaQuery.of(context).size.width * 0.70,
      style: DrawerStyle.defaultStyle,
    );
  }
}

/// 主屏幕逻辑
class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    /// 监听状态进行改变
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (_, state, child) {
        print('外层菜单状态：$state');
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
