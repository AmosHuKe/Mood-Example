import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_boss.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/components/orc.dart';

double tileSize = 20.0;

class Boss extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;

  Boss(Vector2 position)
      : super(
          position: position,
          animation: SpriteSheetBoss.bossAnimations(),
          life: 150,
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
  void render(Canvas canvas) {
    if (!isDead) {
      /// 生命条
      drawDefaultLifeBar(
        canvas,
        margin: 0,
        width: tileSize * 3,
        height: tileSize / 4,
        borderRadius: BorderRadius.circular(2),
        align: Offset(
          tileSize * 1.7,
          tileSize / 4,
        ),
        borderWidth: 10,
        borderColor: Colors.red,
      );
    }
    super.render(canvas);
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
              _execAttack();
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
  void _execAttack() {
    simpleAttackMelee(
      damage: 20,
      size: Vector2.all(tileSize * 1.5),
      interval: 800,
      execute: () {},
    );
  }
}
