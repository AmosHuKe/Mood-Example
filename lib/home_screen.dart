import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/views/statistic/index.dart' as statistic;
import 'package:moodexample/generated/l10n.dart';

/// 页面
import 'package:moodexample/views/home/index.dart';
import 'package:moodexample/views/mood/index.dart';
import 'package:moodexample/views/statistic/index.dart';

/// 首页底部Tabbar
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  /// Tab控制
  late TabController _pageController;

  /// 进步按钮动画
  late AnimationController _stepButtonController;
  late Animation<double> _stepButtonAnimation;
  late CurvedAnimation _stepButtonCurve;

  /// 默认状态 为关闭
  ValueNotifier<DrawerState> drawerState = ValueNotifier(DrawerState.closed);

  /// Tab icon大小
  final double _tabIconSize = 20.sp;

  /// 当前页
  late int _currentPage = 0;

  /// 页面
  final List<Widget> pages = [
    /// 首页
    const HomePage(),
    const MoodPage(),
    const StatisticPage(),
  ];

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

    /// Tab控制
    _pageController = TabController(
      initialIndex: _currentPage,
      length: pages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    /// 进步按钮Icon动画
    _stepButtonController.dispose();

    /// Tab控制
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    ThemeData appTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).tabBarTheme.labelColor,
      body: IndexedStack(
        index: _currentPage,
        children: pages,
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
            appTheme.bottomNavigationBarTheme.backgroundColor ?? Colors.white,
          ]),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            /// 菜单
            TabBar(
              // 震动或声音反馈
              enableFeedback: true,
              padding: EdgeInsets.only(left: 40.w, right: 0.w),
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
                /// 菜单
                Tab(
                  text: S.of(context).app_bottomNavigationBar_title_home,
                  icon: Icon(
                    Remix.home_line,
                    size: _tabIconSize,
                  ),
                ),
                Tab(
                  text: S.of(context).app_bottomNavigationBar_title_mood,
                  icon: Icon(
                    Remix.heart_3_line,
                    size: _tabIconSize,
                  ),
                ),
                Tab(
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
                    break;
                }
                setState(() {
                  _currentPage = value;
                });
              },
            ),

            // 侧栏
            InkWell(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode(context)
                        ? [
                            Colors.black12,
                            Colors.black12,
                          ]
                        : [
                            AppTheme.backgroundColor1,
                            AppTheme.backgroundColor1,
                          ],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.sp),
                    bottomRight: Radius.circular(14.sp),
                  ),
                ),
                child: SizedBox(
                  width: 36.w,
                  height: 42.w,
                  child: ValueListenableBuilder<DrawerState>(
                    valueListenable:
                        ZoomDrawer.of(context)!.stateNotifier ?? drawerState,
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
              ),
              onTap: () {
                /// 侧栏
                vibrate();
                ZoomDrawer.of(context)?.toggle.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
