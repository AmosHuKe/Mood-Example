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
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          leading: ActionButton(
            semanticsLabel: '关闭',
            decoration: BoxDecoration(
              color: isDark ? theme.cardColor : AppTheme.staticBackgroundColor1,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: const SafeArea(
          child: MoodCategorySelectBody(key: Key('widget_mood_category_select_body')),
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
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 48),
          child: Consumer<MoodCategorySelectViewModel>(
            builder: (context, moodCategorySelectViewModel, _) {
              final screenType = moodCategorySelectViewModel.screenType;
              final titleText = switch (screenType) {
                MoodCategorySelectType.add => appL10n.mood_category_select_title_1,
                MoodCategorySelectType.edit => appL10n.mood_category_select_title_2,
              };
              final selectDatatimeText = switch (screenType) {
                MoodCategorySelectType.add => LocaleDatetime.yMMMd(
                  context,
                  Utils.datetimeFormatToString(moodCategorySelectViewModel.selectDateTime),
                ),
                MoodCategorySelectType.edit => '',
              };

              return Column(
                children: [
                  Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ), // dart format
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      selectDatatimeText,
                      style: const TextStyle(
                        color: AppTheme.staticSubColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
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
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
        child: Consumer<MoodCategorySelectViewModel>(
          builder: (_, moodCategorySelectViewModel, child) {
            if (moodCategorySelectViewModel.loadMoodCategoryAllLoading) {
              return const Center(child: CupertinoActivityIndicator(radius: 12));
            }

            final widgetList = <Widget>[];
            for (final list in moodCategorySelectViewModel.moodCategoryAll) {
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

    return Consumer<MoodCategorySelectViewModel>(
      builder: (_, moodCategorySelectViewModel, child) {
        final screenType = moodCategorySelectViewModel.screenType;
        final selectDateTime = moodCategorySelectViewModel.selectDateTimeToString;

        return AnimatedPress(
          child: GestureDetector(
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(icon, style: const TextStyle(fontSize: 32)),
                  ),
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            onTap: () {
              switch (screenType) {
                case MoodCategorySelectType.add:
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
                case MoodCategorySelectType.edit:
                  final moodCategoryData = MoodCategoryModel(icon: icon, title: title);

                  /// 关闭当前页并返回数据
                  context.pop<MoodCategoryModel>(moodCategoryData);
              }
            },
          ),
        );
      },
    );
  }
}
