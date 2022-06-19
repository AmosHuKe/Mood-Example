import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../sprite_sheet/sprite_sheet_player.dart';

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
          size: Vector2.all(tileSize * 2.9),
        ) {
    setupLighting(
      LightingConfig(
        radius: width / 2,
        blurBorder: width / 2,
        color: Colors.transparent,
      ),
    );

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
  void joystickAction(JoystickActionEvent event) {
    if (isDead || lockMove) return;
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == 1) &&
        event.event == ActionEvent.DOWN) {
      _addAttackAnimation();
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

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic from) {
    if (!isDead) {
      showDamage(
        damage,
        initVelocityTop: -2,
        config: TextStyle(color: Colors.white, fontSize: tileSize / 2),
      );

      lockMove = true;
      idle();
      _addDamageAnimation(() {
        lockMove = false;
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
