import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text("游戏"),
          leading: ActionButton(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.backgroundColor1,
                    AppTheme.backgroundColor1
                  ],
                ),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(18.w))),
            child: Icon(
              Remix.arrow_left_line,
              size: 24.sp,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: GameWidget(
            game: SpaceShooterGame()..paused = true,
            overlayBuilderMap: {
              'Paused': (BuildContext context, SpaceShooterGame game) {
                return const Text(
                  '暂停',
                  style: TextStyle(color: Colors.white),
                );
              },
            },
            initialActiveOverlays: const ['Paused'],
          ),
        ),
      ),
    );
  }
}

class SpaceShooterGame extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      Player()
        ..position = size / 2
        ..width = 50.w
        ..height = 50.w
        ..anchor = Anchor.center,
    );
  }

  @override
  void onTap() {
    if (overlays.isActive('Paused')) {
      overlays.remove('Paused');
      // 开始游戏运行（循环）
      resumeEngine();
    } else {
      overlays.add('Paused');
      // 暂停游戏运行（循环）
      pauseEngine();
    }
  }
}

class Player extends PositionComponent {
  static final _paint = Paint()..color = Colors.white;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }
}
