import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/widgets/animation/animation.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

import 'package:moodexample/views/settings/laboratory/3d/index.dart';
import 'package:moodexample/views/settings/laboratory/unimp_miniapps/index.dart';
import 'package:moodexample/views/settings/laboratory/game/index.dart';
import 'package:moodexample/views/settings/laboratory/game/sprite_sheet/sprite_sheet_orc.dart';
import 'package:moodexample/views/settings/laboratory/game/sprite_sheet/sprite_sheet_player.dart';

class LaboratoryPage extends StatefulWidget {
  const LaboratoryPage({Key? key}) : super(key: key);

  @override
  State<LaboratoryPage> createState() => _LaboratoryPageState();
}

class _LaboratoryPageState extends State<LaboratoryPage> {
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
        floatingActionButton: ActionButton(
          key: const Key("widget_laboratory_back_button"),
          semanticsLabel: "返回",
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ],
            ),
            borderRadius: BorderRadius.circular(18.w),
          ),
          child: Icon(
            Remix.arrow_left_line,
            size: 18.sp,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: const SafeArea(
          key: Key("widget_laboratory_page"),
          child: LaboratoryBody(),
        ),
      ),
    );
  }
}

class LaboratoryBody extends StatefulWidget {
  const LaboratoryBody({Key? key}) : super(key: key);

  @override
  State<LaboratoryBody> createState() => _LaboratoryBodyState();
}

class _LaboratoryBodyState extends State<LaboratoryBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 24.w, bottom: 20.h),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 标题
        Container(
          margin: EdgeInsets.only(bottom: 32.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).app_setting_laboratory,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Remix.flask_line, size: 48.sp, color: Colors.black12),
            ],
          ),
        ),
        ListCard(
          leading: Icon(
            Remix.mini_program_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "uniapp 小程序",
          subtitle: "集成 UniMPSDK 可在 APP 内打开 uniapp 小程序。",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UniMPMiniappsPage(),
              ),
            );
          },
        ),
        ListCard(
          leading: Icon(
            Remix.building_2_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "3D 城市",
          subtitle:
              "obj 格式，CPU 渲染性能较低，3D 来源 https://github.com/pissang/little-big-city",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Page3D(),
              ),
            );
          },
        ),
        ListCard(
          leading: Icon(
            Remix.gamepad_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "游戏",
          subtitle: "2D 游戏",
          onPressed: () async {
            await SpriteSheetOrc.load();
            await SpriteSheetPlayer.load();
            if (!mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GamePage(),
              ),
            );
          },
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "占位",
          subtitle: "占位占位占位",
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_line,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "占位",
          subtitle: "占位占位占位",
        ),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    required this.title,
    required this.subtitle,
    required this.leading,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 图标
  final Widget leading;

  /// 点击打开触发
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      scaleEnd: 0.95,
      child: Card(
        margin: EdgeInsets.only(top: 12.w, bottom: 12.w),
        shadowColor: Colors.black38,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(48.sp)),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            children: [
              ListTile(
                leading: leading,
                title: Text(title),
                subtitle: Text(subtitle),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onPressed,
                    child: const Text('打开'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
