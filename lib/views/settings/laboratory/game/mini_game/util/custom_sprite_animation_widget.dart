import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

class CustomSpriteAnimationWidget extends StatelessWidget {
  const CustomSpriteAnimationWidget({super.key, required this.animation});

  final Future<SpriteAnimation> animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100, height: 100, child: animation.asWidget());
  }
}
