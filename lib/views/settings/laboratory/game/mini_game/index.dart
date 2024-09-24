import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

import 'package:moodexample/themes/app_theme.dart';

import 'package:moodexample/widgets/action_button/action_button.dart';

import 'package:moodexample/views/settings/laboratory/game/mini_game/components/human_player.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_game/components/light.dart';

class MiniGamePage extends StatefulWidget {
  const MiniGamePage({super.key});

  @override
  State<MiniGamePage> createState() => _MiniGamePageState();
}

class _MiniGamePageState extends State<MiniGamePage> {
  @override
  Widget build(BuildContext context) {
    // 按横屏计算
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
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: const Text('MiniGame'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor1,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(18)),
            ),
            child: const Icon(
              Remix.arrow_left_line,
              size: 24,
            ),
            onTap: () async {
              await Flame.device.setPortrait();
              if (!mounted) return;
              context.pop();
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

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  static const assetsPath = 'game/mini_game';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileSize = max(constraints.maxHeight, constraints.maxWidth) / 20;
        return BonfireWidget(
          debugMode: false,
          showCollisionArea: false,
          playerControllers: [
            Joystick(
              directional: JoystickDirectional(
                spriteBackgroundDirectional:
                    Sprite.load('$assetsPath/joystick_background.png'),
                spriteKnobDirectional:
                    Sprite.load('$assetsPath/joystick_knob.png'),
                size: 80,
                margin: const EdgeInsets.only(bottom: 50, left: 50),
                isFixed: false,
              ),
              actions: [
                JoystickAction(
                  actionId: PlayerAttackType.attackMelee,
                  sprite: Sprite.load('$assetsPath/joystick_atack.png'),
                  spritePressed:
                      Sprite.load('$assetsPath/joystick_atack_selected.png'),
                  size: 70,
                  margin: const EdgeInsets.only(bottom: 50, right: 50),
                ),
                JoystickAction(
                  actionId: PlayerAttackType.attackRange,
                  sprite: Sprite.load('$assetsPath/joystick_atack_range.png'),
                  spritePressed: Sprite.load(
                    '$assetsPath/joystick_atack_range_selected.png',
                  ),
                  spriteBackgroundDirection:
                      Sprite.load('$assetsPath/joystick_background.png'),
                  size: 40,
                  enableDirection: true,
                  margin: const EdgeInsets.only(bottom: 30, right: 150),
                ),
                JoystickAction(
                  actionId: PlayerAttackType.attackRangeShotguns,
                  sprite: Sprite.load('$assetsPath/joystick_atack_range.png'),
                  spritePressed: Sprite.load(
                    '$assetsPath/joystick_atack_range_selected.png',
                  ),
                  spriteBackgroundDirection:
                      Sprite.load('$assetsPath/joystick_background.png'),
                  size: 40,
                  enableDirection: true,
                  margin: const EdgeInsets.only(bottom: 90, right: 150),
                ),
              ],
            ),
            Keyboard(
              config: KeyboardConfig(
                acceptedKeys: [
                  LogicalKeyboardKey.space,
                ],
              ),
            ),
          ],
          map: WorldMapByTiled(
            WorldMapReader.fromAsset('$assetsPath/tiles/mini_game_map.json'),
            forceTileSize: Vector2(tileSize, tileSize),
            objectsBuilder: {
              'light': (properties) => Light(
                    position: properties.position,
                    size: properties.size,
                  ),
            },
          ),
          cameraConfig: CameraConfig(
            zoom: 1,
            moveOnlyMapArea: true,
            // smoothCameraEnabled: true,
            // smoothCameraSpeed: 2,
          ),
          player: HumanPlayer(Vector2(tileSize * 15, tileSize * 13)),
          lightingColorGame: Colors.black.withOpacity(0.7),
          // progress: Container(
          //   color: Colors.black,
          //   child: const Center(
          //     child: Text(
          //       '载入中...',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
          overlayBuilderMap: {
            'miniMap': (context, game) {
              return MiniMap(
                game: game,
                margin: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(100),
                size: Vector2.all(constraints.maxHeight / 3),
                zoom: 0.6,
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                enemyColor: Colors.red,
              );
            },
          },
          initialActiveOverlays: const [
            'miniMap',
          ],
        );
      },
    );
  }
}
