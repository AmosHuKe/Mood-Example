import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'models/mood/mood_model.dart';

import 'init.dart';
import 'home_screen.dart';
import 'views/home/index.dart';
import 'views/onboarding/index.dart';
import 'views/mood/index.dart';
import 'views/mood/mood_category_select.dart';
import 'views/mood/mood_content.dart';
import 'views/statistic/index.dart';
import 'views/settings/laboratory/index.dart';
import 'views/settings/laboratory/unimp_miniapps/index.dart';
import 'views/settings/laboratory/3d/index.dart';
import 'views/settings/laboratory/game/index.dart';
import 'views/settings/laboratory/game/mini_fantasy/index.dart';
import 'views/settings/laboratory/game/mini_game/index.dart';
import 'views/settings/laboratory/ffi/index.dart';
import 'views/web_view/web_view.dart';

/// 路由管理
class Routes {
  const Routes._();

  /// 定义路由名称

  /// 主页
  static const String home = 'home';

  /// 用户引导页
  static const String onboarding = 'onboarding';

  /// 心情详情列表页
  static const String mood = 'mood';

  /// 添加心情选择页
  ///
  /// - [type] 状态 [MoodCategorySelectType] add: 添加 edit: 编辑
  static const String moodCategorySelect = 'moodCategorySelect';

  /// 添加心情内容页
  ///
  /// - [moodData] 心情数据 [MoodData]
  static const String moodContent = 'moodContent';

  /// 统计页
  static const String statistic = 'statistic';

  /// 设置页-实验室
  static const String settingLaboratory = 'settingLaboratory';

  /// 设置页-实验室-uniapp 小程序
  static const String laboratoryUniMPMiniapps = 'laboratoryUniMPMiniapps';

  /// 设置页-实验室-3D 城市
  static const String laboratoryPage3D = 'laboratoryPage3D';

  /// 设置页-实验室-游戏合集
  static const String laboratoryGame = 'laboratoryGame';

  /// 设置页-实验室-游戏合集-Mini Fantasy
  static const String laboratoryGameMiniFantasy = 'laboratoryGameMiniFantasy';

  /// 设置页-实验室-游戏合集-疯狂射击、怪物生成
  static const String laboratoryGameMiniGame = 'laboratoryGameMiniGame';

  /// 设置页-实验室-FFI 异步调用 C/C++
  static const String laboratoryFFI = 'laboratoryFFI';

  /// WebView
  ///
  /// - [url] 访问的 URL （通过 ValueConvert 编码传递）
  static const String webViewPage = 'webViewPage';

  /// Key

  /// 根路由
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// 子路由-主屏幕
  // static final GlobalKey<NavigatorState> _shellHomeScreenNavigatorKey =
  //     GlobalKey<NavigatorState>(debugLabel: 'shellHomeScreen');

  /// 子路由-主屏幕-主页
  static final GlobalKey<NavigatorState> _shellHomeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');

  /// 子路由-主屏幕-心情详情列表页
  static final GlobalKey<NavigatorState> _shellMoodNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellMood');

  /// 子路由-主屏幕-统计页
  static final GlobalKey<NavigatorState> _shellStatisticNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellStatistic');

  /// 路由配置
  static final config = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    observers: [FlutterSmartDialog.observer],
    initialLocation: '/$home',
    routes: [
      /// 主屏幕（有状态嵌套路由）
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          /// 主屏幕
          return Init(
            child: MenuPage(
              key: const Key('widget_menu_page'),
              navigationShell: navigationShell,
            ),
          );
        },
        branches: [
          /// 主页
          StatefulShellBranch(
            navigatorKey: _shellHomeNavigatorKey,
            initialLocation: '/$home',
            routes: [
              /// 主页
              GoRoute(
                path: '/$home',
                name: home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          /// 心情详情列表页
          StatefulShellBranch(
            navigatorKey: _shellMoodNavigatorKey,
            initialLocation: '/$mood',
            routes: [
              /// 心情详情列表页
              GoRoute(
                path: '/$mood',
                name: mood,
                builder: (context, state) => const MoodPage(),
              ),
            ],
          ),

          /// 统计页
          StatefulShellBranch(
            navigatorKey: _shellStatisticNavigatorKey,
            initialLocation: '/$statistic',
            routes: [
              /// 统计页
              GoRoute(
                path: '/$statistic',
                name: statistic,
                builder: (context, state) => const StatisticPage(),
              ),
            ],
          ),
        ],
      ),

      /// 用户引导页
      GoRoute(
        path: '/$onboarding',
        name: onboarding,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const Onboarding(),
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

      /// 添加心情选择页
      GoRoute(
        path: '/$moodCategorySelect/:type',
        name: moodCategorySelect,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: MoodCategorySelect(type: state.pathParameters['type'] ?? ''),
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

      /// 添加心情内容页
      GoRoute(
        path: '/$moodContent/:moodData',
        name: moodContent,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) {
          final MoodData moodData =
              moodDataFromJson(state.pathParameters['moodData'] ?? '');

          return CustomTransitionPage(
            child: MoodContent(moodData: moodData),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
        path: '/$settingLaboratory',
        name: settingLaboratory,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const LaboratoryPage(),
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

      /// 设置页-实验室-uniapp 小程序
      GoRoute(
        path: '/$laboratoryUniMPMiniapps',
        name: laboratoryUniMPMiniapps,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const UniMPMiniappsPage(),
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

      /// 设置页-实验室-3D 城市
      GoRoute(
        path: '/$laboratoryPage3D',
        name: laboratoryPage3D,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const Page3D(),
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

      /// 设置页-实验室-游戏合集
      GoRoute(
        path: '/$laboratoryGame',
        name: laboratoryGame,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const GamePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
            path: laboratoryGameMiniFantasy,
            name: laboratoryGameMiniFantasy,
            pageBuilder: (_, state) => CustomTransitionPage(
              child: const MiniFantasyPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
            path: laboratoryGameMiniGame,
            name: laboratoryGameMiniGame,
            pageBuilder: (_, state) => CustomTransitionPage(
              child: PopScope(
                canPop: false,
                onPopInvokedWithResult: (bool didPop, _) async {
                  if (didPop) return;
                  // 竖屏
                  await Flame.device.setPortrait();
                },
                child: const MiniGamePage(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
        path: '/$laboratoryFFI',
        name: laboratoryFFI,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: const FFIPage(),
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

      /// WebView
      GoRoute(
        path: '/$webViewPage/:url',
        name: webViewPage,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: WebViewPage(url: state.pathParameters['url'] ?? ''),
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
