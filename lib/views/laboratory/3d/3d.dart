import 'package:flutter/material.dart';

import 'package:ditredi/ditredi.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../widgets/action_button/action_button.dart';

class Demo3DScreen extends StatelessWidget {
  const Demo3DScreen({super.key});

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
          title: const Text('3D 城市'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
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
    controller = .new();
    controller.update(
      light: .new(-50, -50, 50),
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
            case .done:
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
