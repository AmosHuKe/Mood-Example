import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'domain/models/mood/mood_data_model.dart';

import 'init.dart';
import 'views/main_screen.dart';
import 'views/home/home.dart';
import 'views/mood/view_models/mood_category_select_view_model.dart';
import 'views/onboarding/onboarding.dart';
import 'views/mood/mood.dart';
import 'views/mood/mood_category_select.dart';
import 'views/mood/mood_content_edit.dart';
import 'views/statistic/statistic.dart';
import 'views/laboratory/laboratory.dart';
import 'views/laboratory/unimp_miniapps/unimp_miniapps.dart';
import 'views/laboratory/tilt_example/tilt_example.dart';
import 'views/laboratory/game/game.dart';
import 'views/laboratory/game/mini_fantasy/mini_fantasy.dart';
import 'views/laboratory/game/mini_game/mini_game.dart';
import 'views/laboratory/ffi/ffi.dart';
import 'views/laboratory/3d/3d.dart';
import 'views/web_view/web_view.dart';

/// 定义路由名称
abstract final class Routes {
  /// 主页
  static const String home = 'home';

  /// 用户引导页
  static const String onboarding = 'onboarding';

  /// 心情详情列表页
  static const String mood = 'mood';

  /// 添加心情选择页
  ///
  /// - [type] 状态 [MoodCategorySelectType] add: 添加 edit: 编辑
  /// - [selectDateTime] 当前选择的时间
  static const String moodCategorySelect = 'moodCategorySelect';

  /// 添加心情内容编辑页
  ///
  /// - [moodData] 心情数据 [MoodDataModel]
  static const String moodContentEdit = 'moodContentEdit';

  /// 统计页
  static const String statistic = 'statistic';

  /// 设置页-实验室
  static const String settingLaboratory = 'settingLaboratory';

  /// 设置页-实验室-uniapp 小程序
  static const String laboratoryUniMPMiniapps = 'laboratoryUniMPMiniapps';

  /// 设置页-实验室-倾斜视差卡片
  static const String laboratoryTiltExample = 'laboratoryTiltExample';

  /// 设置页-实验室-游戏合集
  static const String laboratoryGame = 'laboratoryGame';

  /// 设置页-实验室-游戏合集-Mini Fantasy
  static const String laboratoryGameMiniFantasy = 'laboratoryGameMiniFantasy';

  /// 设置页-实验室-游戏合集-疯狂射击、怪物生成
  static const String laboratoryGameMiniGame = 'laboratoryGameMiniGame';

  /// 设置页-实验室-3D 城市
  static const String laboratoryPage3D = 'laboratoryPage3D';

  /// 设置页-实验室-FFI 异步调用 C/C++
  static const String laboratoryFFI = 'laboratoryFFI';

  /// WebView
  ///
  /// - [url] 访问的 URL （通过 ValueConvert 编码传递）
  static const String webViewPage = 'webViewPage';
}

/// 路由管理
abstract final class AppRouter {
  const AppRouter._();

  /// 根路由
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  /// 子路由-主屏幕-主页
  static final GlobalKey<NavigatorState> shellHomeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );

  /// 子路由-主屏幕-心情详情列表页
  static final GlobalKey<NavigatorState> shellMoodNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellMood',
  );

  /// 子路由-主屏幕-统计页
  static final GlobalKey<NavigatorState> shellStatisticNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellStatistic',
  );

  /// 路由配置
  static final config = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: [FlutterSmartDialog.observer],
    initialLocation: '/${Routes.home}',
    routes: [
      /// 主屏幕（有状态嵌套路由）
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder:
            (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              /// 主屏幕
              return Init(
                child: MainScreen(
                  key: const Key('widget_menu_page'),
                  navigationShell: navigationShell,
                ),
              );
            },
        branches: [
          /// 主页
          StatefulShellBranch(
            navigatorKey: shellHomeNavigatorKey,
            initialLocation: '/${Routes.home}',
            routes: [
              GoRoute(
                path: '/${Routes.home}',
                name: Routes.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),

          /// 心情详情列表页
          StatefulShellBranch(
            navigatorKey: shellMoodNavigatorKey,
            initialLocation: '/${Routes.mood}',
            routes: [
              GoRoute(
                path: '/${Routes.mood}',
                name: Routes.mood,
                builder: (_, _) => const MoodScreen(),
              ),
            ],
          ),

          /// 统计页
          StatefulShellBranch(
            navigatorKey: shellStatisticNavigatorKey,
            initialLocation: '/${Routes.statistic}',
            routes: [
              GoRoute(
                path: '/${Routes.statistic}',
                name: Routes.statistic,
                builder: (_, _) => const StatisticScreen(),
              ),
            ],
          ),
        ],
      ),

      /// 用户引导页
      GoRoute(
        path: '/${Routes.onboarding}',
        name: Routes.onboarding,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const OnboardingScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 添加心情选择页
      GoRoute(
        path: '/${Routes.moodCategorySelect}/:type/:selectDateTime',
        name: Routes.moodCategorySelect,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) {
          final screenType = MoodCategorySelectType.fromString(state.pathParameters['type'] ?? '');
          final selectDateTime = DateTime.parse(state.pathParameters['selectDateTime'] ?? '');

          return CustomTransitionPage(
            child: MoodCategorySelectScreen(screenType: screenType, selectDateTime: selectDateTime),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(
                primaryRouteAnimation: animation,
                secondaryRouteAnimation: secondaryAnimation,
                linearTransition: false,
                child: child,
              );
            },
          );
        },
      ),

      /// 添加心情内容页
      GoRoute(
        path: '/${Routes.moodContentEdit}/:moodData',
        name: Routes.moodContentEdit,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) {
          final moodData = MoodDataModel.fromJson(
            jsonDecode(state.pathParameters['moodData'] ?? ''),
          );

          return CustomTransitionPage(
            child: MoodContentEditScreen(moodData: moodData),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(
                primaryRouteAnimation: animation,
                secondaryRouteAnimation: secondaryAnimation,
                linearTransition: false,
                child: child,
              );
            },
          );
        },
      ),

      /// 设置页-实验室
      GoRoute(
        path: '/${Routes.settingLaboratory}',
        name: Routes.settingLaboratory,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const LaboratoryScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 设置页-实验室-uniapp 小程序
      GoRoute(
        path: '/${Routes.laboratoryUniMPMiniapps}',
        name: Routes.laboratoryUniMPMiniapps,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const UniMPMiniappsScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 设置页-实验室-倾斜视差卡片
      GoRoute(
        path: '/${Routes.laboratoryTiltExample}',
        name: Routes.laboratoryTiltExample,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const TiltExampleScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 设置页-实验室-游戏合集
      GoRoute(
        path: '/${Routes.laboratoryGame}',
        name: Routes.laboratoryGame,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const GameScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
        routes: [
          /// 设置页-实验室-游戏合集-Mini Fantasy
          GoRoute(
            path: Routes.laboratoryGameMiniFantasy,
            name: Routes.laboratoryGameMiniFantasy,
            pageBuilder: (_, _) => CustomTransitionPage(
              child: const MiniFantasyScreen(),
              transitionsBuilder: (_, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: false,
                  child: child,
                );
              },
            ),
          ),

          /// 设置页-实验室-游戏合集-疯狂射击、怪物生成
          GoRoute(
            path: Routes.laboratoryGameMiniGame,
            name: Routes.laboratoryGameMiniGame,
            pageBuilder: (_, _) => CustomTransitionPage(
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, _) async {
                  if (didPop) return;
                  // 竖屏
                  await Flame.device.setPortrait();
                },
                child: const MiniGameScreen(),
              ),
              transitionsBuilder: (_, animation, secondaryAnimation, child) {
                return CupertinoPageTransition(
                  primaryRouteAnimation: animation,
                  secondaryRouteAnimation: secondaryAnimation,
                  linearTransition: false,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),

      /// 设置页-实验室-FFI 异步调用 C/C++
      GoRoute(
        path: '/${Routes.laboratoryFFI}',
        name: Routes.laboratoryFFI,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const FFIScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 设置页-实验室-3D 城市
      GoRoute(
        path: '/${Routes.laboratoryPage3D}',
        name: Routes.laboratoryPage3D,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const Demo3DScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// WebView
      GoRoute(
        path: '/${Routes.webViewPage}/:url',
        name: Routes.webViewPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: WebViewScreen(url: state.pathParameters['url'] ?? ''),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
