import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'themes/app_theme.dart';
import 'l10n/gen/app_localizations.dart';

import 'providers/statistic/statistic_provider.dart';

import 'views/menu_screen/menu_screen_left.dart';

/// 首页底部Tabbar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// 当前页下标
  late int currentIndex;

  /// Tab 控制
  late TabController tabController;

  /// 进步按钮动画
  late AnimationController stepButtonController;
  late Animation<double> stepButtonAnimation;
  late CurvedAnimation stepButtonCurve;

  @override
  void initState() {
    super.initState();

    /// 进步按钮Icon动画
    stepButtonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    stepButtonCurve = CurvedAnimation(parent: stepButtonController, curve: Curves.fastOutSlowIn);
    stepButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(stepButtonController);
  }

  @override
  void dispose() {
    /// Tab 控制
    tabController.dispose();

    /// 进步按钮 Icon 动画
    stepButtonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    final zoomDrawer = ZoomDrawer.of(context);

    /// Tab Icon 大小
    const double tabIconSize = 20;

    final statisticProvider = context.read<StatisticProvider>();

    /// 当前页下标
    currentIndex = widget.navigationShell.currentIndex;

    /// Tab 控制
    tabController = TabController(
      initialIndex: currentIndex,
      length: widget.navigationShell.route.branches.length,
      vsync: this,
    );

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24)],
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              /// 菜单
              TabBar(
                enableFeedback: true,
                padding: const EdgeInsets.only(left: 40),
                controller: tabController,
                indicatorColor: Colors.transparent,
                labelStyle: const TextStyle(height: 0.5, fontSize: 10, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                  height: 0.5,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    key: const Key('tab_home'),
                    text: appL10n.app_bottomNavigationBar_title_home,
                    icon: const Icon(Remix.home_line, size: tabIconSize),
                  ),
                  Tab(
                    key: const Key('tab_mood'),
                    text: appL10n.app_bottomNavigationBar_title_mood,
                    icon: const Icon(Remix.heart_3_line, size: tabIconSize),
                  ),
                  Tab(
                    key: const Key('tab_statistic'),
                    text: appL10n.app_bottomNavigationBar_title_statistic,
                    icon: const Icon(Remix.bar_chart_line, size: tabIconSize),
                  ),
                ],
                onTap: (index) {
                  switch (index) {
                    case 2:
                      // 统计菜单触发
                      statisticProvider.load();
                  }
                  widget.navigationShell.goBranch(index);
                },
              ),

              /// 侧栏
              Semantics(
                button: true,
                label: '打开设置',
                child: GestureDetector(
                  key: const Key('tab_screen_left'),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black12 : AppTheme.staticBackgroundColor1,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: ValueListenableBuilder<DrawerState>(
                      valueListenable: zoomDrawer!.stateNotifier,
                      builder: (_, state, child) {
                        switch (state) {
                          case DrawerState.closed:
                            stepButtonController.reverse();
                          case _:
                            stepButtonController.forward();
                        }

                        return AnimatedBuilder(
                          animation: stepButtonAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: stepButtonCurve.value * 3.14,
                              child: child,
                            );
                          },
                          child: Icon(
                            Remix.arrow_right_line,
                            size: 16,
                            color: isDark ? const Color(0xFFEFEFEF) : Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    zoomDrawer.toggle.call();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 外层抽屉菜单
class MenuPage extends StatelessWidget {
  const MenuPage({super.key, required this.navigationShell});

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final isDark = AppTheme(context).isDarkMode;
    final drawerController = ZoomDrawerController();
    final slideWidth = MediaQuery.of(context).size.width * 0.70;

    return ZoomDrawer(
      controller: drawerController,
      menuScreen: const MenuScreenLeft(),
      mainScreen: MainScreenBody(navigationShell: navigationShell),
      borderRadius: 36,
      showShadow: true,
      disableDragGesture: false,
      mainScreenTapClose: true,
      openCurve: Curves.easeOut,
      closeCurve: Curves.fastOutSlowIn,
      drawerShadowsBackgroundColor: isDark ? Colors.black26 : Colors.white38,
      menuBackgroundColor: isDark ? themePrimaryColor.withAlpha(155) : themePrimaryColor,
      angle: 0,
      mainScreenScale: 0.3,
      slideWidth: slideWidth == 0 ? 250.0 : slideWidth,
      style: DrawerStyle.defaultStyle,
    );
  }
}

/// 主屏幕逻辑
class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key, required this.navigationShell});

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    /// 监听状态进行改变
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (_, state, child) {
        return AbsorbPointer(absorbing: state != DrawerState.closed, child: child);
      },
      child: HomeScreen(navigationShell: navigationShell),
    );
  }
}
