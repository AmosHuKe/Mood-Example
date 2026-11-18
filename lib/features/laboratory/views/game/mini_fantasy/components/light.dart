import 'package:bonfire/bonfire.dart';
import 'package:material_ui/material_ui.dart';

class Light extends GameDecoration with WithLighting {
  Light(Vector2 position, Vector2 size) : super(position: position, size: size) {
    lighting.setup(
      .new(
        radius: width * 2,
        blurBorder: width * 1.5,
        color: Colors.orange.withValues(alpha: 0.2),
        withPulse: true,
      ),
    );
  }
}
