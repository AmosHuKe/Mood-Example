import 'package:bonfire/bonfire.dart';

class SpriteSheetPlayer {
  static const assetsPath = 'game/mini_game/player/human';
  static double animSpeed = 0.05;
  static late Image spriteSheetPlayerRun;
  static late Image spriteSheetPlayerAttack;
  static late Image spriteSheetPlayerIdle;
  static late Image spriteSheetPlayerDie;
  static late Image spriteSheetPlayerDamage;
  static late Future<SpriteAnimation> runTopLeft;
  static late Future<SpriteAnimation> runTopRight;
  static late Future<SpriteAnimation> runBottomRight;
  static late Future<SpriteAnimation> runBottomLeft;
  static late Future<SpriteAnimation> idleBottomRight;
  static late Future<SpriteAnimation> idleBottomLeft;
  static late Future<SpriteAnimation> idleTopRight;
  static late Future<SpriteAnimation> idleTopLeft;

  static Future load() async {
    spriteSheetPlayerRun = await Flame.images.load('$assetsPath/human_run.png');
    spriteSheetPlayerAttack = await Flame.images.load('$assetsPath/human_attack.png');
    spriteSheetPlayerIdle = await Flame.images.load('$assetsPath/human_idle.png');
    spriteSheetPlayerDie = await Flame.images.load('$assetsPath/human_die.png');
    spriteSheetPlayerDamage = await Flame.images.load('$assetsPath/human_damage.png');
    runBottomRight = spriteSheetPlayerRun.getAnimation(size: Vector2.all(21), amount: 4).asFuture();
    runBottomLeft = spriteSheetPlayerRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 21))
        .asFuture();
    runTopRight = spriteSheetPlayerRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 42))
        .asFuture();
    runTopLeft = spriteSheetPlayerRun
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 63))
        .asFuture();

    idleBottomRight = spriteSheetPlayerIdle
        .getAnimation(size: Vector2.all(21), amount: 16)
        .asFuture();
    idleBottomLeft = spriteSheetPlayerIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 21))
        .asFuture();

    idleTopRight = spriteSheetPlayerIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 42))
        .asFuture();

    idleTopLeft = spriteSheetPlayerIdle
        .getAnimation(size: Vector2.all(21), amount: 16, position: Vector2(0, 63))
        .asFuture();

    return Future.value();
  }

  static Future<SpriteAnimation> getAttackBottomRight() {
    return spriteSheetPlayerAttack
        .getAnimation(size: Vector2.all(21), amount: 4, loop: false, stepTime: animSpeed)
        .asFuture();
  }

  static Future<SpriteAnimation> getAttackBottomLeft() {
    return spriteSheetPlayerAttack
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
    return spriteSheetPlayerAttack
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
    return spriteSheetPlayerAttack
        .getAnimation(
          size: Vector2.all(21),
          amount: 4,
          position: Vector2(0, 63),
          loop: false,
          stepTime: animSpeed,
        )
        .asFuture();
  }

  static Future<SpriteAnimation> getDie() {
    return spriteSheetPlayerDie
        .getAnimation(size: Vector2.all(21), amount: 12, loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageTopRight() {
    return spriteSheetPlayerDamage
        .getAnimation(size: Vector2.all(21), amount: 4, loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageTopLeft() {
    return spriteSheetPlayerDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 21), loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageBottomRight() {
    return spriteSheetPlayerDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 42), loop: false)
        .asFuture();
  }

  static Future<SpriteAnimation> getDamageBottomLeft() {
    return spriteSheetPlayerDamage
        .getAnimation(size: Vector2.all(21), amount: 4, position: Vector2(0, 63), loop: false)
        .asFuture();
  }
}
