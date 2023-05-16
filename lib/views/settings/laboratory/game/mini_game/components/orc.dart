import 'dart:math';
import 'package:flutter/material.dart';

///
import 'package:bonfire/bonfire.dart';

///
import '../sprite_sheet/sprite_sheet_orc.dart';
import 'boss.dart';

double tileSize = 20.0;

class Orc extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement, UseBarLife {
  bool canMove = true;

  Orc(Vector2 position)
      : super(
          position: position,
          animation: SimpleDirectionAnimation(
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
    /// 设置碰撞系统
    setupCollision(
      CollisionConfig(
        collisions: [
          /// 碰撞形状及体积
          CollisionArea.rectangle(
            size: Vector2(
              size.x * 0.3,
              size.y * 0.4,
            ),
            align: Vector2(tileSize * 1.7, tileSize * 1.5),
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

  /// 渲染
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  /// 碰撞触发
  @override
  bool onCollision(GameComponent component, bool active) {
    bool active = true;
    if (component is Boss) {
      active = false;
    }
    if (isDead && component is FlyingAttackObject) {
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

    /// 死亡动画
    animation?.playOnce(
      SpriteSheetOrc.getDie(),
      onFinish: () {
        /// 动画完成后从父类移除
        removeFromParent();
      },
      runToTheEnd: true,
    );
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

      /// 受伤动画
      _addDamageAnimation();
    }
    super.receiveDamage(attacker, damage, identify);
  }

  /// 攻击动画
  void _addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getAttackTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackTopLeft();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getAttackBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetOrc.getAttackTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetOrc.getAttackTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
    );
  }

  /// 受伤动画
  void _addDamageAnimation() {
    canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getDamageTopRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageTopLeft();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = SpriteSheetOrc.getDamageBottomRight();
        } else {
          newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetOrc.getDamageTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetOrc.getDamageTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: () {
        canMove = true;
      },
    );
  }

  /// 攻击
  void _execAttack() {
    simpleAttackMelee(
      damage: 10,
      size: Vector2.all(tileSize * 5),
      interval: 800,
      execute: () {
        _addAttackAnimation();
      },
    );
  }
}
