import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../utils/utils.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../widgets/empty/empty.dart';
import '../../widgets/animation/animation.dart';
import '../../domain/models/statistic/statistic_model.dart';
import '../../shared/view_models/statistic_view_model.dart';

/// 统计
class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: const StatisticBody(key: .new('widget_statistic_body')),
    );
  }
}

class StatisticBody extends StatelessWidget {
  const StatisticBody({super.key});

  final listPadding = const EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);
    final statisticViewModel = context.read<StatisticViewModel>();
    final statisticFilterDays = statisticViewModel.statisticFilterDays;
    final statisticFilterTitle = [
      appL10n.statistic_filter_7d,
      appL10n.statistic_filter_15d,
      appL10n.statistic_filter_30d,
    ];

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      primary: false,
      shrinkWrap: false,
      slivers: [
        SliverAppBar(
          pinned: false,
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Align(
              child: Container(
                width: .maxFinite,
                margin: const .symmetric(horizontal: 24),
                child: Wrap(
                  alignment: .spaceBetween,
                  crossAxisAlignment: .center,
                  children: [
                    Text(
                      appL10n.statistic_title,
                      style: const .new(fontSize: 36, fontWeight: .bold),
                      semanticsLabel: appL10n.app_bottomNavigationBar_title_statistic,
                    ),
                    Selector<StatisticViewModel, ({int selectDays})>(
                      selector: (_, statisticViewModel) {
                        return (selectDays: statisticViewModel.selectDays);
                      },
                      builder: (context, data, child) {
                        final selectDays = data.selectDays;
                        return Row(
                          mainAxisSize: .min,
                          children: .generate(statisticFilterDays.length, (index) {
                            final filterDays = statisticFilterDays[index];
                            final filterTitle = statisticFilterTitle[index];
                            return FilterButton(
                              filterTitle,
                              checked: selectDays == filterDays,
                              semanticsLabel: '筛选$filterDays日统计数据',
                              onTap: () {
                                if (selectDays == filterDays) return;
                                statisticViewModel.selectDays = filterDays;
                                statisticViewModel.load();
                              },
                            );
                          }),
                        );
                      },
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
            statisticViewModel.load();
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .only(bottom: 48),
            child: Column(
              children: [
                /// 总体统计
                Padding(padding: listPadding, child: const OverallStatistics()),
                const SizedBox(height: 12),

                /// 情绪波动（线）
                Padding(padding: listPadding, child: const StatisticMoodLine()),
                const SizedBox(height: 12),

                /// 情绪波动（条形）
                Padding(
                  padding: listPadding,
                  child: Selector<StatisticViewModel, ({int selectDays})>(
                    selector: (_, statisticViewModel) {
                      return (selectDays: statisticViewModel.selectDays);
                    },
                    builder: (context, data, child) {
                      return StatisticLayout(
                        title: appL10n.statistic_moodScore_title,
                        subTitle: AppL10n.of(context).statistic_moodScore_content(data.selectDays),
                        height: 240,
                        statistic: child!,
                      );
                    },
                    child: const StatisticMoodBar(),
                  ),
                ),
                const SizedBox(height: 12),

                /// 心情统计
                Padding(
                  padding: listPadding,
                  child: Selector<StatisticViewModel, ({int selectDays})>(
                    selector: (_, statisticViewModel) {
                      return (selectDays: statisticViewModel.selectDays);
                    },
                    builder: (context, data, child) {
                      return StatisticLayout(
                        title: appL10n.statistic_moodStatistics_title,
                        subTitle: AppL10n.of(
                          context,
                        ).statistic_moodStatistics_content(data.selectDays),
                        height: 480,
                        statistic: child!,
                      );
                    },
                    child: const StatisticCategoryMood(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 总体统计
class OverallStatistics extends StatelessWidget {
  const OverallStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child:
          Selector<
            StatisticViewModel,
            ({int appUsageDays, int appMoodCount, int moodScoreAverage})
          >(
            selector: (_, statisticViewModel) {
              return (
                appUsageDays: statisticViewModel.appUsageDays,
                appMoodCount: statisticViewModel.appMoodCount,
                moodScoreAverage: statisticViewModel.moodScoreAverage,
              );
            },
            builder: (context, data, child) {
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  StatisticsCard(
                    icon: Remix.time_line,
                    title: AppL10n.of(context).statistic_overall_daysCount_title(data.appUsageDays),
                    subTitle: appL10n.statistic_overall_daysCount_subTitle,
                  ),
                  StatisticsCard(
                    icon: Remix.file_list_2_line,
                    title: AppL10n.of(context).statistic_overall_moodCount_title(data.appMoodCount),
                    subTitle: appL10n.statistic_overall_moodCount_subTitle,
                  ),
                  StatisticsCard(
                    icon: Remix.pulse_line,
                    title: AppL10n.of(
                      context,
                    ).statistic_overall_moodScoreAverage_title(data.moodScoreAverage),
                    subTitle: appL10n.statistic_overall_moodScoreAverage_subTitle,
                  ),
                ],
              );
            },
          ),
    );
  }
}

/// 统计-情绪波动（线）
class StatisticMoodLine extends StatelessWidget {
  const StatisticMoodLine({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Selector<
      StatisticViewModel,
      ({int selectDays, List<StatisticMoodScoreAverageRecentlyModel> moodScoreAverageRecently})
    >(
      selector: (_, statisticViewModel) {
        return (
          selectDays: statisticViewModel.selectDays,
          moodScoreAverageRecently: statisticViewModel.moodScoreAverageRecently,
        );
      },
      builder: (context, data, child) {
        /// 获取数据 计算近日平均
        final listData = data.moodScoreAverageRecently;
        double moodScoreAverage = 0;
        double moodScoreSum = 0;
        for (var i = 0; i < listData.length; i++) {
          moodScoreSum += listData[i].score;
        }
        moodScoreAverage = double.parse((moodScoreSum / data.selectDays).toStringAsFixed(1));
        return StatisticLayout(
          title: appL10n.statistic_moodScoreAverage_title(moodScoreAverage.toString()),
          subTitle: appL10n.statistic_moodScoreAverage_content(data.selectDays),
          height: 320,
          statistic: child!,
        );
      },
      child: const StatisticMoodLineBody(),
    );
  }
}

/// 情绪波动统计（线）-数据
class StatisticMoodLineBody extends StatelessWidget {
  const StatisticMoodLineBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final isDark = AppTheme(context).isDarkMode;

    final gradientColors = [
      themePrimaryColor.withValues(alpha: 0.1),
      themePrimaryColor.withValues(alpha: 0.4),
      themePrimaryColor.withValues(alpha: 0.6),
      themePrimaryColor,
      themePrimaryColor,
      themePrimaryColor,
      themePrimaryColor,
      themePrimaryColor,
      themePrimaryColor.withValues(alpha: 0.6),
      themePrimaryColor.withValues(alpha: 0.4),
      themePrimaryColor.withValues(alpha: 0.1),
    ];

    return Selector<
      StatisticViewModel,
      ({int selectDays, List<StatisticMoodScoreAverageRecentlyModel> moodScoreAverageRecently})
    >(
      selector: (_, statisticViewModel) {
        return (
          selectDays: statisticViewModel.selectDays,
          moodScoreAverageRecently: statisticViewModel.moodScoreAverageRecently,
        );
      },
      builder: (context, data, child) {
        /// 获取数据
        var listData = data.moodScoreAverageRecently;

        /// 统计的天数
        final selectDays = data.selectDays;

        /// 数据数量
        final moodCount = listData.length;

        /// 数据是否为空
        final moodEmpty = listData.isEmpty;

        /// 启用的数据数量（如果数据为空则启用固定天数）
        final days = moodEmpty ? selectDays : moodCount;

        /// 数据为空的占位
        if (moodEmpty) {
          listData = .generate(days, (i) {
            return const StatisticMoodScoreAverageRecentlyModel(datetime: '', score: 0);
          });
        }

        /// 为了数据效果展示首尾填充占位数据
        final listFlSpot = [
          StatisticMoodScoreAverageRecentlyModel(datetime: '', score: listData.first.score),
          ...listData,
          StatisticMoodScoreAverageRecentlyModel(datetime: '', score: listData.last.score),
        ];

        return LineChart(
          LineChartData(
            clipData: const .vertical(),
            maxX: days + 1,
            minY: -50,
            maxY: 120,
            lineBarsData: [
              LineChartBarData(
                spots: .generate(listFlSpot.length, (i) {
                  return FlSpot(
                    double.parse((i).toString()),
                    double.parse(listFlSpot[i].score.toString()),
                  );
                }),
                isCurved: true,
                curveSmoothness: 0.4,
                preventCurveOverShooting: true,
                gradient: LinearGradient(colors: gradientColors),
                // colors: gradientColors,
                barWidth: 2,
                // shadow: Shadow(
                //   color:themePrimaryColor.withOpacity(0.4),
                //   blurRadius: 4,
                //   offset: Offset.fromDirection(0, 0),
                // ),
                isStrokeCapRound: true,
                dotData: const .new(show: false),
                belowBarData: .new(
                  show: true,
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [themePrimaryColor.withValues(alpha: 0.1), theme.cardColor],
                  ),
                ),
              ),
            ],
            lineTouchData: .new(
              touchTooltipData: .new(
                fitInsideHorizontally: true,
                tooltipBorderRadius: .circular(24),
                tooltipMargin: 24,
                getTooltipColor: (_) => themePrimaryColor,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((barSpot) {
                    final flSpot = barSpot;
                    final i = flSpot.x.toInt();
                    if (i == 0 || i == (days + 1)) {
                      return null;
                    }
                    return LineTooltipItem(
                      '',
                      const TextStyle(),
                      children: [
                        TextSpan(
                          text: '${listFlSpot[i].score} ',
                          style: const .new(color: Colors.white, fontSize: 14, fontWeight: .bold),
                        ),
                        TextSpan(
                          text: listFlSpot[i].datetime.substring(5, 10),
                          style: const .new(color: Colors.white, fontSize: 12, fontWeight: .normal),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1),
                  strokeWidth: 0.6,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black12,
                  strokeWidth: 0,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: const .new(sideTitles: .new(showTitles: false)),
              rightTitles: const .new(sideTitles: .new(showTitles: false)),
              topTitles: const .new(sideTitles: .new(showTitles: false)),
              bottomTitles: .new(
                sideTitles: .new(
                  showTitles: true,
                  reservedSize: 18,
                  interval: days > 7 ? ((days / 7) + 1) : (days / 7),
                  getTitlesWidget: (value, titleMeta) {
                    final nowListDate = listFlSpot[value.toInt()].datetime;
                    return Text(
                      (nowListDate.toString() != '' ? nowListDate.toString().substring(8, 10) : ''),
                      style: const .new(
                        color: AppTheme.staticSubColor,
                        fontWeight: .normal,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: .new(
              show: true,
              border: .all(color: themePrimaryColor.withValues(alpha: 0.1), width: 0.2),
            ),
          ),
          duration: const .new(milliseconds: 450),
          curve: Curves.linearToEaseOut,
        );
      },
    );
  }
}

/// 情绪波动统计（条形）-数据
class StatisticMoodBar extends StatefulWidget {
  const StatisticMoodBar({super.key});

  @override
  State<StatisticMoodBar> createState() => _StatisticMoodBarState();
}

class _StatisticMoodBarState extends State<StatisticMoodBar> {
  /// 当前选择的下标
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;

    return Selector<
      StatisticViewModel,
      ({int selectDays, List<StatisticMoodScoreAverageRecentlyModel> moodScoreAverageRecently})
    >(
      selector: (_, statisticViewModel) {
        return (
          selectDays: statisticViewModel.selectDays,
          moodScoreAverageRecently: statisticViewModel.moodScoreAverageRecently,
        );
      },
      builder: (context, data, child) {
        /// 获取数据
        var listData = data.moodScoreAverageRecently;

        /// 统计的天数
        final selectDays = data.selectDays;

        /// 数据为空的占位
        if (listData.isEmpty) {
          listData = .generate(selectDays, (i) {
            return const StatisticMoodScoreAverageRecentlyModel(
              datetime: '---------- --------',
              score: 0,
            );
          });
        }

        /// 根据数据适应每条数据宽度
        final barWidth = switch (selectDays) {
          7 => 14.0,
          15 => 10.0,
          30 => 4.0,
          _ => 14.0,
        };

        return BarChart(
          BarChartData(
            barGroups: .generate(listData.length, (i) {
              return makeGroupData(
                i,
                double.parse(listData[i].score.toString()),
                isTouched: i == touchedIndex,
                width: barWidth,
              );
            }),
            barTouchData: .new(
              touchTooltipData: .new(
                tooltipBorderRadius: .circular(12),
                getTooltipColor: (_) => themePrimaryColor,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '',
                    const .new(),
                    children: [
                      .new(
                        text: '${rod.toY}\n',
                        style: const .new(color: Colors.white, fontSize: 14, fontWeight: .bold),
                      ),
                      .new(
                        text: listData[group.x].datetime.substring(5, 10),
                        style: const .new(color: Colors.white, fontSize: 12, fontWeight: .normal),
                      ),
                    ],
                  );
                },
              ),
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      barTouchResponse == null ||
                      barTouchResponse.spot == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
              },
            ),
            maxY: 100,
            titlesData: .new(
              topTitles: const .new(sideTitles: .new(showTitles: false)),
              bottomTitles: .new(
                sideTitles: .new(
                  showTitles: true,
                  getTitlesWidget: (value, titleMeta) {
                    return const Text('', style: .new(fontSize: 14));
                  },
                ),
              ),
              leftTitles: const .new(sideTitles: .new(showTitles: false)),
              rightTitles: const .new(sideTitles: .new(showTitles: false)),
            ),
            gridData: const .new(show: false),
            borderData: .new(show: false),
          ),
          duration: const .new(milliseconds: 1000),
          curve: Curves.linearToEaseOut,
        );
      },
    );
  }

  /// 每条数据
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    List<int> showTooltips = const [],
    double? width,
  }) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final isDark = AppTheme(context).isDarkMode;
    final colorTouched = [themePrimaryColor.withValues(alpha: 0.4), themePrimaryColor];
    final colorUntouched = [themePrimaryColor, themePrimaryColor.withValues(alpha: 0.4)];

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          gradient: LinearGradient(
            begin: .bottomCenter,
            end: .topCenter,
            colors: isTouched ? colorTouched : colorUntouched,
          ),
          width: width ?? 14,
          borderRadius: .circular(14),
          backDrawRodData: .new(
            show: true,
            color: isDark ? const Color(0xFF2B3034) : AppTheme.staticBackgroundColor1,
            fromY: 100,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}

/// 心情统计-数据
class StatisticCategoryMood extends StatefulWidget {
  const StatisticCategoryMood({super.key});

  @override
  State<StatisticCategoryMood> createState() => _StatisticCategoryMoodState();
}

class _StatisticCategoryMoodState extends State<StatisticCategoryMood> {
  /// 当前选择的下标
  late int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Selector<
      StatisticViewModel,
      ({List<StatisticMoodCountRecentlyModel> moodCountRecently})
    >(
      selector: (_, statisticViewModel) {
        return (moodCountRecently: statisticViewModel.moodCountRecently);
      },
      builder: (context, data, child) {
        final listData = data.moodCountRecently;

        /// 空占位
        if (listData.isEmpty) {
          return const Empty(icon: Icons.donut_small_rounded, size: 64.0, padding: .only(top: 100));
        }

        return PieChart(
          PieChartData(
            sections: .generate(listData.length, (i) {
              /// 数据
              final item = listData[i];

              /// 样式
              final isTouched = i == touchedIndex;
              final fontSize = isTouched ? 20.0 : 14.0;
              final radius = isTouched ? 120.0 : 100.0;

              return makeSectionData(
                item.count.toDouble(),
                title: item.icon,
                radius: radius,
                fontSize: fontSize,
                color: Utils.statisticColors[i],
                badgeFontSize: 16,
                badgeHeight: 28,
                badgeWidth: 28,
              );
            }),
            pieTouchData: PieTouchData(
              /// 触摸回调
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  /// 赋值当前触摸项
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: .new(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
          ),
          duration: const .new(milliseconds: 250),
          curve: Curves.linearToEaseOut,
        );
      },
    );
  }

  /// 每条数据
  PieChartSectionData makeSectionData(
    double? value, {
    String? title,
    double? radius,
    double? fontSize,
    Color? color,
    double? badgeFontSize,
    double? badgeWidth,
    double? badgeHeight,
  }) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: value?.toInt().toString(),
      radius: radius,
      titleStyle: .new(fontSize: fontSize, fontWeight: .bold, color: Colors.white),
      badgeWidget: AnimatedContainer(
        duration: PieChart.defaultDuration,
        width: badgeWidth,
        height: badgeHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: .circle,
          boxShadow: [
            .new(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const .new(0, 0),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const .all(1),
        child: Center(
          child: Text(title ?? '', style: .new(fontSize: badgeFontSize)),
        ),
      ),
      badgePositionPercentageOffset: 0.9,
      titlePositionPercentageOffset: 0.6,
    );
  }
}

/// 统计 Card
class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  /// Icon
  final IconData icon;

  /// 标题内容
  final String title;

  /// 副标题
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: '$subTitle$title',
      excludeSemantics: true,
      child: Container(
        constraints: const .new(minWidth: 100, minHeight: 110),
        padding: const .all(12),
        decoration: BoxDecoration(color: theme.cardColor, borderRadius: .circular(16)),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(color: Colors.black, shape: .circle),
              child: Icon(icon, size: 18, color: Colors.white),
            ),
            Padding(
              padding: const .only(top: 20, bottom: 10),
              child: Text(
                title,
                style: const .new(fontSize: 14),
                strutStyle: const .new(forceStrutHeight: false, leading: 1.5),
              ),
            ),
            Text(subTitle, style: const .new(color: AppTheme.staticSubColor, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

/// 统计-布局
class StatisticLayout extends StatelessWidget {
  const StatisticLayout({
    super.key,
    required this.title,
    required this.subTitle,
    required this.height,
    required this.statistic,
  });

  /// 标题
  final String title;

  /// 副标题
  final String subTitle;

  /// 高度
  final double height;

  /// 统计图
  final Widget statistic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: '$title$subTitle',
      excludeSemantics: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(color: theme.cardColor, borderRadius: .circular(16)),
        padding: const .all(24),
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisAlignment: .start,
          mainAxisSize: .max,
          children: [
            Text(title, style: const .new(fontSize: 20, fontWeight: .bold)),
            const SizedBox(height: 4),
            Text(
              subTitle,
              style: const .new(color: AppTheme.staticSubColor, fontSize: 14, fontWeight: .normal),
            ),
            const SizedBox(height: 38),
            Expanded(child: statistic),
          ],
        ),
      ),
    );
  }
}

/// 筛选选择项
class FilterButton extends StatelessWidget {
  const FilterButton(
    this.text, {
    super.key,
    required this.checked,
    this.semanticsLabel,
    this.onTap,
  });

  /// 是否选中
  final bool checked;

  /// 内容
  final String text;

  final String? semanticsLabel;

  /// onTap
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;
    final isDark = AppTheme(context).isDarkMode;
    final boxShadowChecked = [
      BoxShadow(color: themePrimaryColor.withValues(alpha: 0.2), blurRadius: 6),
    ];
    final boxShadowUnchecked = [
      BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6),
    ];

    return AnimatedPress(
      child: Semantics(
        button: true,
        label: semanticsLabel,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 42,
            height: 42,
            margin: const .symmetric(horizontal: 6),
            alignment: .center,
            decoration: BoxDecoration(
              color: checked ? themePrimaryColor : theme.cardColor,
              borderRadius: .circular(14),
              boxShadow: checked ? boxShadowChecked : boxShadowUnchecked,
            ),
            child: Text(
              text,
              style: .new(
                color: checked ? Colors.white : (isDark ? Colors.white : Colors.black87),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
