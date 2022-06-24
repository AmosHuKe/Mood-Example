import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/index.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/sprite_sheet/sprite_sheet_orc.dart'
    as mini_fantasy;
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/sprite_sheet/sprite_sheet_player.dart'
    as mini_fantasy;
import 'package:moodexample/views/settings/laboratory/game/mini_game/index.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_game/sprite_sheet/sprite_sheet_orc.dart'
    as mini_game;
import 'package:moodexample/views/settings/laboratory/game/mini_game/sprite_sheet/sprite_sheet_player.dart'
    as mini_game;

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text("游戏合集"),
          leading: ActionButton(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.backgroundColor1,
                    AppTheme.backgroundColor1
                  ],
                ),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(18.w))),
            child: Icon(
              Remix.arrow_left_line,
              size: 24.sp,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const SafeArea(
          child: UniMPMiniappsBody(),
        ),
      ),
    );
  }
}

class UniMPMiniappsBody extends StatefulWidget {
  const UniMPMiniappsBody({Key? key}) : super(key: key);

  @override
  State<UniMPMiniappsBody> createState() => _UniMPMiniappsBodyState();
}

class _UniMPMiniappsBodyState extends State<UniMPMiniappsBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w, bottom: 20.h),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 小程序
        ListCard(
          leading: Icon(
            Remix.gamepad_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "Mini Fantasy",
          subtitle: "2D 地牢风格游戏，基于 Mini Fantasy 示例，修改了一些奇怪的东西。",
          onPressed: () async {
            /// 载入游戏静态资源
            await mini_fantasy.SpriteSheetOrc.load();
            await mini_fantasy.SpriteSheetPlayer.load();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MiniFantasyPage(),
              ),
            );
          },
        ),
        ListCard(
          leading: Icon(
            Remix.gamepad_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "远程射击、怪物生成包围",
          subtitle: "灵感来源：《20 Minutes Till Dawn》，素材来源：Mini Fantasy",
          onPressed: () async {
            /// 载入游戏静态资源
            await mini_game.SpriteSheetOrc.load();
            await mini_game.SpriteSheetPlayer.load();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MiniGamePage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    required this.title,
    required this.subtitle,
    required this.leading,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 图标
  final Widget leading;

  /// 点击打开触发
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12.w, bottom: 12.w),
      shadowColor: Colors.black38,
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(48.sp)),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          children: [
            ListTile(
              leading: leading,
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: const Text('打开'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
