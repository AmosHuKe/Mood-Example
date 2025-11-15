import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bonfire/bonfire.dart';

import '../sprite_sheet/sprite_sheet_player.dart';
import 'orc.dart';

const double tileSize = 20.0;

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
        life: 1000,
        size: .all(tileSize * 2.9),
      ) {
    /// 发光
    setupLighting(
      LightingConfig(radius: width / 2, blurBorder: width / 2, color: Colors.transparent),
    );

    /// 生命条
    setupLifeBar(
      size: Vector2(tileSize * 1.5, tileSize / 5),
      barLifeDrawPosition: .top,
      showLifeText: false,
      borderWidth: 2,
      borderColor: Colors.white.withValues(alpha: 0.5),
      borderRadius: .circular(2),
      textOffset: Vector2(6, tileSize * 0.2),
    );
  }

  static double maxSpeed = tileSize * 4;

  bool lockMove = false;

  @override
  Future<void> onLoad() {
    /// 设置碰撞系统
    add(
      RectangleHitbox(
        size: Vector2(size.x * 0.2, size.y * 0.15),
        position: Vector2(tileSize * 1.15, tileSize * 1.5),
      ),
    );
    return super.onLoad();
  }

  /// 渲染
  @override
  void render(Canvas canvas) {
    gameRef.camera.follow(this);
    super.render(canvas);
  }

  /// 碰撞触发
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    /// 碰撞 Orc 不发生碰撞
    if (other is Orc) {
      print('碰撞 Orc');
      return;
    }
    super.onCollision(points, other);
  }

  /// 操纵手柄操作控制
  @override
  void onJoystickAction(JoystickActionEvent event) {
    /// 死亡 || 锁住移动
    if (isDead || lockMove) return;

    /// 攻击
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == 1) &&
        event.event == .DOWN) {
      /// 攻击动画
      addAttackAnimation();

      /// 攻击范围
      simpleAttackMelee(damage: 10, size: Vector2.all(tileSize * 1.5), withPush: false);
    }
    super.onJoystickAction(event);
  }

  @override
  void onJoystickChangeDirectional(JoystickDirectionalEvent event) {
    if (lockMove || isDead) {
      return;
    }
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
      //     ?.animateToColor(const Color(0xFF630000).withOpacity(0.7));

      // idle();
      // addDamageAnimation(() {
      //   lockMove = false;
      //   gameRef.lighting?.animateToColor(Colors.black.withOpacity(0.7));
      // });
    }
  }

  @override
  void onDie() {
    animation?.playOnce(
      SpriteSheetPlayer.getDie(),
      onFinish: () {
        removeFromParent();
      },
      runToTheEnd: true,
    );
    super.onDie();
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
  // void addDamageAnimation(VoidCallback onFinish) {
  //   Future<SpriteAnimation> newAnimation;
  //   switch (lastDirection) {
  //     case Direction.left:
  //       newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
  //     case Direction.right:
  //       newAnimation = SpriteSheetPlayer.getDamageBottomRight();
  //     case Direction.up:
  //       if (lastDirectionHorizontal == Direction.left) {
  //         newAnimation = SpriteSheetPlayer.getDamageTopLeft();
  //       } else {
  //         newAnimation = SpriteSheetPlayer.getDamageTopRight();
  //       }
  //     case Direction.down:
  //       if (lastDirectionHorizontal == Direction.left) {
  //         newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
  //       } else {
  //         newAnimation = SpriteSheetPlayer.getDamageBottomRight();
  //       }
  //     case Direction.upLeft:
  //       newAnimation = SpriteSheetPlayer.getDamageTopLeft();
  //     case Direction.upRight:
  //       newAnimation = SpriteSheetPlayer.getDamageTopRight();
  //     case Direction.downLeft:
  //       newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
  //     case Direction.downRight:
  //       newAnimation = SpriteSheetPlayer.getDamageBottomRight();
  //   }
  //   animation?.playOnce(
  //     newAnimation,
  //     runToTheEnd: true,
  //     onFinish: onFinish,
  //   );
  // }
}
