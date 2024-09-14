import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';
import 'package:moodexample/common/utils.dart';

import 'package:moodexample/widgets/empty/empty.dart';
import 'package:moodexample/widgets/animation/animation.dart';

import 'package:moodexample/models/statistic/statistic_model.dart';
import 'package:moodexample/providers/statistic/statistic_provider.dart';

/// 统计
class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const StatisticBody(key: Key('widget_statistic_body')),
    );
  }
}

class StatisticBody extends StatelessWidget {
  const StatisticBody({super.key});

  final EdgeInsets listPadding = const EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(BuildContext context) {
    final StatisticProvider readStatisticProvider =
        context.read<StatisticProvider>();

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
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
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      S.of(context).statistic_title,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel:
                          S.of(context).app_bottomNavigationBar_title_statistic,
                    ),
                    Consumer<StatisticProvider>(
                      builder: (context, statisticProvider, child) {
                        final int moodDays = statisticProvider.moodDays;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilterBottom(
                              S.of(context).statistic_filter_7d,
                              checked: moodDays == 7,
                              semanticsLabel: '筛选7日统计数据',
                              onTap: () {
                                if (moodDays == 7) return;
                                statisticProvider.moodDays = 7;
                                statisticProvider.load();
                              },
                            ),
                            FilterBottom(
                              S.of(context).statistic_filter_15d,
                              checked: moodDays == 15,
                              semanticsLabel: '筛选15日统计数据',
                              onTap: () {
                                if (moodDays == 15) return;
                                statisticProvider.moodDays = 15;
                                statisticProvider.load();
                              },
                            ),
                            FilterBottom(
                              S.of(context).statistic_filter_30d,
                              checked: moodDays == 30,
                              semanticsLabel: '筛选30日统计数据',
                              onTap: () {
                                if (moodDays == 30) return;
                                statisticProvider.moodDays = 30;
                                statisticProvider.load();
                              },
                            ),
                          ],
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
            readStatisticProvider.load();
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              children: [
                /// 总体统计
                Padding(
                  padding: listPadding,
                  child: const OverallStatistics(),
                ),

                const SizedBox(height: 12),

                /// 情绪波动（线）
                Padding(
                  padding: listPadding,
                  child: const StatisticMoodLine(),
                ),

                const SizedBox(height: 12),

                /// 情绪波动
                Padding(
                  padding: listPadding,
                  child: Consumer<StatisticProvider>(
                    builder: (_, statisticProvider, child) {
                      return StatisticLayout(
                        title: S.of(context).statistic_moodScore_title,
                        subTitle: S.of(context).statistic_moodScore_content(
                              statisticProvider.moodDays,
                            ),
                        height: 180,
                        statistic: const StatisticWeekMood(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                /// 心情统计
                Padding(
                  padding: listPadding,
                  child: Consumer<StatisticProvider>(
                    builder: (_, statisticProvider, child) {
                      return StatisticLayout(
                        title: S.of(context).statistic_moodStatistics_title,
                        subTitle:
                            S.of(context).statistic_moodStatistics_content(
                                  statisticProvider.moodDays,
                                ),
                        height: 320,
                        statistic: const StatisticCategoryMood(),
                      );
                    },
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

/// 统计-情绪波动（线）
class StatisticMoodLine extends StatelessWidget {
  const StatisticMoodLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticProvider>(
      builder: (_, statisticProvider, child) {
        /// 获取数据 计算近日平均
        final List<StatisticMoodScoreAverageRecentlyData> listData =
            statisticProvider.moodScoreAverageRecently;
        double moodScoreAverage = 0;
        double moodScoreSum = 0;
        for (int i = 0; i < listData.length; i++) {
          moodScoreSum += listData[i].score;
        }
        moodScoreAverage = double.parse(
          (moodScoreSum / statisticProvider.moodDays).toStringAsFixed(1),
        );
        return StatisticLayout(
          title: S
              .of(context)
              .statistic_moodScoreAverage_title(moodScoreAverage.toString()),
          subTitle: S
              .of(context)
              .statistic_moodScoreAverage_content(statisticProvider.moodDays),
          height: 240,
          statistic: const StatisticWeekMoodLine(),
        );
      },
    );
  }
}

/// 周情绪波动统计（线）-数据
class StatisticWeekMoodLine extends StatelessWidget {
  const StatisticWeekMoodLine({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      Theme.of(context).primaryColor.withOpacity(0.1),
      Theme.of(context).primaryColor.withOpacity(0.4),
      Theme.of(context).primaryColor.withOpacity(0.6),
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor,
      Theme.of(context).primaryColor.withOpacity(0.6),
      Theme.of(context).primaryColor.withOpacity(0.4),
      Theme.of(context).primaryColor.withOpacity(0.1),
    ];
    return Consumer<StatisticProvider>(
      builder: (_, statisticProvider, child) {
        /// 获取数据
        late List<StatisticMoodScoreAverageRecentlyData> listData =
            statisticProvider.moodScoreAverageRecently;

        /// 统计的天数
        final int moodDays = statisticProvider.moodDays;

        /// 数据数量
        final int moodCount = listData.length;

        /// 数据是否为空
        final bool moodEmpty = listData.isEmpty;

        /// 启用的数据数量（如果数据为空则启用固定天数）
        final int days = moodEmpty ? moodDays : moodCount;

        /// 数据为空的占位
        if (moodEmpty) {
          listData = List.generate(days, (i) {
            return const StatisticMoodScoreAverageRecentlyData(
              datetime: '',
              score: 0,
            );
          });
        }

        /// 为了数据效果展示首尾填充占位数据
        final List<StatisticMoodScoreAverageRecentlyData> listFlSpot = [
          StatisticMoodScoreAverageRecentlyData(
            datetime: '',
            score: listData.first.score,
          ),
          ...listData,
          StatisticMoodScoreAverageRecentlyData(
            datetime: '',
            score: listData.last.score,
          ),
        ];

        return LineChart(
          LineChartData(
            clipData: const FlClipData.vertical(),
            maxX: days + 1,
            minY: -50,
            maxY: 120,
            lineBarsData: [
              LineChartBarData(
                spots: List<FlSpot>.generate(listFlSpot.length, (i) {
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
                //   color:Theme.of(context).primaryColor.withOpacity(0.4),
                //   blurRadius: 4,
                //   offset: Offset.fromDirection(0, 0),
                // ),
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      Theme.of(context).cardColor,
                    ],
                  ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                tooltipRoundedRadius: 24,
                tooltipMargin: 24,
                getTooltipColor: (_) => Theme.of(context).primaryColor,
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: listFlSpot[i].datetime.substring(5, 10),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
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
                  color: isDarkMode(context)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  strokeWidth: 0.6,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: isDarkMode(context)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black12,
                  strokeWidth: 0,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 18,
                  interval: days > 7 ? ((days / 7) + 1) : (days / 7),
                  getTitlesWidget: (value, titleMeta) {
                    final nowListDate = listFlSpot[value.toInt()].datetime;
                    return Text(
                      (nowListDate.toString() != ''
                          ? nowListDate.toString().substring(8, 10)
                          : ''),
                      style: const TextStyle(
                        color: AppTheme.subColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                width: 0.2,
              ),
            ),
          ),
          duration: const Duration(milliseconds: 450),
          curve: Curves.linearToEaseOut,
        );
      },
    );
  }
}

/// 总体统计
class OverallStatistics extends StatelessWidget {
  const OverallStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Consumer<StatisticProvider>(
        builder: (_, statisticProvider, child) {
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatisticsCard(
                icon: Remix.time_line,
                title: S.of(context).statistic_overall_daysCount_title(
                      statisticProvider.daysCount,
                    ),
                subTitle: S.of(context).statistic_overall_daysCount_subTitle,
              ),
              StatisticsCard(
                icon: Remix.file_list_2_line,
                title: S.of(context).statistic_overall_moodCount_title(
                      statisticProvider.moodCount,
                    ),
                subTitle: S.of(context).statistic_overall_moodCount_subTitle,
              ),
              StatisticsCard(
                icon: Remix.pulse_line,
                title: S.of(context).statistic_overall_moodScoreAverage_title(
                      statisticProvider.moodScoreAverage,
                    ),
                subTitle:
                    S.of(context).statistic_overall_moodScoreAverage_subTitle,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// 周情绪波动统计-数据
class StatisticWeekMood extends StatefulWidget {
  const StatisticWeekMood({super.key});

  @override
  State<StatisticWeekMood> createState() => _StatisticWeekMoodState();
}

class _StatisticWeekMoodState extends State<StatisticWeekMood> {
  /// 当前选择的下标
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticProvider>(
      builder: (_, statisticProvider, child) {
        /// 获取数据
        List<StatisticMoodScoreAverageRecentlyData> listData =
            statisticProvider.moodScoreAverageRecently;

        /// 统计的天数
        final int moodDays = statisticProvider.moodDays;

        /// 数据为空的占位
        if (listData.isEmpty) {
          listData = List.generate(moodDays, (i) {
            return const StatisticMoodScoreAverageRecentlyData(
              datetime: '---------- --------',
              score: 0,
            );
          });
        }

        /// 根据数据适应每条数据宽度
        final double barWidth = switch (moodDays) {
          7 => 14,
          15 => 10,
          30 => 4,
          _ => 14,
        };

        ///
        return BarChart(
          BarChartData(
            barGroups: List<BarChartGroupData>.generate(listData.length, (i) {
              return makeGroupData(
                i,
                double.parse(listData[i].score.toString()),
                isTouched: i == _touchedIndex,
                width: barWidth,
              );
            }),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipRoundedRadius: 12,
                getTooltipColor: (_) => Theme.of(context).primaryColor,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '',
                    const TextStyle(),
                    children: [
                      TextSpan(
                        text: '${rod.toY}\n',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: listData[group.x].datetime.substring(5, 10),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
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
                    _touchedIndex = -1;
                    return;
                  }
                  _touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
              },
            ),
            maxY: 100,
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, titleMeta) {
                    return const Text(
                      '',
                      style: TextStyle(fontSize: 14),
                    );
                  },
                ),
              ),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
          swapAnimationDuration: const Duration(milliseconds: 1000),
          swapAnimationCurve: Curves.linearToEaseOut,
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
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: isTouched
                ? [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).primaryColor,
                  ]
                : [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.4),
                  ],
          ),
          width: width ?? 14,
          borderRadius: BorderRadius.circular(14),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            color: isDarkMode(context)
                ? const Color(0xFF2B3034)
                : AppTheme.backgroundColor1,
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
  late int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticProvider>(
      builder: (_, statisticProvider, child) {
        /// 获取数据
        final List<StatisticDateMoodCountData> listData =
            statisticProvider.dateMoodCount;

        /// 空占位
        if (listData.isEmpty) {
          return const Empty(
            padding: EdgeInsets.only(top: 48),
            width: 120,
            height: 100,
          );
        }

        return PieChart(
          PieChartData(
            sections: List<PieChartSectionData>.generate(listData.length, (i) {
              /// 数据
              final item = listData[i];

              /// 样式
              final bool isTouched = i == _touchedIndex;
              final double fontSize = isTouched ? 20 : 14;
              final double radius = isTouched ? 120 : 100;

              return makeSectionData(
                double.parse(item.count.toString()),
                title: item.icon,
                radius: radius,
                fontSize: fontSize,
                color: statisticColors[i],
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
                    _touchedIndex = -1;
                    return;
                  }
                  _touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
          ),

          swapAnimationDuration: const Duration(milliseconds: 250), // Optional
          swapAnimationCurve: Curves.linearToEaseOut, // Optional
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
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      badgeWidget: AnimatedContainer(
        duration: PieChart.defaultDuration,
        width: badgeWidth,
        height: badgeHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              offset: const Offset(0, 0),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(1),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              fontSize: badgeFontSize,
            ),
          ),
        ),
      ),
      badgePositionPercentageOffset: 0.9,
      titlePositionPercentageOffset: 0.6,
    );
  }
}

/// 统计Card
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
    return Semantics(
      container: true,
      label: '$subTitle$title',
      excludeSemantics: true,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 88,
            minHeight: 110,
          ),
          margin: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10, left: 6),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                  strutStyle: const StrutStyle(
                    forceStrutHeight: false,
                    leading: 1.5,
                  ),
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: AppTheme.subColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
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
    return Semantics(
      container: true,
      label: '$title$subTitle',
      excludeSemantics: true,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: height,
          margin: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subTitle,
                style: const TextStyle(
                  color: AppTheme.subColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 38),
              Expanded(child: statistic),
            ],
          ),
        ),
      ),
    );
  }
}

/// 筛选选择项
class FilterBottom extends StatelessWidget {
  const FilterBottom(
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

  ///
  final String? semanticsLabel;

  /// onTap
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
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
            margin: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: checked ? primaryColor : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: checked
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        blurRadius: 6,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                      ),
                    ],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: checked
                    ? Colors.white
                    : isDarkMode(context)
                        ? Colors.white
                        : Colors.black87,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
