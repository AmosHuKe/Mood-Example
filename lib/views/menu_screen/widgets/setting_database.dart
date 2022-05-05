import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:excel/excel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

///
import 'package:moodexample/generated/l10n.dart';

///
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';
import 'package:moodexample/models/mood/mood_model.dart';

/// 数据
class SettingDatabase extends StatefulWidget {
  const SettingDatabase({Key? key}) : super(key: key);

  @override
  State<SettingDatabase> createState() => _SettingDatabaseState();
}

class _SettingDatabaseState extends State<SettingDatabase>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.w900),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          tabs: [
            Tab(
              child: Text(
                "导出数据",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
            Tab(
              child: Text(
                "导入数据",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              /// 导出数据
              ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: [
                  Center(
                    heightFactor: 2.h,
                    child: const ExportDatabaseBody(),
                  )
                ],
              ),

              /// 导入数据
              ListView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24.w, bottom: 14.w),
                    child: const ImportDatabaseBody(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 导入数据
class ImportDatabaseBody extends StatefulWidget {
  const ImportDatabaseBody({Key? key}) : super(key: key);

  @override
  State<ImportDatabaseBody> createState() => _ImportDatabaseBodyState();
}

class _ImportDatabaseBodyState extends State<ImportDatabaseBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: const Text("导入测试"),
          onTap: () async {
            await importDatabase(context);
          },
        )
      ],
    );
  }
}

/// 导入数据
Future importDatabase(BuildContext context) async {
  print("导入数据");
  try {
    /// 心情数据
    Map<String, dynamic> _moodData = {
      "icon": "",
      "title": "",
      "score": "",
      "content": "",
      "createTime": "",
      "updateTime": ""
    };
    int _dataIndex = 0;

    /// 清除选择文件的缓存
    await FilePicker.platform.clearTemporaryFiles();

    /// 选择文件
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );
    if (result != null) {
      /// 文件路径、内容
      final file = result.files.single.path ?? '';
      final bytes = File(file).readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);
      for (final table in excel.tables.keys) {
        print(table); // 工作表名
        print(excel.tables[table]!.maxCols); // 表最大列数
        print(excel.tables[table]!.maxRows); // 表最大行数
        /// 判断是否是需要的工作表
        if (table == "MoodExample") {
          /// 此处还需要检测导入表是否符合标准，否则导出错误提示的Excel文件

          /// 导入数据操作
          for (final row in excel.tables['MoodExample']!.rows) {
            for (final data in row) {
              _dataIndex++;
              if (_dataIndex < 3) {
                break;
              }
              print(data);
              int? colIndex = data?.colIndex;
              dynamic value = data?.value;
              switch (colIndex) {

                /// 表情
                case 0:
                  _moodData["icon"] = value.toString();
                  break;

                /// 心情
                case 1:
                  _moodData["title"] = value.toString();
                  break;

                /// 内容
                case 2:
                  _moodData["content"] = value.toString();
                  break;

                /// 心情程度
                case 3:
                  _moodData["score"] = value;
                  break;

                /// 创建日期、修改日期
                case 4:
                  final _moodDate = DateFormat("yyyy-MM-dd")
                      .parse(value)
                      .toString()
                      .substring(0, 10);
                  _moodData["createTime"] = _moodDate;
                  _moodData["updateTime"] = _moodDate;
                  break;
              }

              /// 导入数据（一组数据完成）
              if (colIndex == 4) {
                print(moodDataFromJson(json.encode(_moodData)));

                /// 是否操作成功
                late bool _result = false;
                _result = await MoodService.addMoodData(
                    moodDataFromJson(json.encode(_moodData)));
                print(_result);
              }
            }
          }
        }
      }

      /// 更新心情数据
      MoodViewModel _moodViewModel =
          Provider.of<MoodViewModel>(context, listen: false);

      /// 获取所有有记录心情的日期
      MoodService.getMoodRecordedDate(_moodViewModel);

      /// 处理日期
      String moodDatetime =
          _moodViewModel.nowDateTime.toString().substring(0, 10);

      /// 获取心情数据
      MoodService.getMoodData(_moodViewModel, moodDatetime);
    } else {
      /// 未选择文件
    }
  } catch (e) {
    print(e);
  }
}

/// 导出数据
class ExportDatabaseBody extends StatefulWidget {
  const ExportDatabaseBody({Key? key}) : super(key: key);

  @override
  State<ExportDatabaseBody> createState() => _ExportDatabaseBodyState();
}

class _ExportDatabaseBodyState extends State<ExportDatabaseBody> {
  /// 数据导出位置
  String exportPath = "";

  /// 数据是否正在导出
  bool isExport = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 128.w,
          height: 128.w,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withAlpha(140),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  offset: const Offset(0, 5.0),
                  blurRadius: 15.0,
                  spreadRadius: 2.0,
                )
              ],
              shape: BoxShape.circle,
            ),
            child: isExport
                ? CupertinoActivityIndicator(
                    radius: 14.sp,
                    color: const Color(0xFFFFFFFF),
                  )
                : Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: Colors.white10,
                      highlightColor: Colors.white10,
                      icon: const Icon(Remix.arrow_down_line),
                      iconSize: 48.sp,
                      color: const Color(0xFFFFFFFF),
                      padding: EdgeInsets.all(22.w),
                      onPressed: () async {
                        try {
                          /// 没文件则进行生成
                          if (exportPath.isEmpty) {
                            setState(() {
                              isExport = true;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 1000), () async {
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
  final String filePath = "$directory/system/database/export";
  final String fileName = "$filePath/MoodExample_$now.xlsx";

  /// 删除之前的缓存
  try {
    Directory(filePath).deleteSync(recursive: true);
  } catch (e) {
    print(e);
  }

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
    ..cellStyle = cellStyle.copyWith(
        fontFamilyVal: getFontFamily(FontFamily.Apple_Color_Emoji));
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
