import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:ditredi/ditredi.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class Demo3DScreen extends StatelessWidget {
  const Demo3DScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFE2DDE4),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: const Text('3D 城市'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: AppTheme.staticBackgroundColor1,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: const SafeArea(child: Body3D()),
      ),
    );
  }
}

class Body3D extends StatefulWidget {
  const Body3D({super.key});

  @override
  State<Body3D> createState() => _Body3DState();
}

class _Body3DState extends State<Body3D> {
  late final DiTreDiController controller;

  @override
  void initState() {
    super.initState();
    controller = DiTreDiController();
    controller.update(
      light: vector.Vector3(-50, -50, 50),
      lightStrength: 1.2,
      ambientLightStrength: 0.6,
      userScale: 1.5,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DiTreDiDraggable(
      controller: controller,
      child: FutureBuilder<List<Face3D>>(
        future: ObjParser().loadFromResources('assets/3d/city/city.obj'),
        builder: (context, snapshot) {
          Widget widget;
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                widget = const Text('3D模型加载出错了');
              } else {
                widget = DiTreDi(figures: [Mesh3D(snapshot.requireData)], controller: controller);
              }
            case _:
              widget = const Align(child: CircularProgressIndicator());
          }
          return widget;
        },
      ),
    );
  }
}
