// dart format width=80
import 'package:bonfire/bonfire.dart';

class SpriteSheetBoss {
  static const assetsPath = 'game/mini_game/enemy/boss';

  static Future<SpriteAnimation> bossIdleRight() => SpriteAnimation.load(
    '$assetsPath/boss_idle.png',
    .sequenced(amount: 4, stepTime: 0.1, textureSize: Vector2(32, 36)),
  );

  static SimpleDirectionAnimation bossAnimations() => .new(
    idleLeft: SpriteAnimation.load(
      '$assetsPath/boss_idle_left.png',
      .sequenced(amount: 4, stepTime: 0.1, textureSize: Vector2(32, 36)),
    ),
    idleRight: bossIdleRight(),
    runLeft: SpriteAnimation.load(
      '$assetsPath/boss_run_left.png',
      .sequenced(amount: 4, stepTime: 0.1, textureSize: Vector2(32, 36)),
    ),
    runRight: SpriteAnimation.load(
      '$assetsPath/boss_run_right.png',
      .sequenced(amount: 4, stepTime: 0.1, textureSize: Vector2(32, 36)),
    ),
  );
}
