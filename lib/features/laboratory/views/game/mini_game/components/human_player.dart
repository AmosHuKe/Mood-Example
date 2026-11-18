import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../../shared/utils/log_utils.dart';
import '../sprite_sheet/sprite_sheet_fire_ball.dart';
import '../sprite_sheet/sprite_sheet_player.dart';
// import '../util/custom_sprite_animation_widget.dart';
import 'boss.dart';
import 'orc.dart';

const double tileSize = 20.0;

enum PlayerAttackType { attackMelee, attackRange, attackRangeShotguns }

class HumanPlayer extends SimplePlayer
    with WithCollision, WithLighting, WithLifeBar, WithAttack, WithLife {
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
    lighting.setup(.new(radius: width * 2, blurBorder: width * 6, color: Colors.transparent));
    // 生命条
    lifeBar.setup(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      drawPosition: .top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withValues(alpha: 0.5),
      borderRadius: .circular(2),
      textOffset: Vector2(8, tileSize * 0.2),
    );

    life.onDieListener(_onDie);
    life.onRemoveLifeListener(_onReceiveDamage);
  }

  static const assetsPath = 'game/mini_game/player/human';

  /// 第一次游玩
  bool firstPlay = false;

  /// 最大速度
  static double maxSpeed = tileSize * 5;

  /// 最大地图大小
  static int maxMapSize = 1200;

  /// 移动锁
  bool lockMove = false;

  /// 攻击
  final _attackRangeTick = IntervalTick(150);
  bool executingRangeAttack = false;
  double radAngleRangeAttack = 0;
  final _attackRangeShotgunsTick = IntervalTick(50);
  bool executingRangeShotgunsAttack = false;
  double radAngleRangeShotgunsAttack = 0;

  final _enemyOrcCreateTick = IntervalTick(1000);
  final _enemyBossCreateTick = IntervalTick(1000);

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
      // firstPlaySay();

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
      attack.melee(damage: 50, size: Vector2.all(tileSize), withPush: false);
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

  /// 受伤触发
  void _onReceiveDamage(double amount) {
    if (!isDead) {
      /// 伤害显示
      util.showDamage(
        amount,
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
  void _onDie() {
    handleDie();
  }

  /// 第一次游玩对话
  void firstPlaySay() {
    if (!firstPlay) {
      firstPlay = true;
      gameRef.camera.moveToTargetAnimated(
        target: this,
        onComplete: () {
          // TODO: 等 package 迁移至 material_ui 再使用
          // TalkDialog.show(gameRef.context, [
          //   Say(
          //     text: [
          //       const TextSpan(text: '你...好...陌...生...人...'),
          //       const TextSpan(
          //         text: '  怪物已经向你冲来！！！',
          //         style: .new(color: Colors.red),
          //       ),
          //     ],
          //     person: CustomSpriteAnimationWidget(animation: SpriteSheetPlayer.idleBottomRight),
          //     personSayDirection: .LEFT,
          //     speed: 100,
          //   ),
          // ]);
        },
      );
    }
  }

  /// 死亡触发
  void handleDie() {
    final playerPosition = gameRef.player?.position ?? Vector2(position.x, position.y);
    gameRef.camera.moveToTargetAnimated(target: this, onComplete: () {});
    // TODO: 等 package 迁移至 material_ui 再使用
    // TalkDialog.show(gameRef.context, [
    //   Say(
    //     text: [const TextSpan(text: '恩... 好像失败了...')],
    //     person: CustomSpriteAnimationWidget(animation: SpriteSheetPlayer.getDamageTopRight()),
    //     personSayDirection: .LEFT,
    //     speed: 100,
    //   ),
    // ]);
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
    if (_enemyOrcCreateTick.update(dt)) {
      Log.instance.info('怪物数量：${gameRef.enemies().length}');

      /// 限制数量
      if (gameRef.enemies().length >= 100) return;
      Log.instance.info('Orc 生成了');

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
    if (_enemyBossCreateTick.update(dt)) {
      Log.instance.info('怪物数量：${gameRef.enemies().length}');

      /// 限制数量
      if (gameRef.enemies().length >= 100) return;
      Log.instance.info('Boss 生成了');

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
    if (executingRangeAttack && _attackRangeTick.update(dt)) {
      actionAttackRange(radAngleRangeAttack);
    }
  }

  /// 远程混乱攻击
  void handleActionAttackRangeShotguns(double dt) {
    /// 远程混乱攻击触发（发射间隔）
    if (executingRangeShotgunsAttack && _attackRangeShotgunsTick.update(dt)) {
      actionAttackRangeShotguns(radAngleRangeShotgunsAttack);
    }
  }

  /// 远程攻击
  void actionAttackRange(double fireAngle) {
    attack.rangeByAngle(
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
    attack.rangeByAngle(
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
    switch (direction) {
      case .left:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
      case .right:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
      case .up:
        if (hDirection == .left) {
          newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackTopRight();
        }
      case .down:
        if (hDirection == .left) {
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
    switch (direction) {
      case .left:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
      case .right:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
      case .up:
        if (hDirection == .left) {
          newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageTopRight();
        }
      case .down:
        if (hDirection == .left) {
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
