import 'package:flutter/material.dart';

/// 动画

/// 动画-按下
class AnimatedPress extends StatefulWidget {
  const AnimatedPress({super.key, required this.child, this.scaleEnd = 0.9});

  final Widget child;

  /// 按下结束后缩放的比例，最大[1.0]
  final double scaleEnd;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {});
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeIn,
    );
    scale = Tween(begin: 1.0, end: widget.scaleEnd).animate(curve);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 开始动画
  void controllerForward() {
    final status = controller.status;
    if (status != AnimationStatus.forward && status != AnimationStatus.completed) {
      controller.forward();
    }
  }

  /// 结束动画
  void controllerReverse() {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => controllerForward(),
      onPointerHover: (_) => controllerForward(),
      onPointerMove: (_) => controllerForward(),
      onPointerCancel: (_) => controllerReverse(),
      onPointerUp: (_) => controllerReverse(),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.scale(scale: scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
