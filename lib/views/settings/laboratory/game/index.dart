import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moodexample/views/settings/laboratory/game/sprite_sheet/sprite_sheet_orc.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

import 'components/orc.dart';

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
    SpriteSheetOrc.load();
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
          title: const Text("游戏"),
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
          child: Game(),
        ),
      ),
    );
  }
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final tileSize = max(constraints.maxHeight, constraints.maxWidth) / 20;
      return BonfireTiledWidget(
        constructionMode: true,
        showCollisionArea: true,
        joystick: Joystick(
          keyboardConfig: KeyboardConfig(
            acceptedKeys: [
              LogicalKeyboardKey.space,
            ],
          ),
          directional: JoystickDirectional(),
          actions: [
            JoystickAction(
              actionId: 1,
              margin: const EdgeInsets.all(65),
            )
          ],
        ), // required
        map: TiledWorldMap('game/tiles/map.json', forceTileSize: Size(tileSize,tileSize),objectsBuilder: {
          'orc': (properties) => Orc(properties.position),
        },),
        player: Kinght(Vector2(4 * tileSize,4 * tileSize)),
        lightingColorGame: Colors.black.withOpacity(0.0),
        progress: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '载入中...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        overlayBuilderMap: {
          'miniMap': (context, game) => MiniMap(
            game: game,
            margin: EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(100),
            size: Vector2.all(constraints.maxHeight / 5),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            // backgroundColor: Color(),
            // tileCollisionColor: Color(),
            // tileColor: Color(),
            playerColor: Colors.red,
            // enemyColor: Color(),
            // npcColor: Color(),
            // allyColor: Color(),
            // decorationColor: Color(),
          ),
        },
        initialActiveOverlays: [
          'miniMap',
        ],
      );
    });
  }
}

class PlayerSpriteSheet {

  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
    "game/human_idle.png",
    SpriteAnimationData.sequenced(
      amount: 16,
      amountPerRow: 4,
      stepTime: 0.1,
      textureSize: Vector2(21, 21),
    ),
  );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
    "game/human_run.png",
    SpriteAnimationData.sequenced(
      amount: 4,
      amountPerRow: 4,
      stepTime: 0.1,
      textureSize: Vector2(21, 21),
    ),
  );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        runRight: runRight,
      );
}

class Kinght extends SimplePlayer {

  Kinght(Vector2 position)
      : super(
    position: position,
    size: Vector2(32,32),
    animation: PlayerSpriteSheet.simpleDirectionAnimation,
  );
}