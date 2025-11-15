import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

class Light extends GameDecoration {
  Light({required super.position, required super.size}) {
    setupLighting(
      .new(
        radius: width * 2,
        blurBorder: width * 1.5,
        color: Colors.orange.withValues(alpha: 0.2),
        withPulse: true,
      ),
    );
  }
}
