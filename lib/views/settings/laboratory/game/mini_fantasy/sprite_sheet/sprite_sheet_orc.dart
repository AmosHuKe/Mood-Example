import 'package:bonfire/bonfire.dart';

class SpriteSheetOrc {
  static const assetsPath = 'game/mini_fantasy';
  static double animSpeed = 0.05;
  static late Image spriteSheetOrcRun;
  static late Image spriteSheetOrcAttack;
  static late Image spriteSheetOrcIdle;
  static late Image spriteSheetOrcDamage;
  static late Image spriteSheetOrcDie;

  static Future load() async {
    spriteSheetOrcRun = await Flame.images.load('$assetsPath/orc_run.png');
    spriteSheetOrcAttack = await Flame.images.load('$assetsPath/orc_attack.png');
    spriteSheetOrcIdle = await Flame.images.load('$assetsPath/orc_idle.png');
    spriteSheetOrcDamage = await Flame.images.load('$assetsPath/orc_damage.png');
    spriteSheetOrcDie = await Flame.images.load('$assetsPath/orc_die.png');
  }

  static Future<SpriteAnimation> getRunBottomRight() {
    return spriteSheetOrcRun.getAnimation(size: Vector2.all(21), amount: 4).asFuture();
  }

  static Future<SpriteAnimation> getRunBottomLeft() {
    return spriteSheetOrcRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 21))
        .asFuture();
  }

  static Future<SpriteAnimation> getRunTopRight() {
    return spriteSheetOrcRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 42))
        .asFuture();
  }

  static Future<SpriteAnimation> getRunTopLeft() {
    return spriteSheetOrcRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 63))
        .asFuture();
  }

  static Future<SpriteAnimation> getIdleBottomRight() {
    return spriteSheetOrcIdle.getAnimation(size: Vector2.all(21), amount: 16).asFuture();
  }

  static Future<SpriteAnimation> getIdleBottomLeft() {
    return spriteSheetOrcIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 21))
        .asFuture();
  }

  static Future<SpriteAnimation> getIdleTopRight() {
    return spriteSheetOrcIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 42))
        .asFuture();
  }

  static Future<SpriteAnimation> getIdleTopLeft() {
    return spriteSheetOrcIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 63))
        .asFuture();
  }

  static Future<SpriteAnimation> getAttackBottomRight() {
    return spriteSheetOrcAttack
        .getAnimation(size: Vector2.all(21), amount: 4, loop: false, stepTime: animSpeed)
        .asFuture();
  }

  static Future<SpriteAnimation> getAttackBottomLeft() {
    return spriteSheetOrcAttack
        .getAnimation(
          size: Vector2.all(21),
          amount: 4,
          position: Vector2(0, 21),
          loop: false,
          stepTime: animSpeed,
        )
        .asFuture();
  }

  static Future<SpriteAnimation> getAttackTopRight() {
    return spriteSheetOrcAttack
        .getAnimation(
          size: Vector2.all(21),
          amount: 4,
          position: Vector2(0, 42),
          loop: false,
          stepTime: animSpeed,
        )
        .asFuture();
  }

  static Future<SpriteAnimation> getAttackTopLeft() {
    return spriteSheetOrcAttack
        .getAnimation(
          size: Vector2.all(21),
          amount: 4,
          position: Vector2(0, 63),
          loop: false,
          stepTime: animSpeed,
        )
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageBottomRight() {
    return spriteSheetOrcDamage
        .getAnimation(size: Vector2.all(21), amount: 4, loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageBottomLeft() {
    return spriteSheetOrcDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 21), loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageTopRight() {
    return spriteSheetOrcDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 42), loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageTopLeft() {
    return spriteSheetOrcDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 63), loop: false)
        .asFuture();
  }

  /// 死亡动画
  static Future<SpriteAnimation> getDie() {
    return spriteSheetOrcDie
        .getAnimation(size: Vector2.all(21), amount: 12, loop: false)
        .asFuture();
  }
}
