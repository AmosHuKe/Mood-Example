import 'dart:async' as async;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_player.dart';
import 'boss.dart';
import 'orc.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_game/sprite_sheet/sprite_sheet_fire_ball.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_game/util/custom_sprite_animation_widget.dart';

double tileSize = 20.0;

class HumanPlayer extends SimplePlayer with Lighting, ObjectCollision {
  static const assetsPath = 'game/mini_game/player/human';

  /// 第一次游玩
  bool firstPlayer = false;

  /// 最大速度
  static double maxSpeed = tileSize * 10;

  /// Orc 敌对生物生成延迟时间
  async.Timer? _timerEnemyOrc;

  /// Boss 敌对生物生成延迟时间
  async.Timer? _timerEnemyBoss;

  /// 火球发射间隔
  async.Timer? _timerFireBall;

  /// 移动锁
  bool lockMove = false;

  HumanPlayer(Vector2 position)
      : super(
          position: position,
          animation: SimpleDirectionAnimation(
            idleLeft: SpriteSheetPlayer.idleBottomLeft,
            idleRight: SpriteSheetPlayer.idleBottomRight,
            idleUp: SpriteSheetPlayer.idleTopRight,
            idleUpLeft: SpriteSheetPlayer.idleTopLeft,
            idleUpRight: SpriteSheetPlayer.idleTopRight,
            runLeft: SpriteSheetPlayer.runBottomLeft,
            runRight: SpriteSheetPlayer.runBottomRight,
            runUpLeft: SpriteSheetPlayer.runTopLeft,
            runUpRight: SpriteSheetPlayer.runTopRight,
            runDownLeft: SpriteSheetPlayer.runBottomLeft,
            runDownRight: SpriteSheetPlayer.runBottomRight,
          ),
          speed: maxSpeed,
          life: 500,
          size: Vector2.all(tileSize * 3.2),
        ) {
    /// 发光
    setupLighting(
      LightingConfig(
        radius: width * 2,
        blurBorder: width * 10,
        color: Colors.transparent,
      ),
    );

    /// 碰撞
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(size.x * 0.2, size.y * 0.2),
            align: Vector2(tileSize * 1.3, tileSize * 1.4),
          ),
        ],
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    if (isDead) return;

    /// 生命条
    drawDefaultLifeBar(
      canvas,
      drawInBottom: true,
      margin: 0,
      width: tileSize * 1.5,
      height: tileSize / 5,
      borderRadius: BorderRadius.circular(2),
      align: Offset(
        tileSize * 0.7,
        tileSize * 2.7,
      ),
    );
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (isDead) return;
    _enemyOrcCreate();
    _enemyBossCreate();
    _firstPlayerSay();
    super.update(dt);
  }

  /// 碰撞触发
  @override
  bool onCollision(GameComponent component, bool active) {
    bool active = true;

    /// Orc 不发生碰撞
    if (component is Orc) {
      active = false;
    }
    if (component is FlyingAttackObject) {
      active = false;
    }
    return active;
  }

  /// 操纵手柄操作控制
  @override
  void joystickAction(JoystickActionEvent event) {
    /// 死亡 || 锁住移动
    if (isDead || lockMove) return;

    /// 近战攻击
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == 1) &&
        event.event == ActionEvent.DOWN) {
      /// 攻击动画
      _addAttackAnimation();

      /// 攻击范围
      simpleAttackMelee(
        damage: 10,
        size: Vector2.all(tileSize * 1.5),
        withPush: false,
      );
    }

    /// 远程攻击
    if ((event.id == LogicalKeyboardKey.select.keyId || event.id == 2) &&
        event.event == ActionEvent.MOVE) {
      _actionAttackRange(event.radAngle);
    }
    super.joystickAction(event);
  }

  /// 操纵杆控制
  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (lockMove || isDead) {
      return;
    }
    speed = maxSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  /// 第一次游玩对话
  void _firstPlayerSay() {
    if (!firstPlayer) {
      firstPlayer = true;
      gameRef.camera.moveToTargetAnimated(
        this,
        finish: () {
          TalkDialog.show(
            gameRef.context,
            [
              Say(
                text: [
                  const TextSpan(text: "你...好...陌...生...人..."),
                  const TextSpan(
                    text: "  怪物已经向你冲来！！！",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
                person: CustomSpriteAnimationWidget(
                  animation: SpriteSheetPlayer.idleBottomRight,
                ),
                personSayDirection: PersonSayDirection.LEFT,
                speed: 100,
              ),
            ],
          );
        },
      );
    }
  }

  /// 敌对生物生成 Orc
  void _enemyOrcCreate() {
    if (_timerEnemyOrc == null) {
      _timerEnemyOrc = async.Timer(const Duration(milliseconds: 500), () {
        _timerEnemyOrc = null;
      });
    } else {
      return;
    }
    debugPrint('Orc 生成了');

    /// 生成
    gameRef.add(
      Orc(
        Vector2(
          Random().nextInt(300) + 100,
          Random().nextInt(300) + 100,
        ),
      ),
    );
  }

  /// 敌对生物生成 Boss
  void _enemyBossCreate() {
    if (_timerEnemyBoss == null) {
      _timerEnemyBoss = async.Timer(const Duration(milliseconds: 12000), () {
        _timerEnemyBoss = null;
      });
    } else {
      return;
    }
    debugPrint('Boss 生成了');

    /// 生成
    gameRef.add(
      Boss(
        Vector2(
          Random().nextInt(3700) + 100,
          Random().nextInt(3700) + 100,
        ),
      ),
    );
  }

  /// 受伤触发
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic from) {
    if (!isDead) {
      showDamage(
        damage,
        initVelocityTop: -2,
        config: TextStyle(color: Colors.white, fontSize: tileSize / 2),
      );
      // lockMove = true;
      /// 屏幕变红
      gameRef.lighting?.animateToColor(
          const Color.fromARGB(255, 26, 0, 0).withOpacity(0.7));
      idle();
      _addDamageAnimation(() {
        lockMove = false;
        gameRef.lighting?.animateToColor(Colors.black.withOpacity(0.7));
      });
    }
    super.receiveDamage(attacker, damage, from);
  }

  /// 死亡
  @override
  void die() {
    Vector2 playerPosition =
        gameRef.player?.position ?? Vector2(position.x, position.y);
    gameRef.camera.moveToTargetAnimated(this, finish: () {});
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            const TextSpan(text: "恩... 好像失败了..."),
          ],
          person: CustomSpriteAnimationWidget(
            animation: SpriteSheetPlayer.getDamageTopRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
          speed: 100,
        ),
      ],
    );
    gameRef.add(
      GameDecoration.withSprite(
        sprite: Sprite.load('$assetsPath/crypt.png'),
        position: playerPosition,
        size: Vector2.all(tileSize * 3.2),
      ),
    );
    animation?.playOnce(
      SpriteSheetPlayer.getDie(),
      onFinish: () {
        removeFromParent();
      },
      runToTheEnd: true,
    );
    super.die();
  }

  /// 远程攻击
  void _actionAttackRange(double fireAngle) {
    if (_timerFireBall == null) {
      _timerFireBall = async.Timer(const Duration(milliseconds: 50), () {
        _timerFireBall = null;
      });
    } else {
      return;
    }
    simpleAttackRangeByAngle(
      animation: SpriteSheetFireBall.fireBallAttackRight(),
      animationDestroy: SpriteSheetFireBall.fireBallExplosion(),
      size: Vector2(tileSize * 2, tileSize * 2),
      angle: fireAngle + Random().nextDouble() * 0.3,
      withDecorationCollision: false,
      speed: maxSpeed * (tileSize / 10),
      damage: 25.0 + Random().nextInt(10),
      attackFrom: AttackFromEnum.PLAYER_OR_ALLY,
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize / 1.1, tileSize / 1.1),
            align: Vector2(tileSize * 1, tileSize / (4 - fireAngle)),
          ),
        ],
      ),
      lightingConfig: LightingConfig(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withOpacity(0.4),
      ),
    );
    // simpleAttackRange(
    //   animationRight: SpriteSheetFireBall.fireBallAttackRight(),
    //   animationLeft: SpriteSheetFireBall.fireBallAttackLeft(),
    //   animationUp: SpriteSheetFireBall.fireBallAttackTop(),
    //   animationDown: SpriteSheetFireBall.fireBallAttackBottom(),
    //   animationDestroy: SpriteSheetFireBall.fireBallExplosion(),
    //   size: Vector2(tileSize * 2, tileSize * 2),
    //   damage: 25.0 + Random().nextInt(10),
    //   speed: maxSpeed * (tileSize / 10),
    //   enableDiagonal: false,
    //   withCollision: true,
    //   onDestroy: () {
    //     debugPrint('火球消失');
    //   },
    //   collision: CollisionConfig(
    //     collisions: [
    //       CollisionArea.rectangle(size: Vector2(tileSize / 2, tileSize / 2)),
    //     ],
    //   ),
    //   lightingConfig: LightingConfig(
    //     radius: tileSize * 0.9,
    //     blurBorder: tileSize / 2,
    //     color: Colors.deepOrangeAccent.withOpacity(0.4),
    //   ),
    // );
  }

  /// 攻击动画
  void _addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackTopRight();
        }

        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetPlayer.getAttackTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        break;
    }
    animation?.playOnce(newAnimation);
  }

  /// 受伤动画
  void _addDamageAnimation(VoidCallback onFinish) {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageTopRight();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetPlayer.getDamageTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: onFinish,
    );
  }
}
