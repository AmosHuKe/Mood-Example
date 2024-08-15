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
  const HomeScreen({
    super.key,
    required this.navigationShell,
  });

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// 当前页下标
  late int _currentIndex;

  /// Tab 控制
  late TabController _tabController;

  /// 进步按钮动画
  late AnimationController _stepButtonController;
  late Animation<double> _stepButtonAnimation;
  late CurvedAnimation _stepButtonCurve;

  @override
  void initState() {
    super.initState();

    /// 进步按钮Icon动画
    _stepButtonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _stepButtonCurve = CurvedAnimation(
      parent: _stepButtonController,
      curve: Curves.fastOutSlowIn,
    );
    _stepButtonAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_stepButtonController);
  }

  @override
  void dispose() {
    /// Tab控制
    _tabController.dispose();

    /// 进步按钮Icon动画
    _stepButtonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);

    /// Tab icon大小
    final double _tabIconSize = 20;

    final StatisticProvider statisticProvider =
        context.read<StatisticProvider>();

    /// 当前页下标
    _currentIndex = widget.navigationShell.currentIndex;

    /// Tab 控制
    _tabController = TabController(
      initialIndex: _currentIndex,
      length: widget.navigationShell.route.branches.length,
      vsync: this,
    );

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color:
              appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),
          ],
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              /// 菜单
              TabBar(
                enableFeedback: true,
                padding: const EdgeInsets.only(left: 40),
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelStyle: const TextStyle(
                  height: 0.5,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  height: 0.5,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    key: const Key('tab_home'),
                    text: S.of(context).app_bottomNavigationBar_title_home,
                    icon: Icon(
                      Remix.home_line,
                      size: _tabIconSize,
                    ),
                  ),
                  Tab(
                    key: const Key('tab_mood'),
                    text: S.of(context).app_bottomNavigationBar_title_mood,
                    icon: Icon(
                      Remix.heart_3_line,
                      size: _tabIconSize,
                    ),
                  ),
                  Tab(
                    key: const Key('tab_statistic'),
                    text: S.of(context).app_bottomNavigationBar_title_statistic,
                    icon: Icon(
                      Remix.bar_chart_line,
                      size: _tabIconSize,
                    ),
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
                      color: isDarkMode(context)
                          ? Colors.black12
                          : AppTheme.backgroundColor1,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: ValueListenableBuilder<DrawerState>(
                      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
                      builder: (_, state, child) {
                        if (state == DrawerState.closed) {
                          _stepButtonController.reverse();
                        } else {
                          _stepButtonController.forward();
                        }
                        return AnimatedBuilder(
                          animation: _stepButtonAnimation,
                          builder: (context, child) => Transform.rotate(
                            angle: _stepButtonCurve.value * 3.14,
                            child: child,
                          ),
                          child: Icon(
                            Remix.arrow_right_line,
                            size: 16,
                            color: isDarkMode(context)
                                ? const Color(0xFFEFEFEF)
                                : Colors.black,
                          ),
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    /// 侧栏操作
                    ZoomDrawer.of(context)?.toggle.call();
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
  const MenuPage({
    super.key,
    required this.navigationShell,
  });

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final _drawerController = ZoomDrawerController();

    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: const MenuScreenLeft(),
      mainScreen: MainScreenBody(navigationShell: navigationShell),
      borderRadius: 36,
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
  const MainScreenBody({
    super.key,
    required this.navigationShell,
  });

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

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
      child: HomeScreen(navigationShell: navigationShell),
    );
  }
}
