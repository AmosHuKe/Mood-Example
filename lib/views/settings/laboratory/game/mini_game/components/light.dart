import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

class Light extends GameDecoration {
  Light({
    required super.position,
    required super.size,
  }) {
    setupLighting(
      LightingConfig(
        radius: width * 2,
        blurBorder: width * 1.5,
        color: Colors.orange.withOpacity(0.2),
        withPulse: true,
      ),
    );
  }
}
