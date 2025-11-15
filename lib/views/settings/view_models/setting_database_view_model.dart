import 'dart:io';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../../utils/utils.dart';
import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_data_model.dart';
import '../../../domain/use_cases/application/data_import_export_use_case.dart';

/// 导入状态
enum ImportState { success, error }

class SettingDatabaseViewModel extends ChangeNotifier {
  SettingDatabaseViewModel({required DataImportExportUseCase dataImportExportUseCase})
    : _dataImportExportUseCase = dataImportExportUseCase {}

  final DataImportExportUseCase _dataImportExportUseCase;

  /// 正在导出
  bool _exportLoading = false;
  bool get exportLoading => _exportLoading;

  /// 正在导入
  bool _importLoading = false;
  bool get importLoading => _importLoading;

  /// 导出数据路径
  String _exportPath = '';
  String get exportPath => _exportPath;

  /// 所有心情数据
  List<MoodDataModel> _moodDataAllList = [];
  List<MoodDataModel> get moodDataAllList => _moodDataAllList;

  /// 导入心情模板生成路径
  String _importTemplatePath = '';
  String get importTemplatePath => _importTemplatePath;

  /// 获取所有心情数据
  Future<Result<void>> loadMoodDataAllList() async {
    final moodDataListResult = await _dataImportExportUseCase.getMoodDataAll();
    switch (moodDataListResult) {
      case Success<List<MoodDataModel>>():
        _moodDataAllList = moodDataListResult.value;
        return const .success(null);
      case Error<List<MoodDataModel>>():
        return .error(moodDataListResult.error);
    }
  }

  /// 导出所有心情数据
  ///
  /// @return [String] 导出路径
  Future<Result<String>> exportMoodDataAll() async {
    if (_exportPath.isNotEmpty) return .success(_exportPath);
    _exportLoading = true;
    notifyListeners();

    try {
      _moodDataAllList = [];
      final nowDateTime = DateTime.now();

      /// 获取 App 文件临时根路径
      final directory = (await getTemporaryDirectory()).path;

      /// 保存文件路径及名称
      final filePath = '$directory/system/database/export';
      final fileName = '$filePath/MoodExample_$nowDateTime.xlsx';

      /// 删除之前的缓存
      try {
        Directory(filePath).deleteSync(recursive: true);
      } on FileSystemException catch (e) {
        print('exportMoodDataAll deleteSync error：$e');
      }

      /// 创建 Excel
      final excel = Excel.createExcel();

      /// 创建工作薄
      final sheetObject = excel['MoodExample'];

      /// 设置默认工作薄
      excel.setDefaultSheet('MoodExample');

      /// 单元格样式
      final cellStyle = CellStyle(
        fontColorHex: .fromHexString('#FFFFFF'),
        fontSize: 10,
        bold: true,
        fontFamily: getFontFamily(.Microsoft_Sans_Serif),
        backgroundColorHex: .fromHexString('#3E4663'),
        horizontalAlign: .Center,
        verticalAlign: .Center,
      );

      /// 创建大标题
      sheetObject.merge(.indexByString('A1'), .indexByString('F1'));
      sheetObject.cell(.indexByString('A1'))
        ..value = TextCellValue('MoodExample')
        ..cellStyle = .new(
          fontColorHex: .fromHexString('#FFFFFF'),
          fontSize: 10,
          bold: true,
          fontFamily: getFontFamily(.Microsoft_Sans_Serif),
          backgroundColorHex: .fromHexString('#3E4663'),
          horizontalAlign: .Center,
          verticalAlign: .Center,
        );

      /// 创建字段标题
      sheetObject.cell(.indexByString('A2'))
        ..value = TextCellValue('表情')
        ..cellStyle = cellStyle.copyWith(fontFamilyVal: getFontFamily(.Apple_Color_Emoji));
      sheetObject.cell(.indexByString('B2'))
        ..value = TextCellValue('心情')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('C2'))
        ..value = TextCellValue('内容')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('D2'))
        ..value = TextCellValue('心情程度')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('E2'))
        ..value = TextCellValue('创建时间')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('F2'))
        ..value = TextCellValue('修改时间')
        ..cellStyle = cellStyle;

      /// 获取所有心情数据并赋值
      await loadMoodDataAllList();

      /// 添加Excel数据
      _moodDataAllList.forEach((list) {
        final cellValueList = <CellValue>[
          TextCellValue(list.icon),
          TextCellValue(list.title),
          TextCellValue(list.content ?? ''),
          TextCellValue(list.score.toString()),
          TextCellValue(list.create_time),
          TextCellValue(list.update_time),
        ];
        sheetObject.appendRow(cellValueList);
      });

      /// 保存 Excel
      final fileBytes = excel.save();

      /// 存入文件
      File(join(fileName))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      _exportPath = fileName;
      _exportLoading = false;
      notifyListeners();
      return .success(fileName);
    } on Exception catch (e) {
      print('exportMoodDataAll error：$e');
      _exportLoading = false;
      notifyListeners();
      return .error(e);
    }
  }

  /// 导入心情模板生成
  ///
  /// @return [String] 导出路径
  Future<Result<String>> importMoodDataTemplate() async {
    if (_importTemplatePath.isNotEmpty) return .success(_importTemplatePath);
    try {
      /// 获取 App 文件临时根路径
      final directory = (await getTemporaryDirectory()).path;

      /// 保存文件路径及名称
      final filePath = '$directory/system/database/importTemplate';
      final fileName = '$filePath/MoodExample导入模板.xlsx';

      /// 删除之前的缓存
      try {
        Directory(filePath).deleteSync(recursive: true);
      } on FileSystemException catch (e) {
        print('importMoodDataTemplate deleteSync error：$e');
      }

      /// 创建 Excel
      final excel = Excel.createExcel();

      /// 创建工作薄
      final sheetObject = excel['MoodExample'];

      /// 设置默认工作薄
      excel.setDefaultSheet('MoodExample');

      /// 单元格样式
      final cellStyle = CellStyle(
        fontColorHex: .fromHexString('#FFFFFF'),
        fontSize: 10,
        bold: true,
        fontFamily: getFontFamily(.Microsoft_Sans_Serif),
        backgroundColorHex: .fromHexString('#3E4663'),
        horizontalAlign: .Center,
        verticalAlign: .Center,
      );

      /// 创建大标题
      sheetObject.merge(.indexByString('A1'), .indexByString('E1'));
      sheetObject.cell(.indexByString('A1'))
        ..value = TextCellValue('MoodExample')
        ..cellStyle = .new(
          fontColorHex: .fromHexString('#FFFFFF'),
          fontSize: 10,
          bold: true,
          fontFamily: getFontFamily(.Microsoft_Sans_Serif),
          backgroundColorHex: .fromHexString('#3E4663'),
          horizontalAlign: .Center,
          verticalAlign: .Center,
        );

      /// 创建字段标题
      sheetObject.cell(.indexByString('A2'))
        ..value = TextCellValue('表情')
        ..cellStyle = cellStyle.copyWith(fontFamilyVal: getFontFamily(.Apple_Color_Emoji));
      sheetObject.cell(.indexByString('B2'))
        ..value = TextCellValue('心情')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('C2'))
        ..value = TextCellValue('内容')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('D2'))
        ..value = TextCellValue('心情程度')
        ..cellStyle = cellStyle;
      sheetObject.cell(.indexByString('E2'))
        ..value = TextCellValue('创建时间')
        ..cellStyle = cellStyle;

      /// 添加Excel数据
      sheetObject.appendRow([
        TextCellValue('😊'),
        TextCellValue('开心'),
        TextCellValue('今天很开心'),
        TextCellValue('55'),
        TextCellValue(Utils.datetimeFormatToString(.now())),
      ]);

      /// 保存 Excel
      final fileBytes = excel.save();

      /// 存入文件
      File(join(fileName))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      _importTemplatePath = fileName;
      return .success(fileName);
    } on Exception catch (e) {
      print('importMoodDataTemplate error：$e');
      return .error(e);
    }
  }

  /// 导入心情数据
  ///
  /// ```dart
  /// @return {
  ///   [ImportState] importState,  // 导入状态
  ///   [String] errorFilePath,     // 错误文件位置
  /// }
  /// ```
  Future<Result<({ImportState importState, String errorFilePath})>> importMoodData() async {
    try {
      /// 清除选择文件的缓存
      await FilePicker.platform.clearTemporaryFiles();

      /// 选择文件
      final pickedFile = await FilePicker.platform.pickFiles(
        type: .custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false,
      );
      if (pickedFile != null) {
        print('已选择导入文件');
        _importLoading = true;
        notifyListeners();

        /// 文件路径、内容
        final file = pickedFile.files.single.path ?? '';
        final bytes = File(file).readAsBytesSync();
        final excel = Excel.decodeBytes(bytes);
        for (final table in excel.tables.keys) {
          /// 工作表
          final excelTable = excel.tables[table];
          if (excelTable == null) continue;
          print('当前工作表：$table');
          print('当前工作表最大列数：${excelTable.maxColumns}');
          print('当前工作表最大行数：${excelTable.maxRows}');

          /// 判断是否是需要的工作表
          if (table == 'MoodExample') {
            /// 检测导入表是否符合标准，否则导出错误提示的 Excel 文件
            final importMoodDataErrorResult = await importMoodDataError(excel.tables[table]!.rows);
            switch (importMoodDataErrorResult) {
              case Success<String>():
                {
                  final errorFilePath = importMoodDataErrorResult.value;
                  if (errorFilePath.isNotEmpty) {
                    print('错误文件：${errorFilePath}');
                    _importLoading = false;
                    notifyListeners();
                    return .success(
                      (importState: .error, errorFilePath: errorFilePath), // dart format
                    );
                  } else {
                    /// 正式导入数据操作
                    final importMoodDataBeginResult = await importMoodDataBegin(
                      excel.tables[table]!.rows,
                    );
                    switch (importMoodDataBeginResult) {
                      case Success<void>():
                        _importLoading = false;
                        notifyListeners();
                        return const .success(
                          (importState: .success, errorFilePath: ''), // dart format
                        );
                      case Error<void>():
                        print('importMoodData error：${importMoodDataBeginResult.error}');
                        _importLoading = false;
                        notifyListeners();
                        return .error(importMoodDataBeginResult.error);
                    }
                  }
                }
              case Error<String>():
                print('importMoodData error：${importMoodDataErrorResult.error}');
                _importLoading = false;
                notifyListeners();
                return .error(importMoodDataErrorResult.error);
            }
          }
        }

        _importLoading = false;
        notifyListeners();
        return .error(Exception('未找到指定工作表'));
      } else {
        print('importMoodData error：未选择文件');
        return .error(Exception('未选择文件'));
      }
    } on Exception catch (e) {
      print('importMoodData error：$e');
      return .error(e);
    }
  }

  /// 导入心情数据错误的处理
  ///
  /// @return [String] 错误数据文件路径
  Future<Result<String>> importMoodDataError(List<List<Data?>> moodData) async {
    try {
      var errorFilePath = '';
      final errorData = await validateImportMoodData(moodData);

      /// 存在错误就开始存储错误文件
      if (errorData.isNotEmpty) {
        final nowDateTime = DateTime.now();

        /// 获取 App 文件临时根路径
        final directory = (await getTemporaryDirectory()).path;

        /// 保存文件路径及名称
        final filePath = '$directory/system/database/importError';
        final fileName = '$filePath/MoodExample导入错误内容_$nowDateTime.xlsx';

        /// 删除之前的缓存
        try {
          Directory(filePath).deleteSync(recursive: true);
        } on FileSystemException catch (e) {
          print('importMoodDataError deleteSync error：$e');
        }

        /// 创建 Excel
        final excelError = Excel.createExcel();

        /// 创建工作薄
        final sheetObject = excelError['MoodExample'];

        /// 设置默认工作薄
        excelError.setDefaultSheet('MoodExample');

        /// 单元格样式
        final cellStyle = CellStyle(
          fontColorHex: .fromHexString('#FFFFFF'),
          fontSize: 10,
          bold: true,
          fontFamily: getFontFamily(.Microsoft_Sans_Serif),
          backgroundColorHex: .fromHexString('#3E4663'),
          horizontalAlign: .Center,
          verticalAlign: .Center,
        );

        /// 创建大标题
        sheetObject.merge(.indexByString('A1'), .indexByString('B1'));
        sheetObject.cell(.indexByString('A1'))
          ..value = TextCellValue('MoodExample')
          ..cellStyle = .new(
            fontColorHex: .fromHexString('#FFFFFF'),
            fontSize: 10,
            bold: true,
            fontFamily: getFontFamily(.Microsoft_Sans_Serif),
            backgroundColorHex: .fromHexString('#3E4663'),
            horizontalAlign: .Center,
            verticalAlign: .Center,
          );

        /// 创建字段标题
        sheetObject.cell(.indexByString('A2'))
          ..value = TextCellValue('错误所在行')
          ..cellStyle = cellStyle.copyWith(fontFamilyVal: getFontFamily(.Apple_Color_Emoji));
        sheetObject.cell(.indexByString('B2'))
          ..value = TextCellValue('错误内容')
          ..cellStyle = cellStyle;

        /// 添加 Excel 数据
        for (final list in errorData) {
          sheetObject.appendRow(list);
        }

        /// 保存 Excel
        final fileBytes = excelError.save();

        /// 存入文件
        File(join(fileName))
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);

        errorFilePath = fileName;
      }
      return .success(errorFilePath);
    } on Exception catch (e) {
      print('importMoodDataError error：$e');
      return .error(e);
    }
  }

  /// 验证导入的心情数据
  ///
  /// @return [CellValue] 错误数据（包含原因）
  Future<List<List<CellValue>>> validateImportMoodData(List<List<Data?>> moodData) async {
    /// 错误内容
    final errorData = <List<CellValue>>[];

    /// 错误原因
    var errorText = '';
    var dataIndex = 0;
    var rowIndex = 0;
    for (final row in moodData) {
      dataIndex++;
      if (dataIndex < 3) {
        continue;
      }
      for (final data in row) {
        final cellValue = data?.value;
        switch (rowIndex) {
          /// 表情
          case 0:
            if (cellValue == null) {
              errorText += '【表情必填】 ';
            }

          /// 心情
          case 1:
            if (cellValue == null) {
              errorText += '【心情必填】 ';
            }

          /// 内容
          case 2:
            break;

          /// 心情程度
          case 3:
            final tryValue = int.tryParse(cellValue.toString());
            if (tryValue == null) {
              errorText += '【心情程度只能为0-100整数】 ';
            }
            if (tryValue != null && (tryValue < 0 || tryValue > 100)) {
              errorText += '【心情程度只能为0-100整数】 ';
            }

          /// 创建日期、修改日期
          case 4:
            final tryValue = Utils.datetimeParseToString(cellValue.toString());
            if (tryValue.isEmpty) {
              errorText += '【创建时间只能为文本，如2000-01-01】 ';
            }
        }

        /// 导入数据（一组数据完成）并且错误内容不为空
        if (rowIndex == 4 && errorText.isNotEmpty) {
          errorData.add([TextCellValue('第 $dataIndex 行'), TextCellValue(errorText)]);
        }

        /// 重置
        if (rowIndex == 4) {
          rowIndex = -1;
          errorText = '';
        }
        rowIndex++;
      }
    }

    return errorData;
  }

  /// 正式导入心情数据
  Future<Result<void>> importMoodDataBegin(List<List<Data?>> excelMoodData) async {
    final moodDataList = <MoodDataModel>[];

    /// 心情数据
    var moodData = const MoodDataModel(
      icon: '',
      title: '',
      score: 0,
      create_time: '',
      update_time: '',
    );
    var dataIndex = 0;
    for (final row in excelMoodData) {
      for (final data in row) {
        dataIndex++;
        if (dataIndex < 3) {
          break;
        }

        final colIndex = data?.columnIndex;
        final cellValue = data?.value;
        switch (colIndex) {
          /// 表情
          case 0:
            moodData = moodData.copyWith(icon: cellValue.toString());

          /// 心情
          case 1:
            moodData = moodData.copyWith(title: cellValue.toString());

          /// 内容
          case 2:
            moodData = moodData.copyWith(content: cellValue.toString());

          /// 心情程度
          case 3:
            moodData = moodData.copyWith(score: int.tryParse(cellValue.toString()));

          /// 创建日期、修改日期
          case 4:
            final moodDate = Utils.datetimeParseToString(cellValue.toString());
            moodData = moodData.copyWith(create_time: moodDate, update_time: moodDate);
        }

        /// 导入数据（一组数据完成）
        if (colIndex == 4) {
          print('当前导入数据：${moodData.toJson()}');
          moodDataList.add(moodData);
        }
      }
    }

    /// 开始导入所有数据
    final result = await _dataImportExportUseCase.addMoodDataAll(moodDataList);
    return result;
  }
}
