import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../router.dart';
import '../../utils/utils.dart';
import '../../themes/app_theme.dart';
import '../../utils/intl_utils.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../widgets/action_button/action_button.dart';
import '../../widgets/animation/animation.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../domain/models/mood/mood_category_model.dart';
import 'view_models/mood_category_select_view_model.dart';

/// 心情类别选择页
class MoodCategorySelectScreen extends StatelessWidget {
  const MoodCategorySelectScreen({
    super.key,
    required this.screenType,
    required this.selectDateTime,
  });

  final MoodCategorySelectType screenType;

  /// 当前选择的日期
  final DateTime selectDateTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;

    return ChangeNotifierProvider(
      create: (context) {
        return MoodCategorySelectViewModel(
          moodCategoryLoadUseCase: context.read(),
          screenType: screenType,
          selectDateTime: selectDateTime,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.textTheme.displayLarge!.color,
          shadowColor: Colors.transparent,
          titleTextStyle: const .new(color: Colors.black, fontSize: 14),
          leading: Align(
            alignment: .topLeft,
            child: ActionButton(
              semanticsLabel: '关闭',
              decoration: BoxDecoration(
                color: isDark ? theme.cardColor : AppTheme.staticBackgroundColor1,
                borderRadius: const .only(bottomRight: .circular(18)),
              ),
              child: const Icon(Remix.arrow_left_line, size: 24),
              onTap: () => context.pop(),
            ),
          ),
        ),
        body: const SafeArea(
          child: MoodCategorySelectBody(key: .new('widget_mood_category_select_body')),
        ),
      ),
    );
  }
}

class MoodCategorySelectBody extends StatelessWidget {
  const MoodCategorySelectBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        /// 标题
        Padding(
          padding: const .only(left: 24, right: 24, top: 24, bottom: 48),
          child:
              Selector<
                MoodCategorySelectViewModel,
                ({MoodCategorySelectType screenType, DateTime selectDateTime})
              >(
                selector: (_, moodCategorySelectViewModel) {
                  return (
                    screenType: moodCategorySelectViewModel.screenType,
                    selectDateTime: moodCategorySelectViewModel.selectDateTime,
                  );
                },
                builder: (context, data, _) {
                  final screenType = data.screenType;
                  final titleText = switch (screenType) {
                    .add => appL10n.mood_category_select_title_1,
                    .edit => appL10n.mood_category_select_title_2,
                  };
                  final selectDatatimeText = switch (screenType) {
                    .add => LocaleDatetime.yMMMd(
                      context,
                      Utils.datetimeFormatToString(data.selectDateTime),
                    ),
                    .edit => '',
                  };

                  return Column(
                    children: [
                      Text(titleText, style: const .new(fontSize: 24, fontWeight: .bold)),
                      Padding(
                        padding: const .only(top: 4),
                        child: Text(
                          selectDatatimeText,
                          style: const .new(
                            color: AppTheme.staticSubColor,
                            fontSize: 14,
                            fontWeight: .normal,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
        ),

        /// 心情选项
        const MoodOption(),
      ],
    );
  }
}

/// 心情选项
class MoodOption extends StatelessWidget {
  const MoodOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: const .only(left: 24, right: 24, bottom: 48),
        child:
            Selector<
              MoodCategorySelectViewModel,
              ({bool loadMoodCategoryAllLoading, List<MoodCategoryModel> moodCategoryAll})
            >(
              selector: (_, moodCategorySelectViewModel) {
                return (
                  loadMoodCategoryAllLoading:
                      moodCategorySelectViewModel.loadMoodCategoryAllLoading,
                  moodCategoryAll: moodCategorySelectViewModel.moodCategoryAll,
                );
              },
              builder: (context, data, child) {
                if (data.loadMoodCategoryAllLoading) {
                  return const Center(child: CupertinoActivityIndicator(radius: 12));
                }

                final widgetList = <Widget>[];
                for (final list in data.moodCategoryAll) {
                  widgetList.add(MoodOptionCard(icon: list.icon, title: list.title));
                }
                return Wrap(spacing: 24, runSpacing: 24, children: widgetList);
              },
            ),
      ),
    );
  }
}

/// 心情选项卡片
class MoodOptionCard extends StatelessWidget {
  const MoodOptionCard({super.key, required this.icon, required this.title});

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Selector<
      MoodCategorySelectViewModel,
      ({MoodCategorySelectType screenType, String selectDateTimeToString})
    >(
      selector: (_, moodCategorySelectViewModel) {
        return (
          screenType: moodCategorySelectViewModel.screenType,
          selectDateTimeToString: moodCategorySelectViewModel.selectDateTimeToString,
        );
      },
      builder: (context, data, child) {
        final screenType = data.screenType;
        final selectDateTime = data.selectDateTimeToString;

        return AnimatedPress(
          child: GestureDetector(
            child: SizedBox(
              width: 128,
              height: 128,
              child: DecoratedBox(
                decoration: BoxDecoration(color: theme.cardColor, borderRadius: .circular(32)),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Padding(
                      padding: const .only(bottom: 6),
                      child: Text(icon, style: const .new(fontSize: 32)),
                    ),
                    Text(title, style: const .new(fontSize: 16, fontWeight: .w400)),
                  ],
                ),
              ),
            ),
            onTap: () {
              switch (screenType) {
                case .add:
                  {
                    final moodData = MoodDataModel(
                      icon: icon,
                      title: title,
                      score: 50,
                      create_time: selectDateTime,
                      update_time: selectDateTime,
                    );

                    /// 关闭当前页并跳转输入内容页
                    context.pop();
                    GoRouter.of(context).pushNamed(
                      Routes.moodContentEdit,
                      pathParameters: {'moodData': jsonEncode(moodData.toJson())},
                    );
                  }
                case .edit:
                  {
                    final moodCategoryData = MoodCategoryModel(icon: icon, title: title);

                    /// 关闭当前页并返回数据
                    context.pop<MoodCategoryModel>(moodCategoryData);
                  }
              }
            },
          ),
        );
      },
    );
  }
}
