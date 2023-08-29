import 'package:flutter/services.dart';

import 'package:bonfire/bonfire.dart';

import '../components/human_player.dart';

class HumanPlayerController extends StateController<HumanPlayer> {
  double tileSize = 20.0;
  bool executingRangeAttack = false;
  double radAngleRangeAttack = 0;
  bool executingRangeShotgunsAttack = false;
  double radAngleRangeShotgunsAttack = 0;

  @override
  void update(double dt, HumanPlayer component) {
    /// 远程攻击触发（发射间隔）
    final bool execRangeAttackInterval = component.checkInterval(
      'AttackRange',
      100,
      dt,
    );
    if (executingRangeAttack && execRangeAttackInterval) {
      component.actionAttackRange(radAngleRangeAttack);
    }

    /// 远程混乱攻击触发（发射间隔）
    final bool execRangeShotgunsAttackInterval = component.checkInterval(
      'AttackRangeShotguns',
      50,
      dt,
    );
    if (executingRangeShotgunsAttack && execRangeShotgunsAttackInterval) {
      component.actionAttackRangeShotguns(radAngleRangeShotgunsAttack);
    }
  }

  /// 操纵手柄操作控制
  void handleJoystickAction(JoystickActionEvent event) {
    /// 近战攻击
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == LogicalKeyboardKey.select.keyId ||
            event.id == PlayerAttackType.attackMelee) &&
        event.event == ActionEvent.DOWN) {
      /// 攻击动画
      component?.addAttackAnimation();

      /// 攻击范围
      component?.simpleAttackMelee(
        damage: 50,
        size: Vector2.all(tileSize),
        withPush: false,
      );
    }

    /// 远程攻击
    if (event.id == LogicalKeyboardKey.select.keyId ||
        event.id == PlayerAttackType.attackRange) {
      if (event.event == ActionEvent.MOVE) {
        executingRangeAttack = true;
        radAngleRangeAttack = event.radAngle;
      }
      if (event.event == ActionEvent.UP) {
        executingRangeAttack = false;
      }
    }

    /// 远程混乱攻击
    if (event.id == LogicalKeyboardKey.select.keyId ||
        event.id == PlayerAttackType.attackRangeShotguns) {
      if (event.event == ActionEvent.MOVE) {
        executingRangeShotgunsAttack = true;
        radAngleRangeShotgunsAttack = event.radAngle;
      }
      if (event.event == ActionEvent.UP) {
        executingRangeShotgunsAttack = false;
      }
    }
  }

  /// 受伤触发
  void handleReceiveDamage(double damage) {
    component?.handleReceiveDamage(damage);
  }
}
