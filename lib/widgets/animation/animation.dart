import 'package:flutter/material.dart';

/// 动画

/// 动画-按下
class AnimatedPress extends StatefulWidget {
  const AnimatedPress({super.key, required this.child, this.scaleEnd = 0.95});

  final Widget child;

  /// 按下结束后缩放的比例，最大[1.0]
  final double scaleEnd;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation curve;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    animationController = .new(vsync: this, duration: const .new(milliseconds: 300))
      ..addListener(() {});
    curve = .new(
      parent: animationController,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeIn,
    );
    scale = Tween(begin: 1.0, end: widget.scaleEnd).animate(curve);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /// 开始动画
  void controllerForward() {
    final status = animationController.status;
    if (status != .forward && status != .completed) {
      animationController.forward();
    }
  }

  /// 结束动画
  void controllerReverse() {
    animationController.reverse();
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
        animation: animationController,
        builder: (context, child) => Transform.scale(scale: scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
