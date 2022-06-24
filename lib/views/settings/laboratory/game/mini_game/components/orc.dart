import 'dart:async' as async;
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_orc.dart';

double tileSize = 20.0;

class Orc extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement, MoveToPositionAlongThePath {
  bool canMove = true;

  /// 敌对生物生成延迟时间
  async.Timer? _timerEnemy;

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
          speed: tileSize * 1 + Random().nextInt(100),
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
              size.y * 0.2,
            ),
            align: Vector2(tileSize * 1.7, tileSize * 2.5),
          ),
        ],
      ),
    );
    setupMoveToPositionAlongThePath(
      pathLineColor: Colors.lightBlueAccent.withOpacity(0.5),
      barriersCalculatedColor: Colors.blue.withOpacity(0.5),
      pathLineStrokeWidth: 4,
      showBarriersCalculated:
          false, // uses this to debug. This enable show in the map the tiles considered collision by algorithm.
      gridSizeIsCollisionSize: true,
    );
  }

  /// 碰撞触发
  @override
  bool onCollision(GameComponent component, bool active) {
    bool active = true;
    if (component is FlyingAttackObject) {
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
        drawInBottom: true,
        margin: 0,
        width: tileSize * 1.5,
        height: tileSize / 5,
        borderRadius: BorderRadius.circular(2),
        align: Offset(
          tileSize * 1.7,
          tileSize * 4,
        ),
      );
    }
    super.render(canvas);
  }

  /// 自动寻路
  void _moveToPositionAlongThePath(Vector2 position, {int delay = 3000}) {
    if (_timerEnemy == null) {
      _timerEnemy = async.Timer(Duration(milliseconds: delay), () {
        _timerEnemy = null;
      });
    } else {
      return;
    }
    moveToPositionAlongThePath(position);
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
      size: Vector2.all(tileSize * 1.5),
      interval: 800,
      execute: () {
        _addAttackAnimation();
      },
    );
  }
}
