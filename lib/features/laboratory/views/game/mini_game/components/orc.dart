import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:material_ui/material_ui.dart';

import '../sprite_sheet/sprite_sheet_orc.dart';
import 'boss.dart';

const double tileSize = 20.0;

class Orc extends SimpleEnemy
    with WithRandomMovement, WithCollision, WithLifeBar, WithVision, WithLife, WithAttack {
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
    lifeBar.setup(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      drawPosition: .top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withValues(alpha: 0.5),
      borderRadius: .circular(2),
      textOffset: Vector2(16, tileSize * 0.5),
    );

    life.onDieListener(_onDie);
    life.onRemoveLifeListener(_onReceiveDamage);
  }

  bool _canMove = true;
  final _attackMeleeTick = IntervalTick(800);

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
      vision.seeAndMoveToPlayer(
        radiusVision: tileSize * 10000,
        visionAngle: tileSize * 10000,
        runOnlyVisibleInScreen: false,
        closePlayer: (player) {
          /// 抵达玩家，开始攻击
          execAttack(dt);
        },
        // 未发现
        notObserved: () {
          /// 随机移动
          randomMovement.setup(speed: speed, maxDistance: tileSize * 100);
          randomMovement.run(dt);
          return false;
        },
      );
    }

    super.update(dt);
  }

  /// 死亡
  void _onDie() {
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
  }

  /// 受伤触发
  void _onReceiveDamage(double amount) {
    if (!isDead) {
      /// 伤害显示
      util.showDamage(
        amount,
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
    switch (direction) {
      case .left:
        newAnimation = SpriteSheetOrc.getAttackBottomLeft();
      case .right:
        newAnimation = SpriteSheetOrc.getAttackBottomRight();
      case .up:
        if (hDirection == .left) {
          newAnimation = SpriteSheetOrc.getAttackTopLeft();
        } else {
          newAnimation = SpriteSheetOrc.getAttackTopRight();
        }
      case .down:
        if (hDirection == .left) {
          newAnimation = SpriteSheetOrc.getAttackBottomLeft();
        } else {
          newAnimation = SpriteSheetOrc.getAttackBottomRight();
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
    switch (direction) {
      case .left:
        newAnimation = SpriteSheetOrc.getDamageBottomLeft();
      case .right:
        newAnimation = SpriteSheetOrc.getDamageBottomRight();
      case .up:
        if (hDirection == .left) {
          newAnimation = SpriteSheetOrc.getDamageTopLeft();
        } else {
          newAnimation = SpriteSheetOrc.getDamageTopRight();
        }
      case .down:
        if (hDirection == .left) {
          newAnimation = SpriteSheetOrc.getDamageBottomLeft();
        } else {
          newAnimation = SpriteSheetOrc.getDamageBottomRight();
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
  void execAttack(double dt) {
    if (_attackMeleeTick.update(dt)) {
      addAttackAnimation();
      attack.melee(damage: 10, size: Vector2.all(tileSize * 5));
    }
  }
}
