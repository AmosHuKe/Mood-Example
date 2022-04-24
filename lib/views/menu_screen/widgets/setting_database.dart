import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';

///
import 'package:moodexample/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:excel/excel.dart';

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
              icon: const Icon(Remix.download_2_fill),
              onPressed: () async {
                // 暂存
                DateTime now = DateTime.now();
                var excel = Excel.createExcel();
                Sheet sheetObject = excel['Sheet1'];
                var cell = sheetObject.cell(CellIndex.indexByString("A1"));
                cell.value = 8; // dynamic values support provided;
                var fileBytes = excel.save();

                var directory = (await getApplicationDocumentsDirectory()).path;
                print(directory);
                File(join("$directory/database/output_file_name_$now.xlsx"))
                  ..createSync(recursive: true)
                  ..writeAsBytesSync(fileBytes!);
              },
            ),
          ],
        ),
      ],
    );
  }
}
