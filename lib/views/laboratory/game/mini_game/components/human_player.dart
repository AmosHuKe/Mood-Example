import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_player.dart';
import '../sprite_sheet/sprite_sheet_fire_ball.dart';
import '../util/custom_sprite_animation_widget.dart';
import 'boss.dart';
import 'orc.dart';

const double tileSize = 20.0;

enum PlayerAttackType { attackMelee, attackRange, attackRangeShotguns }

class HumanPlayer extends SimplePlayer with BlockMovementCollision, Lighting, UseLifeBar {
  HumanPlayer(Vector2 position)
    : super(
        position: position,
        animation: .new(
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
    setupLighting(.new(radius: width * 2, blurBorder: width * 6, color: Colors.transparent));
    // 生命条
    setupLifeBar(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      barLifeDrawPosition: .top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withValues(alpha: 0.5),
      borderRadius: .circular(2),
      textOffset: Vector2(8, tileSize * 0.2),
    );
  }

  static const assetsPath = 'game/mini_game/player/human';

  /// 第一次游玩
  bool firstPlayer = false;

  /// 最大速度
  static double maxSpeed = tileSize * 5;

  /// 最大地图大小
  static int maxMapSize = 1200;

  /// 移动锁
  bool lockMove = false;

  /// 攻击
  bool executingRangeAttack = false;
  double radAngleRangeAttack = 0;
  bool executingRangeShotgunsAttack = false;
  double radAngleRangeShotgunsAttack = 0;

  @override
  Future<void> onLoad() {
    /// 设置碰撞系统
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.2, size.y * 0.4),
        position: Vector2(tileSize * 1.3, tileSize),
      ),
    );
    return super.onLoad();
  }

  /// 渲染
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (!isDead) {
      enemyOrcCreate(dt);
      enemyBossCreate(dt);
      firstPlayerSay();

      handleActionAttackRange(dt);
      handleActionAttackRangeShotguns(dt);
    }
    super.update(dt);
  }

  /// 碰撞触发
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    // Orc 不发生碰撞
    if (other is Orc) return;
    // Boss 不发生碰撞
    if (other is Boss) return;
    // 飞行道具不发生碰撞
    if (other is FlyingAttackGameObject) return;
    super.onCollision(points, other);
  }

  /// 操纵手柄操作控制
  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) return;

    /// 死亡 || 锁住移动
    if (isDead || lockMove) return;

    handleJoystickAction(event);
    super.onJoystickAction(event);
  }

  /// 操纵手柄操作控制
  void handleJoystickAction(JoystickActionEvent event) {
    /// 近战攻击
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == PlayerAttackType.attackMelee) &&
        event.event == .DOWN) {
      /// 攻击动画
      addAttackAnimation();

      /// 攻击范围
      simpleAttackMelee(damage: 50, size: Vector2.all(tileSize), withPush: false);
    }

    /// 远程攻击
    if (event.id == LogicalKeyboardKey.select.keyId || event.id == PlayerAttackType.attackRange) {
      if (event.event == .MOVE) {
        executingRangeAttack = true;
        radAngleRangeAttack = event.radAngle;
      }
      if (event.event == .UP) {
        executingRangeAttack = false;
      }
    }

    /// 远程混乱攻击
    if (event.id == LogicalKeyboardKey.select.keyId ||
        event.id == PlayerAttackType.attackRangeShotguns) {
      if (event.event == .MOVE) {
        executingRangeShotgunsAttack = true;
        radAngleRangeShotgunsAttack = event.radAngle;
      }
      if (event.event == .UP) {
        executingRangeShotgunsAttack = false;
      }
    }
  }

  /// 操纵杆控制
  @override
  void onJoystickChangeDirectional(JoystickDirectionalEvent event) {
    if (hasGameRef && gameRef.sceneBuilderStatus.isRunning) return;

    /// 死亡 || 锁住移动
    if (isDead || lockMove) return;

    speed = maxSpeed * event.intensity;
    super.onJoystickChangeDirectional(event);
  }

  /// 处理攻击
  @override
  bool handleAttack(AttackOriginEnum attacker, double damage, identify) {
    return super.handleAttack(attacker, damage, identify);
  }

  /// 受伤触发
  @override
  void onReceiveDamage(AttackOriginEnum attacker, double damage, dynamic from) {
    if (!isDead) {
      super.onReceiveDamage(attacker, damage, from);

      /// 伤害显示
      showDamage(
        damage,
        initVelocityVertical: -2,
        config: const TextStyle(color: Colors.white, fontSize: tileSize / 2),
      );
      // lockMove = true;
      /// 屏幕变红
      // gameRef.lighting
      //     ?.animateToColor(const Color.fromARGB(255, 26, 0, 0).withOpacity(0.7));
      // idle();
      // addDamageAnimation(() {
      //   lockMove = false;
      //   gameRef.lighting?.animateToColor(Colors.black.withOpacity(0.7));
      // });
    }
  }

  /// 死亡
  @override
  void onDie() {
    handleDie();
    super.onDie();
  }

  /// 第一次游玩对话
  void firstPlayerSay() {
    if (!firstPlayer) {
      firstPlayer = true;
      gameRef.camera.moveToTargetAnimated(
        target: this,
        onComplete: () {
          TalkDialog.show(gameRef.context, [
            Say(
              text: [
                const TextSpan(text: '你...好...陌...生...人...'),
                const TextSpan(
                  text: '  怪物已经向你冲来！！！',
                  style: .new(color: Colors.red),
                ),
              ],
              person: CustomSpriteAnimationWidget(animation: SpriteSheetPlayer.idleBottomRight),
              personSayDirection: .LEFT,
              speed: 100,
            ),
          ]);
        },
      );
    }
  }

  /// 死亡触发
  void handleDie() {
    final playerPosition = gameRef.player?.position ?? Vector2(position.x, position.y);
    gameRef.camera.moveToTargetAnimated(target: this, onComplete: () {});
    TalkDialog.show(gameRef.context, [
      Say(
        text: [const TextSpan(text: '恩... 好像失败了...')],
        person: CustomSpriteAnimationWidget(animation: SpriteSheetPlayer.getDamageTopRight()),
        personSayDirection: .LEFT,
        speed: 100,
      ),
    ]);
    animation?.playOnce(
      SpriteSheetPlayer.getDie(),
      onFinish: () {
        removeFromParent();
        gameRef.add(
          GameDecoration.withSprite(
            sprite: .load('$assetsPath/crypt.png'),
            position: playerPosition,
            size: Vector2.all(tileSize * 3.2),
          ),
        );
      },
      runToTheEnd: true,
    );
  }

  /// 敌对生物生成 Orc
  void enemyOrcCreate(double dt) {
    if (checkInterval('EnemyBossCreate', 1000, dt)) {
      print('怪物数量：${gameRef.enemies().length}');

      /// 限制数量
      if (gameRef.enemies().length >= 100) return;
      print('Orc 生成了');

      /// 生成
      for (var i = 0; i < 4; i++) {
        gameRef.add(
          Orc(
            Vector2(
              Random().nextDouble() * (maxMapSize - 100),
              Random().nextDouble() * (maxMapSize - 100),
            ),
          ),
        );
      }
    }
  }

  /// 敌对生物生成 Boss
  void enemyBossCreate(double dt) {
    if (checkInterval('EnemyBossCreate', 1000, dt)) {
      print('怪物数量：${gameRef.enemies().length}');

      /// 限制数量
      if (gameRef.enemies().length >= 100) return;
      print('Boss 生成了');

      /// 生成
      for (var i = 0; i < 2; i++) {
        gameRef.add(
          Boss(
            Vector2(
              Random().nextDouble() * (maxMapSize - 100),
              Random().nextDouble() * (maxMapSize - 100),
            ),
          ),
        );
      }
    }
  }

  /// 远程攻击
  void handleActionAttackRange(double dt) {
    /// 远程攻击触发（发射间隔）
    final execRangeAttackInterval = checkInterval('AttackRange', 150, dt);
    if (executingRangeAttack && execRangeAttackInterval) {
      actionAttackRange(radAngleRangeAttack);
    }
  }

  /// 远程混乱攻击
  void handleActionAttackRangeShotguns(double dt) {
    /// 远程混乱攻击触发（发射间隔）
    final execRangeShotgunsAttackInterval = checkInterval('AttackRangeShotguns', 50, dt);
    if (executingRangeShotgunsAttack && execRangeShotgunsAttackInterval) {
      actionAttackRangeShotguns(radAngleRangeShotgunsAttack);
    }
  }

  /// 远程攻击
  void actionAttackRange(double fireAngle) {
    simpleAttackRangeByAngle(
      animation: SpriteSheetFireBall.fireBallAttackRight(),
      animationDestroy: SpriteSheetFireBall.fireBallExplosion(),
      size: Vector2(tileSize * 2, tileSize * 2),
      angle: fireAngle + Random().nextDouble() * 0.3,
      withDecorationCollision: false,
      speed: maxSpeed * (tileSize / 10),
      damage: 50.0 + Random().nextInt(10),
      attackFrom: .PLAYER_OR_ALLY,
      marginFromOrigin: 30,
      collision: RectangleHitbox(
        size: Vector2(tileSize, tileSize),
        position: Vector2(tileSize, tileSize / 3),
      ),
      lightingConfig: .new(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withValues(alpha: 0.4),
      ),
    );
  }

  /// 远程混乱攻击
  void actionAttackRangeShotguns(double fireAngle) {
    simpleAttackRangeByAngle(
      animation: SpriteSheetFireBall.fireBallAttackRight(),
      animationDestroy: SpriteSheetFireBall.fireBallExplosion(),
      size: Vector2(tileSize * 2, tileSize * 2),
      angle: fireAngle + Random().nextDouble() * 1000,
      withDecorationCollision: false,
      speed: maxSpeed * (tileSize / 10),
      damage: 50.0 + Random().nextInt(20),
      attackFrom: .PLAYER_OR_ALLY,
      marginFromOrigin: 35,
      collision: RectangleHitbox(
        size: Vector2(tileSize, tileSize),
        position: Vector2(tileSize, tileSize / 3),
      ),
      lightingConfig: .new(
        radius: tileSize * 0.9,
        blurBorder: tileSize / 2,
        color: Colors.deepOrangeAccent.withValues(alpha: 0.4),
      ),
    );
  }

  /// 攻击动画
  void addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case .left:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
      case .right:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
      case .up:
        if (lastDirectionHorizontal == .left) {
          newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackTopRight();
        }
      case .down:
        if (lastDirectionHorizontal == .left) {
          newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        }
      case .upLeft:
        newAnimation = SpriteSheetPlayer.getAttackTopLeft();
      case .upRight:
        newAnimation = SpriteSheetPlayer.getAttackTopRight();
      case .downLeft:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
      case .downRight:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
    }
    animation?.playOnce(newAnimation);
  }

  /// 受伤动画
  void addDamageAnimation(VoidCallback onFinish) {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case .left:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
      case .right:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
      case .up:
        if (lastDirectionHorizontal == .left) {
          newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageTopRight();
        }
      case .down:
        if (lastDirectionHorizontal == .left) {
          newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        }
      case .upLeft:
        newAnimation = SpriteSheetPlayer.getDamageTopLeft();
      case .upRight:
        newAnimation = SpriteSheetPlayer.getDamageTopRight();
      case .downLeft:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
      case .downRight:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
    }
    animation?.playOnce(newAnimation, runToTheEnd: true, onFinish: onFinish);
  }
}
