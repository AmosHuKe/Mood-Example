import 'dart:math';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

import '../../../../widgets/action_button/action_button.dart';
import 'components/human_player.dart';
import 'components/light.dart';

class MiniGameScreen extends StatelessWidget {
  const MiniGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 按横屏计算
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
          title: const Text('MiniGame'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () async {
              await Flame.device.setPortrait();
              if (!context.mounted) return;
              context.pop();
            },
          ),
        ),
        body: const SafeArea(child: Game()),
      ),
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    const assetsPath = 'game/mini_game';

    return LayoutBuilder(
      builder: (context, constraints) {
        final tileSize = max(constraints.maxHeight, constraints.maxWidth) / 20;
        return BonfireWidget(
          debugMode: false,
          showCollisionArea: false,
          playerControllers: [
            Joystick(
              directional: JoystickDirectional(
                spriteBackgroundDirectional: Sprite.load('$assetsPath/joystick_background.png'),
                spriteKnobDirectional: Sprite.load('$assetsPath/joystick_knob.png'),
                size: 80,
                margin: const .only(bottom: 50, left: 50),
                isFixed: false,
              ),
              actions: [
                JoystickAction(
                  actionId: PlayerAttackType.attackMelee,
                  sprite: Sprite.load('$assetsPath/joystick_atack.png'),
                  spritePressed: Sprite.load('$assetsPath/joystick_atack_selected.png'),
                  size: 70,
                  margin: const .only(bottom: 50, right: 50),
                ),
                JoystickAction(
                  actionId: PlayerAttackType.attackRange,
                  sprite: Sprite.load('$assetsPath/joystick_atack_range.png'),
                  spritePressed: Sprite.load('$assetsPath/joystick_atack_range_selected.png'),
                  spriteBackgroundDirection: Sprite.load('$assetsPath/joystick_background.png'),
                  size: 40,
                  enableDirection: true,
                  margin: const .only(bottom: 30, right: 150),
                ),
                JoystickAction(
                  actionId: PlayerAttackType.attackRangeShotguns,
                  sprite: Sprite.load('$assetsPath/joystick_atack_range.png'),
                  spritePressed: Sprite.load('$assetsPath/joystick_atack_range_selected.png'),
                  spriteBackgroundDirection: Sprite.load('$assetsPath/joystick_background.png'),
                  size: 40,
                  enableDirection: true,
                  margin: const .only(bottom: 90, right: 150),
                ),
              ],
            ),
            Keyboard(config: .new(acceptedKeys: [.space])),
          ],
          map: WorldMapByTiled(
            .fromAsset('$assetsPath/tiles/mini_game_map.json'),
            forceTileSize: Vector2(tileSize, tileSize),
            objectsBuilder: {
              'light': (properties) => Light(position: properties.position, size: properties.size),
            },
          ),
          cameraConfig: .new(
            zoom: 1,
            moveOnlyMapArea: true,
            // smoothCameraEnabled: true,
            // smoothCameraSpeed: 2,
          ),
          player: HumanPlayer(Vector2(tileSize * 15, tileSize * 13)),
          lightingColorGame: Colors.black.withValues(alpha: 0.7),
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
                margin: const .all(20),
                borderRadius: .circular(100),
                size: Vector2.all(constraints.maxHeight / 3),
                zoom: 0.6,
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                enemyColor: Colors.red,
              );
            },
          },
          initialActiveOverlays: const ['miniMap'],
        );
      },
    );
  }
}
