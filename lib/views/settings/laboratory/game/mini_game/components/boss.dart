import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_boss.dart';
import 'orc.dart';

double tileSize = 20.0;

class Boss extends SimpleEnemy
    with AutomaticRandomMovement, BlockMovementCollision, UseLifeBar {
  Boss(Vector2 position)
      : super(
          position: position,
          animation: SpriteSheetBoss.bossAnimations(),
          life: 400,
          speed: tileSize * 0.5 + Random().nextInt(60),
          size: Vector2.all(tileSize * 5),
        ) {
    /// 生命条
    setupLifeBar(
      size: Vector2(tileSize * 2.5, tileSize / 5),
      barLifeDrawPosition: BarLifeDrawPorition.top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(2),
      textOffset: Vector2(16, tileSize * 0.2),
    );
  }

  bool _canMove = true;

  @override
  Future<void> onLoad() {
    /// 设置碰撞系统
    add(RectangleHitbox(
      size: Vector2(
        size.x * 0.6,
        size.y * 0.5,
      ),
      position: Vector2(tileSize * 1.2, tileSize * 1.5),
    ));
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
    if (other is Orc) return;
    if (other is Boss) return;
    super.onCollision(points, other);
  }

  @override
  void update(double dt) {
    if (_canMove) {
      /// 发现并攻击玩家
      seeAndMoveToPlayer(
        radiusVision: tileSize * 10000,
        visionAngle: tileSize * 10000,
        closePlayer: (comp) {
          /// 抵达玩家，开始攻击
          execAttack();
        },
        // 未发现
        notObserved: () {
          /// 随机移动
          runRandomMovement(
            dt,
            speed: speed / 1.5,
            maxDistance: (tileSize * 100).toInt(),
          );
          return false;
        },
      );
    }
    super.update(dt);
  }

  /// 死亡
  @override
  void die() {
    _canMove = false;
    removeFromParent();
    super.die();
  }

  /// 受伤触发
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (!isDead) {
      /// 伤害显示
      showDamage(
        damage,
        initVelocityVertical: -2,
        config: TextStyle(color: Colors.amberAccent, fontSize: tileSize / 2),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  /// 攻击
  void execAttack() {
    simpleAttackMelee(
      damage: 20,
      size: Vector2.all(tileSize * 5),
      interval: 800,
      execute: () {},
    );
  }
}
