import 'package:flutter/material.dart';

/// Package
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
import 'app_theme.dart';
import 'package:moodexample/db/db.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/widgets/will_pop_scope_route/will_pop_scope_route.dart';
import 'package:moodexample/home_screen.dart';

/// view_model
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';
import 'package:moodexample/view_models/statistic/statistic_view_model.dart';

/// 页面
import 'package:moodexample/views/menu_screen/menu_screen_left.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    /// 路由
    final router = FluroRouter();
    Routes.configureRoutes(router);

    return MultiProvider(
      /// 状态管理
      providers: [
        ChangeNotifierProvider(create: (_) => MoodViewModel()),
        ChangeNotifierProvider(
          create: (_) => MoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => StatisticViewModel(),
        ),
      ],
      child: MaterialApp(
        /// 网格
        debugShowMaterialGrid: false,

        /// Debug标志
        debugShowCheckedModeBanner: false,

        /// 打开性能监控，覆盖在屏幕最上面
        showPerformanceOverlay: false,

        /// 主题
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        /// 路由钩子
        onGenerateRoute: router.generator,

        /// Home
        home: const WillPopScopeRoute(child: Init()),
      ),
    );
  }
}

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  /// 应用初始化
  void init(context) async {
    /// 初始化数据库
    await DB.db.database;
    MoodViewModel _moodViewModel =
        Provider.of<MoodViewModel>(context, listen: false);

    /// 设置心情类别默认值
    final bool setMoodCategoryDefaultresult =
        await MoodViewModel().setMoodCategoryDefault();
    if (setMoodCategoryDefaultresult) {
      /// 获取所有心情类别
      MoodService.getMoodCategoryAll(_moodViewModel);
    }
  }

  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const MenuPage();
  }
}

/// 外层抽屉菜单
class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    /// 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
      orientation: Orientation.landscape,
    );
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: const MenuScreenLeft(),
      mainScreen: const MainScreenBody(),
      borderRadius: 36.w,
      showShadow: true,
      disableGesture: false,
      openCurve: Curves.easeOut,
      closeCurve: Curves.fastOutSlowIn,
      backgroundColor: Colors.white38,
      angle: 0,
      swipeOffset: 3.0,
      mainScreenScale: 0.3,
      slideWidth: MediaQuery.of(context).size.width * 0.70,
      style: DrawerStyle.Style1,
    );
  }
}

/// 主屏幕逻辑
class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
  /// 默认状态 为关闭
  ValueNotifier<DrawerState> drawerState = ValueNotifier(DrawerState.closed);
  @override
  Widget build(BuildContext context) {
    /// 监听状态进行改变
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier ?? drawerState,
      builder: (_, state, child) {
        print("外层菜单状态：" + state.toString());
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
