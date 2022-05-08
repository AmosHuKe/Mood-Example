import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/routes.dart';

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
      orientation: Orientation.portrait,
    );
    return Theme(
      data: ThemeData(),
      child: const Scaffold(
        backgroundColor: Color(0xFFF6F8FA),
        body: SafeArea(
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
          EdgeInsets.only(left: 24.w, right: 24.w, top: 24.w, bottom: 20.h),
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
            Remix.mini_program_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "UniApp 小程序",
          subtitle: "集成 UniMPSDK 可在 APP 内打开 UniApp 小程序。",
          onPressed: () {
            Navigator.pushNamed(context, Routes.settingLaboratoryUniMPMiniapps);
          },
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "占位",
          subtitle: "占位占位占位",
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "占位",
          subtitle: "占位占位占位",
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_fill,
            size: 32.sp,
            color: Colors.black87,
          ),
          title: "占位",
          subtitle: "占位占位占位",
        ),
        ListCard(
          leading: Icon(
            Remix.account_box_fill,
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
    return Card(
      margin: EdgeInsets.only(top: 12.w, bottom: 12.w),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(48.sp)),
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
                  child: const Text('打开'),
                  onPressed: onPressed,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
