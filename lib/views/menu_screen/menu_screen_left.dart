import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/widgets/show_modal_bottom_detail/show_modal_bottom_detail.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_theme.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_language.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_database.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_key.dart';
import 'package:moodexample/routes.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 外层抽屉菜单（左）
class MenuScreenLeft extends StatelessWidget {
  const MenuScreenLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        return Scaffold(
          backgroundColor: isDarkMode(context)
              ? Theme.of(context).primaryColor.withAlpha(155)
              : Theme.of(context).primaryColor,
          body: GestureDetector(
            child: const SafeArea(
              child: MenuScreenLeftBody(),
            ),
            onTap: () {
              ZoomDrawer.of(context)?.toggle.call();
            },
          ),
        );
      },
    );
  }
}

class MenuScreenLeftBody extends StatelessWidget {
  const MenuScreenLeftBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 72.w,
                bottom: 48.w,
                left: 24.w,
                right: 24.w,
              ),
              child: const Header(),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 24.w,
                left: 24.w,
                right: 24.w,
              ),
              child: const Menu(),
            ),
          ],
        ),
      ],
    );
  }
}

/// 头部
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: "关闭设置",
      child: Row(
        children: [
          ClipRRect(
            key: const Key("widget_menu_screen_left_logo"),
            borderRadius: BorderRadius.circular(14.sp),
            child: Image.asset(
              "assets/images/logo.png",
              width: 42.w,
              height: 42.w,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              "Mood",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel: "",
            ),
          ),
        ],
      ),
    );
  }
}

/// 菜单
class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  static final _titleTextSize = 14.sp;
  static final _titleIconSize = 20.sp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuList(
          icon: Icon(
            Remix.database_2_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_database,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("数据");

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingDatabase(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.shield_keyhole_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_security,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("安全");

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingKey(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.bubble_chart_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_theme,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("主题");

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingTheme(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.global_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_language,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("语言");

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingLanguage(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.flask_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_laboratory,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("实验室");
            Navigator.pushNamed(context, Routes.settingLaboratory);
          },
        ),
        MenuList(
          icon: Icon(
            Remix.heart_3_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_about,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            debugPrint("关于");
            Navigator.pushNamed(
              context,
              Routes.transformParams(
                router: Routes.webViewPage,
                params: [
                  ValueConvert("https://github.com/AmosHuKe/Mood-Example")
                      .encode()
                ],
              ),
            );
          },
        ),

        /// 插画
        BlockSemanticsToDrawerClosed(
          child: Container(
            padding: EdgeInsets.only(top: 0.w),
            child: Image.asset(
              "assets/images/woolly/woolly-comet-2.png",
              width: 240.w,
            ),
          ),
        ),
      ],
    );
  }
}

/// 菜单列表
class MenuList extends StatelessWidget {
  const MenuList({
    Key? key,
    this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  // 图标
  final Widget? icon;
  // 标题
  final Widget title;
  // 点击事件
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlockSemanticsToDrawerClosed(
      child: ListTile(
        leading: icon,
        title: title,
        textColor: Colors.white,
        iconColor: Colors.white,
        minLeadingWidth: 0.w,
        horizontalTitleGap: 28.w,
        onTap: onTap,
      ),
    );
  }
}

/// 侧栏关闭状态下就不显示语义
class BlockSemanticsToDrawerClosed extends StatelessWidget {
  const BlockSemanticsToDrawerClosed({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    /// 默认状态 为关闭
    ValueNotifier<DrawerState> drawerState = ValueNotifier(DrawerState.closed);
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier ?? drawerState,
      builder: (_, state, child) {
        return BlockSemantics(
          blocking: state == DrawerState.closed,
          child: child,
        );
      },
      child: child,
    );
  }
}
