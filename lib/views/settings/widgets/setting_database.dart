import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../utils/result.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../widgets/animation/animation.dart';
import '../../../shared/view_models/mood_view_model.dart';
import '../view_models/setting_database_view_model.dart';

/// 数据
class SettingDatabase extends StatefulWidget {
  const SettingDatabase({super.key});

  @override
  State<SettingDatabase> createState() => _SettingDatabaseState();
}

class _SettingDatabaseState extends State<SettingDatabase> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return ChangeNotifierProvider(
      create: (context) => SettingDatabaseViewModel(dataImportExportUseCase: context.read()),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            labelStyle: const TextStyle(fontWeight: FontWeight.w900),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            tabs: [
              Tab(
                child: Text(
                  appL10n.app_setting_database_export_data,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Tab(
                child: Text(
                  appL10n.app_setting_database_import_data,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              children: [
                /// 导出数据
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  child: const ExportDatabaseBody(),
                ),

                /// 导入数据
                Container(
                  margin: const EdgeInsets.only(top: 64),
                  child: const ImportDatabaseBody(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 导入数据
class ImportDatabaseBody extends StatefulWidget {
  const ImportDatabaseBody({super.key});

  @override
  State<ImportDatabaseBody> createState() => _ImportDatabaseBodyState();
}

class _ImportDatabaseBodyState extends State<ImportDatabaseBody> {
  /// 数据错误位置
  String errorFilePath = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final appL10n = AppL10n.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// 导入按钮
            AnimatedPress(
              child: Selector<SettingDatabaseViewModel, ({bool importLoading})>(
                selector: (context, settingDatabaseViewModel) {
                  return (importLoading: settingDatabaseViewModel.importLoading);
                },
                builder: (context, data, _) {
                  return Container(
                    width: 156,
                    height: 156,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [themePrimaryColor, themePrimaryColor.withAlpha(140)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: themePrimaryColor.withValues(alpha: 0.2),
                          offset: const Offset(0, 5.0),
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child:
                        data.importLoading
                            ? const CupertinoActivityIndicator(radius: 14, color: Color(0xFFFFFFFF))
                            : Material(
                              color: Colors.transparent,
                              child: IconButton(
                                tooltip: '导入数据按钮',
                                splashColor: Colors.white10,
                                highlightColor: Colors.white10,
                                icon: const Icon(Remix.arrow_up_line),
                                iconSize: 48,
                                color: const Color(0xFFFFFFFF),
                                padding: const EdgeInsets.all(22),
                                onPressed: () async {
                                  final settingDatabaseViewModel =
                                      context.read<SettingDatabaseViewModel>();
                                  final importMoodDataResult =
                                      await settingDatabaseViewModel.importMoodData();
                                  switch (importMoodDataResult) {
                                    case Success<
                                      ({String errorFilePath, ImportState importState})
                                    >():
                                      {
                                        final importState = importMoodDataResult.value.importState;
                                        switch (importState) {
                                          /// 导入成功
                                          case ImportState.success:
                                            {
                                              SmartDialog.showToast(
                                                AppL10n.of(
                                                  context,
                                                ).app_setting_database_import_data_toast_success,
                                              );

                                              /// 更新心情数据
                                              final moodViewModel = context.read<MoodViewModel>();
                                              moodViewModel.load();
                                            }

                                          /// 导入错误
                                          case ImportState.error:
                                            {
                                              setState(() {
                                                errorFilePath =
                                                    importMoodDataResult.value.errorFilePath;
                                              });
                                              SmartDialog.showToast(
                                                AppL10n.of(
                                                  context,
                                                ).app_setting_database_import_data_toast_error,
                                              );
                                            }
                                        }
                                      }
                                    case Error<({String errorFilePath, ImportState importState})>():
                                  }
                                },
                              ),
                            ),
                  );
                },
              ),
            ),
            Column(
              children: [
                /// 错误文件下载
                Builder(
                  builder: (context) {
                    return errorFilePath.isNotEmpty
                        ? AnimatedPress(
                          child: Container(
                            width: 64,
                            height: 64,
                            margin: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xFFf5222d),
                                  const Color(0xFFf5222d).withAlpha(140),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFf5222d).withValues(alpha: 0.2),
                                  offset: const Offset(0, 5.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(const CircleBorder()),
                                ),
                                onPressed: () {
                                  /// 分享文件
                                  Share.shareXFiles([XFile(errorFilePath)]);
                                },
                                child: Text(
                                  appL10n.app_setting_database_import_data_button_error,
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                  semanticsLabel: '导入错误原因下载',
                                ),
                              ),
                            ),
                          ),
                        )
                        : const SizedBox();
                  },
                ),

                /// 下载模板
                AnimatedPress(
                  child: Container(
                    width: 64,
                    height: 64,
                    margin: const EdgeInsets.only(left: 12, top: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [themePrimaryColor, themePrimaryColor.withAlpha(140)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: themePrimaryColor.withValues(alpha: 0.2),
                          offset: const Offset(0, 5.0),
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: TextButton(
                        style: ButtonStyle(shape: WidgetStateProperty.all(const CircleBorder())),
                        onPressed: () async {
                          final settingDatabaseViewModel = context.read<SettingDatabaseViewModel>();
                          final importMoodDataTemplateResult =
                              await settingDatabaseViewModel.importMoodDataTemplate();
                          switch (importMoodDataTemplateResult) {
                            case Success<String>():
                              {
                                final filePath = importMoodDataTemplateResult.value;

                                /// 分享文件
                                Share.shareXFiles([XFile(filePath)]);
                              }
                            case Error<String>():
                          }
                        },
                        child: Text(
                          appL10n.app_setting_database_import_data_button_template,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          semanticsLabel: '导入模板下载',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// 导出数据
class ExportDatabaseBody extends StatelessWidget {
  const ExportDatabaseBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final appL10n = AppL10n.of(context);

    return Column(
      children: [
        AnimatedPress(
          child: Selector<SettingDatabaseViewModel, ({bool exportLoading})>(
            selector: (context, settingDatabaseViewModel) {
              return (exportLoading: settingDatabaseViewModel.exportLoading);
            },
            builder: (context, data, _) {
              return Container(
                width: 156,
                height: 156,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [themePrimaryColor, themePrimaryColor.withAlpha(140)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: themePrimaryColor.withValues(alpha: 0.2),
                      offset: const Offset(0, 5.0),
                      blurRadius: 15.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child:
                    data.exportLoading
                        ? const CupertinoActivityIndicator(radius: 14, color: Color(0xFFFFFFFF))
                        : Material(
                          color: Colors.transparent,
                          child: IconButton(
                            tooltip: '导出数据按钮',
                            splashColor: Colors.white10,
                            highlightColor: Colors.white10,
                            icon: const Icon(Remix.arrow_down_line),
                            iconSize: 48,
                            color: const Color(0xFFFFFFFF),
                            padding: const EdgeInsets.all(22),
                            onPressed: () async {
                              final settingDatabaseViewModel =
                                  context.read<SettingDatabaseViewModel>();
                              final exportMoodDataAllResult =
                                  await settingDatabaseViewModel.exportMoodDataAll();
                              switch (exportMoodDataAllResult) {
                                case Success<String>():
                                  {
                                    final exportPath = exportMoodDataAllResult.value;
                                    SmartDialog.showToast(
                                      appL10n.app_setting_database_export_data_toast_success,
                                    );

                                    /// 分享文件
                                    Share.shareXFiles([XFile(exportPath)]);
                                  }
                                case Error<String>():
                              }
                            },
                          ),
                        ),
              );
            },
          ),
        ),
      ],
    );
  }
}
