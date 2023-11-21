import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

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
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text('游戏合集'),
          leading: ActionButton(
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor1,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(18.w)),
            ),
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
  const UniMPMiniappsBody({super.key});

  @override
  State<UniMPMiniappsBody> createState() => _UniMPMiniappsBodyState();
}

class _UniMPMiniappsBodyState extends State<UniMPMiniappsBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.w,
        bottom: 20.h,
      ),
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
          title: 'Mini Fantasy',
          subtitle: '2D 地牢风格游戏，基于 Mini Fantasy 示例，修改了一些奇怪的东西。',
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
          title: '疯狂射击、怪物生成',
          subtitle:
              '素材来源：https://github.com/RafaelBarbosatec/mini_fantasy、https://0x72.itch.io/dungeontileset-ii',
          onPressed: () async {
            /// 横屏
            await Flame.device.setLandscape();

            /// 载入游戏静态资源
            await mini_game.SpriteSheetPlayer.load();
            await mini_game.SpriteSheetOrc.load();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PopScope(
                  canPop: false,
                  onPopInvoked: (bool didPop) async {
                    if (didPop) return;
                    // 竖屏
                    await Flame.device.setPortrait();
                  },
                  child: const MiniGamePage(),
                ),
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
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    this.onPressed,
  });

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 图标
  final Widget leading;

  /// 点击打开触发
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.w),
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
