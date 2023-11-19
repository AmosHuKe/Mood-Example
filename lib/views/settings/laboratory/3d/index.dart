import 'package:flutter/material.dart';

import 'package:ditredi/ditredi.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class Page3D extends StatefulWidget {
  const Page3D({super.key});

  @override
  State<Page3D> createState() => _Page3DState();
}

class _Page3DState extends State<Page3D> {
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
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text('3D 城市'),
          leading: ActionButton(
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor1,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18.w),
              ),
            ),
            child: Icon(Remix.arrow_left_line, size: 24.sp),
            onTap: () => Navigator.of(context).pop(),
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
  late DiTreDiController controller = DiTreDiController();
  @override
  void initState() {
    controller = DiTreDiController();
    controller.update(
      light: vector.Vector3(-50, -50, 50),
      lightStrength: 1.2,
      ambientLightStrength: 0.6,
      userScale: 1.5.sp,
    );
    super.initState();
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
        builder: ((context, snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              widget = const Text('3D模型加载出错了');
            } else {
              widget = DiTreDi(
                figures: [
                  Mesh3D(snapshot.requireData),
                ],
                controller: controller,
              );
            }
          } else {
            widget = const Align(
              child: CircularProgressIndicator(),
            );
          }
          return widget;
        }),
      ),
    );
  }
}
