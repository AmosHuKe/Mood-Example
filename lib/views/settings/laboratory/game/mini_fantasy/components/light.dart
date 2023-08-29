import 'package:flutter/material.dart';

import 'package:bonfire/bonfire.dart';

class Light extends GameDecoration with Lighting {
  Light(
    Vector2 position,
    Vector2 size,
  ) : super(
          position: position,
          size: size,
        ) {
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
