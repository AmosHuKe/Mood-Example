import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/app_theme.dart';

/// 外层抽屉菜单（左）
class MenuScreenLeft extends StatelessWidget {
  const MenuScreenLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
      orientation: Orientation.landscape,
    );
    return Scaffold(
      backgroundColor:
          isDarkMode(context) ? const Color(0xFF282C3A) : AppTheme.primaryColor,
      body: InkWell(
        child: const SafeArea(
          child: MenuScreenLeftBody(),
        ),
        onTap: () {
          ZoomDrawer.of(context)?.toggle.call();
        },
      ),
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
    return Row(
      children: [
        ClipRRect(
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
          ),
        ),
      ],
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
            "数据",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print("数据");
          },
        ),
        MenuList(
          icon: Icon(
            Remix.bubble_chart_line,
            size: _titleIconSize,
          ),
          title: Text(
            "主题",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print("主题");
          },
        ),
        MenuList(
          icon: Icon(
            Remix.global_line,
            size: _titleIconSize,
          ),
          title: Text(
            "语言",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print("语言");
          },
        ),
        MenuList(
          icon: Icon(
            Remix.flask_line,
            size: _titleIconSize,
          ),
          title: Text(
            "实验室",
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print("实验室");
          },
        ),
        MenuList(
          icon: Icon(
            Remix.heart_3_line,
            size: _titleIconSize,
          ),
          title: Text(
            '关于',
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print("关于");
          },
        ),
        // Container(
        //   width: 48.w,
        //   margin: EdgeInsets.only(left: 12.w),
        //   child: Divider(
        //     height: 24.w,
        //     color: Colors.black12,
        //   ),
        // ),
        // MenuList(
        //   icon: Icon(
        //     Remix.logout_circle_line,
        //     size: _titleIconSize,
        //   ),
        //   title: Text(
        //     '账户退出',
        //     style: TextStyle(
        //       fontSize: _titleTextSize,
        //     ),
        //   ),
        //   onTap: () {
        //     print("账户退出");
        //   },
        // ),

        /// 插画
        Padding(
          padding: EdgeInsets.only(top: 0.w),
          child: Image.asset(
            "assets/images/woolly/woolly-comet-2.png",
            width: 240.w,
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
    return ListTile(
      leading: icon,
      title: title,
      textColor: Colors.white,
      iconColor: Colors.white,
      minLeadingWidth: 0.w,
      horizontalTitleGap: 28.w,
      onTap: onTap,
    );
  }
}
