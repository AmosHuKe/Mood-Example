import 'dart:math';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

import '../../../../widgets/action_button/action_button.dart';
import 'components/human_player.dart';
import 'components/light.dart';
import 'components/orc.dart';

class MiniFantasyScreen extends StatelessWidget {
  const MiniFantasyScreen({super.key});

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
          title: const Text('MiniFantasy'),
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
        body: const SafeArea(child: Game()),
      ),
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});
  static const assetsPath = 'game/mini_fantasy';

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
              directional: .new(margin: const .all(65)),
              actions: [.new(actionId: 1, color: Colors.deepOrange, margin: const .all(65))],
            ),
            Keyboard(config: .new(acceptedKeys: [.space])),
          ],
          map: WorldMapByTiled(
            WorldMapReader.fromAsset('$assetsPath/tiles/map.json'),
            forceTileSize: Vector2(tileSize, tileSize),
            objectsBuilder: {
              'light': (properties) => Light(properties.position, properties.size),
              'orc': (properties) => Orc(properties.position),
            },
          ),
          player: HumanPlayer(Vector2(4 * tileSize, 4 * tileSize)),
          cameraConfig: .new(zoom: 1),
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
                zoom: 0.8,
                margin: const .all(20),
                borderRadius: .circular(100),
                size: Vector2.all(constraints.maxHeight / 5),
                border: .all(color: Colors.white.withValues(alpha: 0.5)),
                playerColor: Colors.green,
                enemyColor: Colors.red,
                npcColor: Colors.red,
              );
            },
          },
          initialActiveOverlays: const ['miniMap'],
        );
      },
    );
  }
}
