import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../router.dart';
import '../../utils/utils.dart';
import '../../utils/result.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../utils/intl_utils.dart';
import '../../widgets/animation/animation.dart';
import '../../widgets/show_modal_bottom_detail/show_modal_bottom_detail.dart';
import '../../widgets/empty/empty.dart';
import '../../widgets/action_button/action_button.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../shared/view_models/mood_view_model.dart';
import 'view_models/mood_category_select_view_model.dart';
import 'widgets/mood_option_card.dart';

/// 心情页（记录列表）
class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        key: const .new('widget_add_mood_button'),
        heroTag: 'addmood',
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: 64,
          height: 64,
          child: DecoratedBox(
            decoration: BoxDecoration(color: themePrimaryColor, shape: .circle),
            child: const Icon(Remix.add_fill, color: Colors.white, size: 18),
          ),
        ),
        onPressed: () {
          final moodViewModel = context.read<MoodViewModel>();
          GoRouter.of(context).pushNamed(
            Routes.moodCategorySelect,
            pathParameters: {
              'type': MoodCategorySelectType.add.name,
              'selectDateTime': moodViewModel.selectDateTime.toString(),
            },
          );
        },
      ),
      floatingActionButtonLocation: .endFloat,
      body: const MoodBody(key: .new('widget_mood_body')),
    );
  }
}

class MoodBody extends StatelessWidget {
  const MoodBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      slivers: [
        SliverAppBar(
          pinned: false,
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const .symmetric(horizontal: 24),
              child: Align(
                alignment: .center,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      appL10n.mood_title,
                      style: const .new(fontSize: 36, fontWeight: .bold),
                      semanticsLabel: appL10n.app_bottomNavigationBar_title_mood,
                    ),
                  ],
                ),
              ),
            ),
          ),
          collapsedHeight: 100,
          expandedHeight: 100,
        ),

        /// 下拉加载
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            final moodViewModel = context.read<MoodViewModel>();
            moodViewModel.load();
          },
        ),

        /// 日历
        const SliverToBoxAdapter(child: Calendar(key: .new('widget_mood_body_calendar'))),

        /// 心情数据列表
        Selector<MoodViewModel, ({bool moodDataListLoading, List<MoodDataModel> moodDataList})>(
          selector: (_, moodViewModel) {
            return (
              moodDataListLoading: moodViewModel.moodDataListLoading,
              moodDataList: moodViewModel.moodDataList,
            );
          },
          builder: (context, data, child) {
            /// 加载数据的占位
            if (data.moodDataListLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: .only(top: 130),
                    child: CupertinoActivityIndicator(radius: 12),
                  ),
                ),
              );
            }

            /// 没有数据的占位
            if (data.moodDataList.length <= 0) {
              return const SliverToBoxAdapter(
                child: Empty(icon: Icons.subject_rounded, size: 64.0, padding: .only(top: 120)),
              );
            }

            /// 有内容显示
            return SlidableAutoCloseBehavior(
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final moodData = data.moodDataList[index];
                    return MoodCard(key: .new(moodData.mood_id.toString()), moodData: moodData);
                  },
                  childCount: data.moodDataList.length, // dart format
                ),
              ),
            );
          },
        ),

        /// 占位高度
        const SliverToBoxAdapter(child: SizedBox(height: 64)),
      ],
    );
  }
}

/// 日历
class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  /// 日历版式
  CalendarFormat calendarFormat = .week;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);

    return Padding(
      padding: const .symmetric(horizontal: 24, vertical: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [.new(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6)],
          borderRadius: .circular(18),
        ),
        child: Padding(
          padding: const .only(left: 12, right: 12, bottom: 12),
          child:
              Selector<
                MoodViewModel,
                ({DateTime selectDateTime, List<MoodRecordDateModel> moodRecordDateAllList})
              >(
                selector: (BuildContext, moodViewModel) {
                  return (
                    selectDateTime: moodViewModel.selectDateTime,
                    moodRecordDateAllList: moodViewModel.moodRecordDateAllList,
                  );
                },
                builder: (context, data, child) {
                  /// 当前选中的日期
                  final selectDateTime = data.selectDateTime;

                  /// 所有心情的记录日期数据
                  final moodRecordDateAllList = data.moodRecordDateAllList;

                  return TableCalendar(
                    locale: appL10n.localeName,
                    firstDay: .utc(2021, 10, 01),
                    lastDay: .now(),
                    focusedDay: selectDateTime,
                    startingDayOfWeek: .monday,
                    calendarFormat: calendarFormat,
                    formatAnimationCurve: Curves.linearToEaseOut,
                    pageAnimationCurve: Curves.linearToEaseOut,
                    rowHeight: 52,
                    daysOfWeekHeight: 24,
                    // 头部样式
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: .new(fontSize: 14),
                      leftChevronIcon: Icon(
                        Remix.arrow_left_s_line,
                        size: 24,
                        color: AppTheme.staticSubColor,
                        semanticLabel: '日历向前翻页',
                      ),
                      rightChevronIcon: Icon(
                        Remix.arrow_right_s_line,
                        size: 24,
                        color: AppTheme.staticSubColor,
                        semanticLabel: '日历向后翻页',
                      ),
                      formatButtonTextStyle: .new(fontSize: 10, color: AppTheme.staticSubColor),
                      formatButtonDecoration: .new(
                        border: .fromBorderSide(.new(color: AppTheme.staticBackgroundColor1)),
                        borderRadius: .all(.circular(6)),
                      ),
                    ),
                    daysOfWeekStyle: const .new(
                      weekdayStyle: .new(fontSize: 14, color: AppTheme.staticSubColor),
                      weekendStyle: .new(
                        fontSize: 14,
                        fontWeight: .bold,
                        color: AppTheme.staticSubColor,
                      ),
                    ),
                    // 自定义界面构建
                    calendarBuilders: .new(
                      defaultBuilder: (context, day, focusedDay) {
                        return calenderBuilder(
                          day: day,
                          moodRecordDateList: moodRecordDateAllList,
                          textStyle: .new(color: isDark ? Colors.white : Colors.black87),
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return calenderBuilder(
                          day: day,
                          bodyColors: [themePrimaryColor, themePrimaryColor],
                          boxShadow: [
                            .new(color: themePrimaryColor.withValues(alpha: 0.2), blurRadius: 6),
                          ],
                          textStyle: const .new(color: Colors.white),
                        );
                      },
                      outsideBuilder: (context, day, focusedDay) {
                        const staticSubColor = AppTheme.staticSubColor;
                        return calenderBuilder(
                          day: day,
                          textStyle: .new(
                            color: isDark ? staticSubColor.withValues(alpha: 0.6) : staticSubColor,
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        return calenderBuilder(
                          day: day,
                          moodRecordDateList: moodRecordDateAllList,
                          bodyColors: [
                            themePrimaryColor.withValues(alpha: 0.2),
                            themePrimaryColor.withValues(alpha: 0.2),
                          ],
                          textStyle: .new(color: isDark ? Colors.white : Colors.black87),
                        );
                      },
                      disabledBuilder: (context, day, focusedDay) {
                        return calenderBuilder(
                          day: day,
                          textStyle: .new(
                            color: isDark ? const Color(0x20BFBFBF) : const Color(0x50BFBFBF),
                          ),
                        );
                      },
                    ),
                    onFormatChanged: (format) => setState(() => calendarFormat = format),
                    availableCalendarFormats: const {.month: '小', .twoWeeks: '大', .week: '中'},
                    selectedDayPredicate: (day) => isSameDay(selectDateTime, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      /// 之前选择的日期
                      final oldSelectedDay = selectDateTime;

                      /// 选择的日期相同则不操作
                      if (oldSelectedDay == selectedDay) return;
                      final moodViewModel = context.read<MoodViewModel>();

                      /// 赋值当前选择的日期
                      moodViewModel.selectDateTime = selectedDay;

                      /// 获取心情数据
                      moodViewModel.loadMoodDataList();
                    },
                    onCalendarCreated: (pageController) {
                      /// 初始化触发一次
                      Future.delayed(const Duration(milliseconds: 1), () {
                        pageController.previousPage(
                          duration: const .new(milliseconds: 400),
                          curve: Curves.linearToEaseOut,
                        );
                      });
                      Future.delayed(const .new(milliseconds: 1000), () {
                        pageController.nextPage(
                          duration: const .new(milliseconds: 400),
                          curve: Curves.linearToEaseOut,
                        );
                      });
                    },
                  );
                },
              ),
        ),
      ),
    );
  }

  /// 日历样式构建
  ///
  /// - [day] 当前日期
  /// - [moodRecordDateList] 所有已记录心情的日期
  /// - [bodyColors] 主背景渐变颜色 - 至少两个
  /// - [textStyle] 字体样式
  Widget calenderBuilder({
    required DateTime day,
    List<MoodRecordDateModel>? moodRecordDateList,
    List<Color>? bodyColors,
    List<BoxShadow>? boxShadow,
    required TextStyle textStyle,
  }) {
    final nowDate = Utils.datetimeFormatToString(day);

    /// 所有已记录心情的日期
    final list = moodRecordDateList ?? [];

    return SizedBox(
      width: 36,
      height: 48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: bodyColors ?? [Colors.transparent, Colors.transparent]),
          boxShadow: boxShadow,
          borderRadius: .circular(12),
        ),
        child: Center(
          child: Stack(
            alignment: .center,
            children: [
              Text(nowDate.substring(8, 10), style: textStyle),
              Builder(
                builder: (context) {
                  var recordedIndex = -1;
                  for (var i = 0; i < list.length; i++) {
                    if (list[i].record_date == Utils.datetimeFormatToString(day)) {
                      recordedIndex = i;
                    }
                  }
                  if (recordedIndex > -1) {
                    return Padding(
                      padding: const .only(top: 28),
                      child: Text(list[recordedIndex].icon, style: const .new(fontSize: 8)),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 心情卡片
class MoodCard extends StatelessWidget {
  const MoodCard({super.key, required this.moodData});

  final MoodDataModel moodData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);

    return Slidable(
      key: key,
      endActionPane: .new(
        motion: const DrawerMotion(),
        children: [
          Expanded(
            child: Align(
              child: ActionButton(
                key: const .new('widget_mood_card_slidable_action_button_edit'),
                semanticsLabel: '编辑',
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F2E2),
                  borderRadius: .circular(18),
                ),
                onTap: () {
                  GoRouter.of(context).pushNamed(
                    Routes.moodContentEdit,
                    pathParameters: {'moodData': jsonEncode(moodData.toJson())},
                  );
                },
                child: const Icon(Remix.edit_box_line, color: Color(0xFF587966)),
              ),
            ),
          ),
          Expanded(
            child: Align(
              child: ActionButton(
                key: const .new('widget_mood_card_slidable_action_button_delete'),
                semanticsLabel: '删除',
                width: 56,
                height: 56,
                margin: const .only(right: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE5E4),
                  borderRadius: .circular(18),
                ),
                child: const Icon(Remix.delete_bin_line, color: Color(0xFFC04A4A)),
                onTap: () {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: isDark ? .dark() : .light(),
                        child: CupertinoAlertDialog(
                          title: Text(appL10n.mood_data_delete_button_title),
                          content: Text(appL10n.mood_data_delete_button_content),
                          actions: <CupertinoDialogAction>[
                            .new(
                              isDefaultAction: true,
                              child: Text(appL10n.mood_data_delete_button_cancel),
                              textStyle: .new(color: theme.textTheme.bodyMedium?.color),
                              onPressed: () => context.pop(),
                            ),
                            .new(
                              isDestructiveAction: true,
                              onPressed: () async {
                                final moodViewModel = context.read<MoodViewModel>();
                                final result = await moodViewModel.deleteMoodData(
                                  moodData.mood_id!,
                                );
                                switch (result) {
                                  case Success<bool>():
                                    if (result.value) {
                                      context.pop();
                                    }
                                  case Error<bool>():
                                }
                              },
                              child: Text(appL10n.mood_data_delete_button_confirm),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),

      /// 内容
      child: AnimatedPress(
        child: Padding(
          padding: const .symmetric(horizontal: 24, vertical: 12),
          child: GestureDetector(
            child: Container(
              constraints: const BoxConstraints(minHeight: 120),
              decoration: BoxDecoration(color: theme.cardColor, borderRadius: .circular(18)),
              padding: const .all(12),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  /// 头部
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      /// 标题
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF2B3034)
                                      : AppTheme.staticBackgroundColor3,
                                  borderRadius: .circular(14),
                                ),
                                child: Align(
                                  alignment: .center,
                                  child: ExcludeSemantics(
                                    child: Text(moodData.icon, style: const .new(fontSize: 20)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const .symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    ExcludeSemantics(
                                      child: Text(
                                        moodData.title,
                                        maxLines: 1,
                                        overflow: .ellipsis,
                                        style: const .new(fontSize: 18, fontWeight: .bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const .only(top: 4),
                                      child: Text(
                                        moodData.create_time,
                                        style: const .new(
                                          color: AppTheme.staticSubColor,
                                          fontSize: 14,
                                          fontWeight: .normal,
                                        ),
                                        semanticsLabel:
                                            '${LocaleDatetime.yMMMd(context, moodData.create_time)} 心情：${moodData.title}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: .center,
                        padding: const .symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2B3034) : AppTheme.staticBackgroundColor3,
                          borderRadius: .circular(10),
                        ),
                        child: Text(
                          moodData.score.toString(),
                          style: const .new(fontSize: 14, fontWeight: .bold),
                          semanticsLabel: '${appL10n.mood_data_score_title}：${moodData.score}',
                        ),
                      ),
                    ],
                  ),

                  /// 内容
                  Padding(
                    padding: const .only(left: 60, top: 20, bottom: 20),
                    child: Text(
                      moodData.content ?? appL10n.mood_data_content_empty,
                      maxLines: 5,
                      overflow: .ellipsis,
                      softWrap: true,
                      style: .new(
                        color: moodData.content != null
                            ? theme.textTheme.bodyMedium!.color
                            : AppTheme.staticSubColor,
                        fontSize: 14,
                      ),
                      semanticsLabel: moodData.content != null
                          ? '记录内容：${moodData.content}'
                          : '没有记录内容',
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              showModalBottomDetail(
                context: context,
                child: MoodDetail(moodData: moodData),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 心情详情展示
class MoodDetail extends StatelessWidget {
  const MoodDetail({super.key, required this.moodData});

  final MoodDataModel moodData;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        Align(
          heightFactor: 2,
          child: Text(
            LocaleDatetime.yMMMd(context, moodData.create_time),
            style: const .new(fontSize: 16, fontWeight: .bold, color: AppTheme.staticSubColor),
            semanticsLabel:
                '${LocaleDatetime.yMMMd(context, moodData.create_time)} 心情：${moodData.title}',
          ),
        ),
        Padding(
          padding: const .only(top: 12, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              /// 心情卡片
              ExcludeSemantics(
                child: MoodOptionCard(icon: moodData.icon, title: moodData.title),
              ),

              /// 打分
              Expanded(
                child: Align(
                  child: Column(
                    children: [
                      Padding(
                        padding: const .only(bottom: 12),
                        child: Text(appL10n.mood_data_score_title, style: const .new(fontSize: 16)),
                      ),
                      Text(
                        moodData.score.toString(),
                        style: const .new(fontSize: 24, fontWeight: .bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// 内容
        Container(
          margin: const .only(top: 24, bottom: 48, left: 24, right: 24),
          padding: const .all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF202427) : Colors.white,
            borderRadius: .circular(32),
          ),
          child: Text(
            moodData.content ?? appL10n.mood_data_content_empty,
            style: .new(
              color: moodData.content != null
                  ? isDark
                        ? Colors.white
                        : Colors.black87
                  : AppTheme.staticSubColor,
              fontSize: 14,
            ),
            semanticsLabel: moodData.content != null ? '记录内容：${moodData.content}' : '没有记录内容',
          ),
        ),
      ],
    );
  }
}
