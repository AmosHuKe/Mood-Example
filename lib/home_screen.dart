import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/views/statistic/index.dart' as statistic;
import 'package:moodexample/generated/l10n.dart';

import 'package:moodexample/views/home/index.dart';
import 'package:moodexample/views/mood/index.dart';
import 'package:moodexample/views/statistic/index.dart';

/// 首页底部Tabbar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// 当前页
  late int _currentPage = 0;

  /// 页面
  final List<Widget> _pages = [
    const HomePage(),
    const MoodPage(),
    const StatisticPage(),
  ];

  /// Tab 控制
  late final TabController _pageController = TabController(
    initialIndex: _currentPage,
    length: _pages.length,
    vsync: this,
  );

  /// PageView 控制
  final PageController _pageViewController = PageController();

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
    _stepButtonAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    /// 进步按钮Icon动画
    _stepButtonController.dispose();

    /// Tab控制
    _pageController.dispose();

    /// PageView控制
    _pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);

    /// Tab icon大小
    final double _tabIconSize = 20.sp;

    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
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
                padding: EdgeInsets.only(left: 40.w),
                controller: _pageController,
                indicatorColor: Colors.transparent,
                labelStyle: TextStyle(
                  height: 0.5.h,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  height: 0.5.h,
                  fontSize: 10.sp,
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
                onTap: (value) {
                  switch (value) {
                    case 2:
                      // 统计菜单触发
                      statistic.init(context);
                  }
                  _pageViewController.jumpToPage(value);
                  setState(() {
                    _currentPage = value;
                  });
                },
              ),

              /// 侧栏
              Semantics(
                button: true,
                label: '打开设置',
                child: GestureDetector(
                  key: const Key('tab_screen_left'),
                  child: Container(
                    width: 36.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: isDarkMode(context)
                          ? Colors.black12
                          : AppTheme.backgroundColor1,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14.sp),
                        bottomRight: Radius.circular(14.sp),
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
                            size: 14.sp,
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
                    vibrate();
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
