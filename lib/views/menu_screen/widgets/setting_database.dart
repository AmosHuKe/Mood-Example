import 'package:flutter/material.dart';

///
import 'package:moodexample/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

/// 数据

class SettingDatabase extends StatefulWidget {
  const SettingDatabase({Key? key}) : super(key: key);

  @override
  State<SettingDatabase> createState() => _SettingDatabaseState();
}

class _SettingDatabaseState extends State<SettingDatabase> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            "数据管理",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),
        Column(
          children: [
            IconButton(
              icon: Icon(Remix.download_2_fill),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
