import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moodexample/widgets/empty/empty.dart';
import 'dart:io';
import 'package:path/path.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';

///
import 'package:moodexample/generated/l10n.dart';

///
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

/// 数据
class SettingDatabase extends StatefulWidget {
  const SettingDatabase({Key? key}) : super(key: key);

  @override
  State<SettingDatabase> createState() => _SettingDatabaseState();
}

class _SettingDatabaseState extends State<SettingDatabase> {
  /// 数据导出位置
  String exportPath = "";

  /// 数据是否正在导出
  bool isExport = false;
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
            "导出数据",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),
        Column(
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              padding: EdgeInsets.only(top: 24.w),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: isExport
                    ? const CupertinoActivityIndicator(color: Color(0xFFFFFFFF))
                    : Material(
                        color: Colors.transparent,
                        child: IconButton(
                          splashColor: Colors.white10,
                          highlightColor: Colors.white10,
                          icon: const Icon(Remix.arrow_down_line),
                          iconSize: 24.sp,
                          color: const Color(0xFFFFFFFF),
                          onPressed: () async {
                            try {
                              /// 没文件则进行生成
                              if (exportPath.isEmpty) {
                                setState(() {
                                  isExport = true;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 1500),
                                    () async {
                                  exportPath = await exportDatabase();
                                });
                              }

                              /// 有文件则直接分享
                              if (exportPath.isNotEmpty) {
                                setState(() {
                                  isExport = false;
                                });

                                /// 分享文件
                                Share.shareFiles([exportPath]);
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 导出数据
Future<String> exportDatabase() async {
  MoodViewModel moodViewModel = MoodViewModel();
  DateTime now = DateTime.now();

  /// 获取APP文件临时根路径
  final directory = (await getTemporaryDirectory()).path;

  /// 保存文件路径及名称
  final String fileName = "$directory/system/database/MoodExample_$now.xlsx";

  /// 创建Excel
  Excel excel = Excel.createExcel();

  /// 创建工作薄
  Sheet sheetObject = excel['MoodExample'];

  /// 设置默认工作薄
  excel.setDefaultSheet('MoodExample');

  /// 单元格样式
  CellStyle cellStyle = CellStyle(
    fontColorHex: "#FFFFFF",
    fontSize: 10,
    bold: true,
    fontFamily: getFontFamily(FontFamily.Microsoft_Sans_Serif),
    backgroundColorHex: "#3E4663",
    horizontalAlign: HorizontalAlign.Center,
    verticalAlign: VerticalAlign.Center,
  );

  /// 创建大标题
  sheetObject.merge(
    CellIndex.indexByString("A1"),
    CellIndex.indexByString("F1"),
  );
  sheetObject.cell(CellIndex.indexByString("A1"))
    ..value = "MoodExample"
    ..cellStyle = CellStyle(
      fontColorHex: "#FFFFFF",
      fontSize: 10,
      bold: true,
      fontFamily: getFontFamily(FontFamily.Microsoft_Sans_Serif),
      backgroundColorHex: "#3E4663",
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

  /// 创建字段标题
  sheetObject.cell(CellIndex.indexByString("A2"))
    ..value = "表情"
    ..cellStyle = cellStyle;
  sheetObject.cell(CellIndex.indexByString("B2"))
    ..value = "心情"
    ..cellStyle = cellStyle;
  sheetObject.cell(CellIndex.indexByString("C2"))
    ..value = "内容"
    ..cellStyle = cellStyle;
  sheetObject.cell(CellIndex.indexByString("D2"))
    ..value = "心情程度"
    ..cellStyle = cellStyle;
  sheetObject.cell(CellIndex.indexByString("E2"))
    ..value = "创建时间"
    ..cellStyle = cellStyle;
  sheetObject.cell(CellIndex.indexByString("F2"))
    ..value = "修改时间"
    ..cellStyle = cellStyle;

  /// 获取所有心情数据并赋值
  await MoodService.getMoodAllData(moodViewModel);
  final _moodAllDataList = moodViewModel.moodAllDataList;

  /// 添加Excel数据
  _moodAllDataList?.forEach((list) {
    List dataList = [
      list.icon,
      list.title,
      list.content,
      list.score,
      list.createTime,
      list.updateTime,
    ];

    sheetObject.appendRow(dataList);
  });

  /// 保存Excel
  final fileBytes = excel.save();

  /// 存入文件
  File(join(fileName))
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  return fileName;
}
