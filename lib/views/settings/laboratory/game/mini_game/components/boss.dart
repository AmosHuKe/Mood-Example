import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_boss.dart';
import 'orc.dart';

double tileSize = 20.0;

class Boss extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement, UseBarLife {
  Boss(Vector2 position)
      : super(
          position: position,
          animation: SpriteSheetBoss.bossAnimations(),
          life: 400,
          speed: tileSize * 0.5 + Random().nextInt(60),
          size: Vector2.all(tileSize * 5),
        ) {
    /// 设置碰撞系统
    setupCollision(
      CollisionConfig(
        collisions: [
          /// 碰撞形状及体积
          CollisionArea.rectangle(
            size: Vector2(
              size.x * 0.6,
              size.y * 0.5,
            ),
            align: Vector2(tileSize * 1.2, tileSize * 1.5),
          ),
        ],
      ),
    );

    /// 生命条
    setupBarLife(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      barLifePosition: BarLifePorition.top,
      showLifeText: false,
      margin: 0,
      borderWidth: 2,
      borderColor: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(2),
      offset: Vector2(0, tileSize * 0.5),
    );
  }

  bool canMove = true;

  /// 渲染
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  /// 碰撞触发
  @override
  bool onCollision(GameComponent component, bool active) {
    bool active = true;
    if (component is Orc) {
      active = false;
    }
    return active;
  }

  @override
  void update(double dt) {
    if (canMove) {
      /// 发现玩家
      seePlayer(
        radiusVision: tileSize * 10000,

        /// 发现
        observed: (player) {
          /// 跟随玩家
          followComponent(
            player,
            dt,
            closeComponent: (comp) {
              /// 抵达玩家，开始攻击
              execAttack();
            },
          );
        },

        /// 未发现
        notObserved: () {
          /// 随机移动
          runRandomMovement(
            dt,
            speed: speed / 3,
            maxDistance: (tileSize * 4).toInt(),
          );
        },
      );
    }
    super.update(dt);
  }

  /// 死亡
  @override
  void die() {
    canMove = false;
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
        initVelocityTop: -2,
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
