// dart format width=80
import 'package:bonfire/bonfire.dart';

class SpriteSheetFireBall {
  static const assetsPath = 'game/mini_game/player/human';

  static Future<SpriteAnimation> fireBallAttackRight() => SpriteAnimation.load(
    '$assetsPath/fireball_right.png',
    .sequenced(amount: 3, stepTime: 0.1, textureSize: Vector2(23, 23)),
  );

  static Future<SpriteAnimation> fireBallAttackLeft() => SpriteAnimation.load(
    '$assetsPath/fireball_left.png',
    .sequenced(amount: 3, stepTime: 0.1, textureSize: Vector2(23, 23)),
  );

  static Future<SpriteAnimation> fireBallAttackTop() => SpriteAnimation.load(
    '$assetsPath/fireball_top.png',
    .sequenced(amount: 3, stepTime: 0.1, textureSize: Vector2(23, 23)),
  );

  static Future<SpriteAnimation> fireBallAttackBottom() => SpriteAnimation.load(
    '$assetsPath/fireball_bottom.png',
    .sequenced(amount: 3, stepTime: 0.1, textureSize: Vector2(23, 23)),
  );

  static Future<SpriteAnimation> fireBallExplosion() => SpriteAnimation.load(
    '$assetsPath/explosion_fire.png',
    .sequenced(amount: 6, stepTime: 0.1, textureSize: Vector2(32, 32)),
  );
}
