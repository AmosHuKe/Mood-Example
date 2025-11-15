import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

import '../../../router.dart';
import '../../../widgets/action_button/action_button.dart';
import 'mini_fantasy/sprite_sheet/sprite_sheet_orc.dart' as mini_fantasy;
import 'mini_fantasy/sprite_sheet/sprite_sheet_player.dart' as mini_fantasy;
import 'mini_game/sprite_sheet/sprite_sheet_orc.dart' as mini_game;
import 'mini_game/sprite_sheet/sprite_sheet_player.dart' as mini_game;

import '../laboratory.dart' show OpenCard;

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: .new(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F3),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF1F2F3),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const .new(color: Colors.black, fontSize: 14),
          title: const Text('游戏合集'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: const SafeArea(child: GameBody()),
      ),
    );
  }
}

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .only(left: 24, right: 24, top: 24, bottom: 20),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        OpenCard(
          icon: Remix.gamepad_line,
          title: 'Mini Fantasy',
          subtitle: '2D 地牢风格游戏，基于 Mini Fantasy 示例，修改了一些奇怪的东西。',
          onTap: () async {
            /// 载入游戏静态资源
            await mini_fantasy.SpriteSheetOrc.load();
            await mini_fantasy.SpriteSheetPlayer.load();
            if (!context.mounted) return;
            GoRouter.of(context).pushNamed(Routes.laboratoryGameMiniFantasy);
          },
        ),
        OpenCard(
          icon: Remix.gamepad_line,
          title: '疯狂射击、怪物生成',
          subtitle:
              '素材来源：https://github.com/RafaelBarbosatec/mini_fantasy、https://0x72.itch.io/dungeontileset-ii',
          onTap: () async {
            /// 横屏
            await Flame.device.setLandscape();

            /// 载入游戏静态资源
            await mini_game.SpriteSheetPlayer.load();
            await mini_game.SpriteSheetOrc.load();
            if (!context.mounted) return;
            GoRouter.of(context).pushNamed(Routes.laboratoryGameMiniGame);
          },
        ),
      ],
    );
  }
}
