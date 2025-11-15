import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../themes/app_theme.dart';
import '../l10n/gen/app_localizations.dart';
import '../shared/view_models/statistic_view_model.dart';
import 'settings/setting_menu.dart';

/// 主屏幕
class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

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
      menuScreen: const SettingMenuScreen(),
      mainScreen: MainWrap(navigationShell: navigationShell),
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
      style: .defaultStyle,
    );
  }
}

class MainWrap extends StatelessWidget {
  const MainWrap({super.key, required this.navigationShell});

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    /// 侧边栏监听状态进行改变
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (_, state, child) {
        return AbsorbPointer(absorbing: state != .closed, child: child);
      },
      child: MainBody(navigationShell: navigationShell),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key, required this.navigationShell});

  /// 当前子路由状态
  final StatefulNavigationShell navigationShell;

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with TickerProviderStateMixin {
  /// 当前页下标
  late final int currentIndex = widget.navigationShell.currentIndex;
  late TabController tabController;
  late AnimationController stepButtonController;
  late Animation<double> stepButtonAnimation;
  late CurvedAnimation stepButtonCurve;

  @override
  void initState() {
    super.initState();
    tabController = .new(
      initialIndex: currentIndex,
      length: widget.navigationShell.route.branches.length,
      vsync: this,
    );
    stepButtonController = .new(duration: const .new(milliseconds: 500), vsync: this);
    stepButtonCurve = .new(parent: stepButtonController, curve: Curves.fastOutSlowIn);
    stepButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(stepButtonController);
  }

  @override
  void dispose() {
    tabController.dispose();
    stepButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    final zoomDrawer = ZoomDrawer.of(context);
    final statisticViewModel = context.read<StatisticViewModel>();
    const tabIconSize = 20.0;
    const tabIconMargin = EdgeInsets.only(bottom: 10.0);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
          boxShadow: [.new(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24)],
        ),
        child: SafeArea(
          child: Stack(
            alignment: .centerLeft,
            children: [
              /// 菜单
              TabBar(
                enableFeedback: true,
                padding: const .only(left: 40),
                controller: tabController,
                labelStyle: const .new(height: 0.5, fontSize: 10, fontWeight: .bold),
                unselectedLabelStyle: const .new(height: 0.5, fontSize: 10, fontWeight: .bold),
                tabs: [
                  Tab(
                    key: const .new('tab_home'),
                    text: appL10n.app_bottomNavigationBar_title_home,
                    iconMargin: tabIconMargin,
                    icon: const Icon(Remix.home_line, size: tabIconSize),
                  ),
                  Tab(
                    key: const .new('tab_mood'),
                    text: appL10n.app_bottomNavigationBar_title_mood,
                    iconMargin: tabIconMargin,
                    icon: const Icon(Remix.heart_3_line, size: tabIconSize),
                  ),
                  Tab(
                    key: const .new('tab_statistic'),
                    text: appL10n.app_bottomNavigationBar_title_statistic,
                    iconMargin: tabIconMargin,
                    icon: const Icon(Remix.bar_chart_line, size: tabIconSize),
                  ),
                ],
                onTap: (index) {
                  switch (index) {
                    case 2:
                      // 统计菜单触发
                      statisticViewModel.load();
                  }
                  widget.navigationShell.goBranch(index);
                },
              ),

              /// 侧栏
              Semantics(
                button: true,
                label: '打开设置',
                child: GestureDetector(
                  key: const .new('tab_screen_left'),
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black12 : AppTheme.staticBackgroundColor1,
                        borderRadius: const .only(
                          topRight: .circular(14),
                          bottomRight: .circular(14),
                        ),
                      ),
                      child: ValueListenableBuilder<DrawerState>(
                        valueListenable: zoomDrawer!.stateNotifier,
                        builder: (_, state, child) {
                          switch (state) {
                            case .closed:
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
                  ),
                  onTap: () => zoomDrawer.toggle.call(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
