import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../router.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../utils/utils.dart';
import '../../utils/result.dart';
import '../../utils/intl_utils.dart';
import '../../widgets/action_button/action_button.dart';
import '../../domain/models/mood/mood_category_model.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../shared/view_models/mood_view_model.dart';
import 'view_models/mood_category_select_view_model.dart';
import 'view_models/mood_content_edit_view_model.dart';
import 'widgets/mood_option_card.dart';

/// 心情内容编辑页
class MoodContentEditScreen extends StatelessWidget {
  const MoodContentEditScreen({super.key, required this.moodData});

  final MoodDataModel moodData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;

    return ChangeNotifierProvider(
      create: (context) => MoodContentEditViewModel(moodData: moodData),
      child: Consumer<MoodContentEditViewModel>(
        builder: (context, moodContentEditViewModel, child) {
          final moodData = moodContentEditViewModel.moodData;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              forceMaterialTransparency: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              foregroundColor: theme.textTheme.displayLarge!.color,
              shadowColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                LocaleDatetime.yMMMd(context, moodData.create_time),
                style: const .new(fontSize: 14),
              ),
              leading: Align(
                alignment: Alignment.topLeft,
                child: ActionButton(
                  key: const .new('widget_action_button_close'),
                  semanticsLabel: '关闭',
                  decoration: BoxDecoration(
                    color: isDark ? theme.cardColor : AppTheme.staticBackgroundColor1,
                    borderRadius: const .only(bottomRight: .circular(18)),
                  ),
                  child: const Icon(Remix.close_fill, size: 24),
                  onTap: () {
                    onClose(context);
                  },
                ),
              ),
              actions: [
                Align(
                  alignment: .topRight,
                  child: ActionButton(
                    key: const .new('widget_mood_actions_button'),
                    semanticsLabel: '确认记录',
                    decoration: BoxDecoration(
                      color: isDark ? theme.cardColor : const Color(0xFFD6F2E2),
                      borderRadius: const .only(bottomLeft: .circular(18)),
                    ),
                    child: Icon(
                      Remix.check_fill,
                      size: 24,
                      color: isDark ? theme.textTheme.displayLarge!.color : const Color(0xFF587966),
                    ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      final moodViewModel = context.read<MoodViewModel>();

                      /// 是否操作成功
                      var result = const Result<bool>.success(false);

                      /// 存在ID的操作（代表修改）
                      if (moodData.mood_id != null) {
                        /// 修改心情数据
                        /// 赋值修改时间
                        moodContentEditViewModel.moodData = moodData.copyWith(
                          update_time: Utils.datetimeFormatToString(DateTime.now()),
                        );
                        result = await moodViewModel.editMoodData(moodData);
                      } else {
                        /// 创建心情数据
                        result = await moodViewModel.addMoodData(moodData);
                      }
                      switch (result) {
                        case Success<bool>():
                          if (result.value) {
                            if (!context.mounted) return;
                            context.pop();
                          }
                        case Error<bool>():
                      }
                    },
                  ),
                ),
              ],
            ),
            body: child,
          );
        },
        child: SafeArea(
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, _) {
              if (didPop) return;
              onClose(context);
            },
            child: const MoodContentEditBody(),
          ),
        ),
      ),
    );
  }

  /// 关闭返回
  void onClose(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    FocusScope.of(context).unfocus();

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: isDark ? .dark() : .light(),
          child: CupertinoAlertDialog(
            title: Text(appL10n.mood_content_close_button_title),
            content: Text(appL10n.mood_content_close_button_content),
            actions: <CupertinoDialogAction>[
              .new(
                isDefaultAction: true,
                child: Text(appL10n.mood_content_close_button_cancel),
                textStyle: .new(color: theme.textTheme.bodyMedium?.color),
                onPressed: () {
                  context.pop();
                },
              ),
              .new(
                child: Text(appL10n.mood_content_close_button_confirm),
                textStyle: .new(color: theme.textTheme.bodyMedium?.color),
                onPressed: () {
                  context.pop();
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MoodContentEditBody extends StatelessWidget {
  const MoodContentEditBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        Padding(
          padding: const .only(top: 24, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Consumer<MoodContentEditViewModel>(
                builder: (context, moodContentEditViewModel, child) {
                  final moodData = moodContentEditViewModel.moodData;
                  return GestureDetector(
                    child: Semantics(
                      button: true,
                      label: '当前选择心情：${moodData.title}，再次选择换一种心情',
                      excludeSemantics: true,
                      child: MoodOptionCard(icon: moodData.icon, title: moodData.title),
                    ),
                    onTap: () {
                      /// 切换心情
                      GoRouter.of(context)
                          .pushNamed<MoodCategoryModel>(
                            Routes.moodCategorySelect,
                            pathParameters: {
                              'type': MoodCategorySelectType.edit.name,
                              'selectDateTime': moodData.create_time,
                            },
                          )
                          .then((moodCategoryModel) {
                            if (moodCategoryModel == null) return;
                            moodContentEditViewModel.moodData = moodData.copyWith(
                              icon: moodCategoryModel.icon,
                              title: moodCategoryModel.title,
                            );
                          });
                      ;
                    },
                  );
                },
              ),

              /// 心情程度
              const Expanded(child: Align(child: MoodScore())),
            ],
          ),
        ),
        const Padding(
          padding: .only(top: 24, bottom: 48, left: 24, right: 24),
          child: InputContent(),
        ),
      ],
    );
  }
}

/// 内容输入
class InputContent extends StatefulWidget {
  const InputContent({super.key});

  @override
  State<InputContent> createState() => _InputContentState();
}

class _InputContentState extends State<InputContent> {
  /// 内容表单
  final GlobalKey<FormState> formContentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appL10n = AppL10n.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(color: theme.cardColor, borderRadius: .circular(32)),
      child: Padding(
        padding: const .symmetric(vertical: 12, horizontal: 24),
        child: Form(
          key: formContentKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Consumer<MoodContentEditViewModel>(
                builder: (context, moodContentEditViewModel, child) {
                  final moodData = moodContentEditViewModel.moodData;
                  return TextFormField(
                    key: const .new('content'),
                    initialValue: moodData.content,
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: .multiline,
                    maxLines: 10,
                    maxLength: 5000,
                    scrollPhysics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),
                    decoration: .new(
                      hintText: appL10n.mood_content_hintText,
                      hintStyle: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),
                      border: .none,
                      filled: true,
                      fillColor: theme.cardColor,
                    ),
                    buildCounter:
                        (context, {required currentLength, required isFocused, maxLength}) {
                          return Text('$currentLength/$maxLength', style: const .new(fontSize: 12));
                        },
                    onChanged: (value) {
                      moodContentEditViewModel.moodData = moodData.copyWith(content: value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 心情程度
class MoodScore extends StatelessWidget {
  const MoodScore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final appL10n = AppL10n.of(context);

    return Consumer<MoodContentEditViewModel>(
      builder: (context, moodContentEditViewModel, child) {
        final moodData = moodContentEditViewModel.moodData;
        final moodScore = double.parse(moodData.score.toString());

        return Column(
          children: [
            Padding(
              padding: const .only(bottom: 12, left: 24, right: 24),
              child: Text(appL10n.mood_data_score_title, style: const .new(fontSize: 16)),
            ),
            Padding(
              padding: const .only(bottom: 12, left: 24, right: 24),
              child: Text(
                (moodScore ~/ 1).toString(),
                style: const .new(fontSize: 24, fontWeight: .bold),
              ),
            ),
            Slider(
              value: moodScore,
              label: '心情程度调整',
              min: 0.0,
              max: 100.0,
              activeColor: themePrimaryColor,
              thumbColor: themePrimaryColor,
              semanticFormatterCallback: (value) => '当前心情程度：${value ~/ 1}',
              onChanged: (value) {
                moodContentEditViewModel.moodData = moodData.copyWith(score: value ~/ 1);
              },
            ),
          ],
        );
      },
    );
  }
}
