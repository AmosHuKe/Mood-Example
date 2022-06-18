import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

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

class SpaceShooterGame extends FlameGame with TapDetector,KeyboardEvents,HasCollisionDetection {
  late final Monster monster;
  final double step = 1.5;
  final someVector = Vector2(200, 200);

  @override
  bool debugMode =  true ;

  @override
  Future<void> onLoad()  async{
    await super.onLoad();
    const String src = 'game/human_run.png';
    await images.load(src);
    var image = images.fromCache(src);
    const int rowCount = 4;
    const int columnCount = 4;
    final Vector2 textureSize = Vector2(
      image.width / columnCount,
      image.height / rowCount,
    );
    SpriteAnimation animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: rowCount * columnCount,
        amountPerRow: columnCount,
        stepTime: 1 / 8,
        textureSize: textureSize,
      ),
    );
    Vector2 monsterSize = Vector2(64.w, 64.w);
    final double pY = size.y / 2;
    final double pX = size.x / 2;
    monster = Monster(
        animation: animation, size: monsterSize, position: Vector2(pX, pY));
    add(monster);
    add(Player()
      ..position = size / 2
      ..width = 50.w
      ..height = 50.w
      ..anchor = Anchor.center
      ..priority = 1
    );
    // FPS
    add(FpsTextComponent());
    camera.followComponent(monster);
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

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    print(event);
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.keyW) {
      monster.move(Vector2(0, -step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.keyS && isKeyDown) {
      monster.move(Vector2(0, step));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.keyA && isKeyDown) {
      monster.move(Vector2(-step, 0));
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.keyD && isKeyDown) {
      monster.move(Vector2(step, 0));
    }
    return super.onKeyEvent(event, keysPressed);
  }
}

class Monster extends SpriteAnimationComponent {
  Monster({
    required SpriteAnimation animation,
    required Vector2 size,
    required Vector2 position,
  }) : super(
    animation: animation,
    size: size,
    position: position,
    anchor: Anchor.center,
    priority: 2,
  );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()..debugMode = true);
  }

  void move(Vector2 ds) {
    position.add(ds);
  }
}

class Player extends PositionComponent {
  static final _paint = Paint()
    ..color = Colors.white;
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox()..debugMode = true);
  }
}