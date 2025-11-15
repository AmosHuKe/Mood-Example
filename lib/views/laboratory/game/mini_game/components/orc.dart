import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_orc.dart';
import 'boss.dart';

const double tileSize = 20.0;

class Orc extends SimpleEnemy with RandomMovement, BlockMovementCollision, UseLifeBar {
  Orc(Vector2 position)
    : super(
        position: position,
        animation: .new(
          idleLeft: SpriteSheetOrc.getIdleBottomLeft(),
          idleRight: SpriteSheetOrc.getIdleBottomRight(),
          idleDownRight: SpriteSheetOrc.getIdleBottomRight(),
          idleDownLeft: SpriteSheetOrc.getIdleBottomLeft(),
          idleUpRight: SpriteSheetOrc.getIdleTopRight(),
          idleUpLeft: SpriteSheetOrc.getIdleTopLeft(),
          idleUp: SpriteSheetOrc.getIdleTopRight(),
          idleDown: SpriteSheetOrc.getIdleBottomRight(),
          runLeft: SpriteSheetOrc.getRunBottomLeft(),
          runRight: SpriteSheetOrc.getRunBottomRight(),
          runUpLeft: SpriteSheetOrc.getRunTopLeft(),
          runUpRight: SpriteSheetOrc.getRunTopRight(),
        ),
        speed: tileSize * 0.1 + Random().nextInt(60),
        size: Vector2.all(tileSize * 5),
      ) {
    /// 生命条
    setupLifeBar(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      barLifeDrawPosition: .top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withValues(alpha: 0.5),
      borderRadius: .circular(2),
      textOffset: Vector2(16, tileSize * 0.5),
    );
  }

  bool _canMove = true;

  @override
  Future<void> onLoad() {
    /// 设置碰撞系统
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.3, size.y * 0.4),
        position: Vector2(tileSize * 1.7, tileSize * 1.5),
      ),
    );
    return super.onLoad();
  }

  /// 渲染
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  /// 碰撞触发
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Boss) return;
    if (isDead && other is FlyingAttackGameObject) return;
    super.onCollision(points, other);
  }

  @override
  void update(double dt) {
    if (_canMove) {
      /// 发现并攻击玩家
      seeAndMoveToPlayer(
        radiusVision: tileSize * 10000,
        visionAngle: tileSize * 10000,
        runOnlyVisibleInScreen: false,
        closePlayer: (player) {
          /// 抵达玩家，开始攻击
          execAttack();
        },
        // 未发现
        notObserved: () {
          /// 随机移动
          runRandomMovement(dt, speed: speed, maxDistance: tileSize * 100);
          return false;
        },
      );
    }

    super.update(dt);
  }

  /// 死亡
  @override
  void onDie() {
    _canMove = false;

    /// 死亡动画
    animation?.playOnce(
      SpriteSheetOrc.getDie(),
      onFinish: () {
        /// 动画完成后从父类移除
        removeFromParent();
      },
      runToTheEnd: true,
    );
    super.onDie();
  }

  /// 处理攻击
  @override
  bool handleAttack(AttackOriginEnum attacker, double damage, identify) {
    return super.handleAttack(attacker, damage, identify);
  }

  /// 受伤触发
  @override
  void onReceiveDamage(AttackOriginEnum attacker, double damage, identify) {
    if (!isDead) {
      super.onReceiveDamage(attacker, damage, identify);

      /// 伤害显示
      showDamage(
        damage,
        initVelocityVertical: -2,
        config: const TextStyle(color: Colors.amberAccent, fontSize: tileSize / 2),
      );

      /// 受伤动画
      // addDamageAnimation();
    }
  }

  /// 攻击动画
  void addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case .left:
        newAnimation = SpriteSheetOrc.getAttackBottomLeft();
      case .right:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
      case .up:
        if (lastDirectionHorizontal == .right) {
          newAnimation = SpriteSheetOrc.getAttackTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackTopLeft();
        }
      case .down:
        if (lastDirectionHorizontal == .right) {
          newAnimation = SpriteSheetOrc.getAttackBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        }
      case .upLeft:
        newAnimation = SpriteSheetOrc.getAttackTopLeft();
      case .upRight:
        newAnimation = SpriteSheetOrc.getAttackTopRight();
      case .downLeft:
        newAnimation = SpriteSheetOrc.getAttackBottomLeft();
      case .downRight:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
    }
    animation?.playOnce(newAnimation, runToTheEnd: true);
  }

  /// 受伤动画
  void addDamageAnimation() {
    _canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case .left:
        newAnimation = SpriteSheetOrc.getDamageBottomLeft();
      case .right:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
      case .up:
        if (lastDirectionHorizontal == .right) {
          newAnimation = SpriteSheetOrc.getDamageTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageTopLeft();
        }
      case .down:
        if (lastDirectionHorizontal == .right) {
          newAnimation = SpriteSheetOrc.getDamageBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        }
      case .upLeft:
        newAnimation = SpriteSheetOrc.getDamageTopLeft();
      case .upRight:
        newAnimation = SpriteSheetOrc.getDamageTopRight();
      case .downLeft:
        newAnimation = SpriteSheetOrc.getDamageBottomLeft();
      case .downRight:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: () {
        _canMove = true;
      },
    );
  }

  /// 攻击
  void execAttack() {
    simpleAttackMelee(
      damage: 10,
      size: Vector2.all(tileSize * 5),
      interval: 800,
      execute: () {
        addAttackAnimation();
      },
    );
  }
}
