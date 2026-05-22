import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../widgets/action_button/action_button.dart';

class TiltExampleScreen extends StatelessWidget {
  const TiltExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: .new(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F3),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF1F2F3),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: const Text('Flutter Tilt Example'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: const SafeArea(child: TiltExample()),
      ),
    );
  }
}

class TiltExample extends StatelessWidget {
  const TiltExample({super.key});

  @override
  Widget build(BuildContext context) {
    final innerBox = <Widget>[];
    for (var i = 1; i <= 10; i++) {
      innerBox.add(
        TiltParallax(
          offset: Offset(-20.0 * i, -30.0 * i),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(
                width: 4 * (1 - i * 0.05),
                color: Colors.white.withValues(alpha: 1 - (i - 1) * 0.1),
              ),
            ),
            child: SizedBox(width: 200 * (1 - i * 0.05), height: 200 * (1 - i * 0.05)),
          ),
        ),
      );
    }

    return Center(
      child: Tilt(
        tiltConfig: const .new(
          angle: 20,
          leaveCurve: Curves.easeInOutCubicEmphasized,
          leaveDuration: .new(milliseconds: 1200),
        ),
        child: TiltBaseContainer(
          borderRadius: .circular(24.0),
          lightConfig: const .new(disable: true),
          shadowConfig: const .new(disable: true),
          childLayout: .new(
            inner: [
              ...innerBox,
              const Positioned(
                left: 30.0,
                top: 30.0,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Flutter Tilt', style: .new(fontSize: 14, color: Colors.white70)),
                    Text('Layout', style: .new(fontSize: 32, color: Colors.white, height: 1)),
                  ],
                ),
              ),
              const Positioned(
                left: 30.0,
                bottom: 30.0,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Touch and move around.',
                      style: .new(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          child: const DecoratedBox(
            decoration: BoxDecoration(color: Colors.black),
            child: SizedBox(width: 300, height: 500),
          ),
        ),
      ),
    );
  }
}
