import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
import 'package:bonfire/bonfire.dart';

///
import '../sprite_sheet/sprite_sheet_player.dart';
import 'orc.dart';

double tileSize = 20.0;

class HumanPlayer extends SimplePlayer with Lighting, ObjectCollision {
  static double maxSpeed = tileSize * 4;

  bool lockMove = false;

  HumanPlayer(Vector2 position)
      : super(
          position: position,
          animation: SimpleDirectionAnimation(
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
          size: Vector2.all(tileSize * 2.9),
        ) {
    /// 发光
    setupLighting(
      LightingConfig(
        radius: width / 2,
        blurBorder: width / 2,
        color: Colors.transparent,
      ),
    );

    /// 碰撞
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              size.x * 0.2,
              size.y * 0.15,
            ),
            align: Vector2(tileSize * 1.15, tileSize * 1.5),
          ),
        ],
      ),
    );
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
        borderWidth: tileSize / 5,
        height: tileSize / 5,
        borderColor: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2),
        align: Offset(
          tileSize * 0.7,
          tileSize * 0.7,
        ),
      );
    }
    super.render(canvas);
  }

  /// 碰撞触发
  @override
  bool onCollision(GameComponent component, bool active) {
    bool active = true;

    /// 碰撞 Orc 不发生碰撞
    if (component is Orc) {
      debugPrint("碰撞 Orc");
      active = false;
    }
    return active;
  }

  /// 操纵手柄操作控制
  @override
  void joystickAction(JoystickActionEvent event) {
    /// 死亡 || 锁住移动
    if (isDead || lockMove) return;

    /// 攻击
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == 1) &&
        event.event == ActionEvent.DOWN) {
      /// 攻击动画
      _addAttackAnimation();

      /// 攻击范围
      simpleAttackMelee(
        damage: 10,
        size: Vector2.all(tileSize * 1.5),
        withPush: false,
      );
    }
    super.joystickAction(event);
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    if (lockMove || isDead) {
      return;
    }
    speed = maxSpeed * event.intensity;
    super.joystickChangeDirectional(event);
  }

  /// 受伤触发
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic from) {
    if (!isDead) {
      showDamage(
        damage,
        initVelocityTop: -2,
        config: TextStyle(color: Colors.white, fontSize: tileSize / 2),
      );
      // lockMove = true;
      /// 屏幕变红
      gameRef.lighting
          ?.animateToColor(const Color(0xFF630000).withOpacity(0.7));
      gameRef.add(
        Orc(
          Vector2(
            (gameRef.player?.position.x ?? 0) - Random().nextInt(20),
            (gameRef.player?.position.y ?? 0) - Random().nextInt(20),
          ),
        ),
      );
      idle();
      _addDamageAnimation(() {
        lockMove = false;
        gameRef.lighting?.animateToColor(Colors.black.withOpacity(0.7));
      });
    }
    super.receiveDamage(attacker, damage, from);
  }

  @override
  void die() {
    animation?.playOnce(
      SpriteSheetPlayer.getDie(),
      onFinish: () {
        removeFromParent();
      },
      runToTheEnd: true,
    );
    super.die();
  }

  /// 攻击动画
  void _addAttackAnimation() {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackTopRight();
        }

        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetPlayer.getAttackTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetPlayer.getAttackTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetPlayer.getAttackBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetPlayer.getAttackBottomRight();
        break;
    }
    animation?.playOnce(newAnimation);
  }

  /// 受伤动画
  void _addDamageAnimation(VoidCallback onFinish) {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        break;
      case Direction.right:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageTopRight();
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        } else {
          newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        }
        break;
      case Direction.upLeft:
        newAnimation = SpriteSheetPlayer.getDamageTopLeft();
        break;
      case Direction.upRight:
        newAnimation = SpriteSheetPlayer.getDamageTopRight();
        break;
      case Direction.downLeft:
        newAnimation = SpriteSheetPlayer.getDamageBottomLeft();
        break;
      case Direction.downRight:
        newAnimation = SpriteSheetPlayer.getDamageBottomRight();
        break;
    }
    animation?.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: onFinish,
    );
  }
}
