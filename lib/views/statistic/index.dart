import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';
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

class _StatisticPageState extends State<StatisticPage>
    with AutomaticKeepAliveClientMixin {
  /// AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    /// AutomaticKeepAliveClientMixin
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: StatisticBody(key: Key('widget_statistic_body')),
      ),
    );
  }
}

/// 初始化
void init(BuildContext context) {
  final StatisticProvider statisticProvider = context.read<StatisticProvider>();

  /// 统计的天数
  final int moodDays = statisticProvider.moodDays;

  /// 统计-APP累计使用天数
  statisticProvider.loadDaysCount();

  /// 统计-APP累计记录条数
  statisticProvider.loadMoodCount();

  /// 统计-平均情绪波动
  statisticProvider.loadMoodScoreAverage();

  /// 统计-近日情绪波动
  statisticProvider.loadMoodScoreAverageRecently(days: moodDays);

  /// 统计-近日心情数量统计
  statisticProvider.loadDateMoodCount(days: moodDays);
}

class StatisticBody extends StatelessWidget {
  const StatisticBody({super.key});

  @override
  Widget build(BuildContext context) {
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
          flexibleSpace: Align(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    S.of(context).statistic_title,
                    style: TextStyle(
                      fontSize: 36.sp,
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
                              init(context);
                            },
                          ),
                          FilterBottom(
                            S.of(context).statistic_filter_15d,
                            checked: moodDays == 15,
                            semanticsLabel: '筛选15日统计数据',
                            onTap: () {
                              if (moodDays == 15) return;
                              statisticProvider.moodDays = 15;
                              init(context);
                            },
                          ),
                          FilterBottom(
                            S.of(context).statistic_filter_30d,
                            checked: moodDays == 30,
                            semanticsLabel: '筛选30日统计数据',
                            onTap: () {
                              if (moodDays == 30) return;
                              statisticProvider.moodDays = 30;
                              init(context);
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
          collapsedHeight: 100.w,
          expandedHeight: 100.w,
        ),

        /// 下拉加载
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            vibrate();
            init(context);
          },
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 48.h),
            child: Column(
              children: [
                /// 总体统计
                const OverallStatistics(),

                /// 情绪波动（线）
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.w,
                    left: 24.w,
                    right: 24.w,
                  ),
                  child: const StatisticMoodLine(),
                ),

                /// 情绪波动
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.w,
                    left: 24.w,
                    right: 24.w,
                  ),
                  child: Consumer<StatisticProvider>(
                    builder: (_, statisticProvider, child) {
                      return StatisticLayout(
                        title: S.of(context).statistic_moodScore_title,
                        subTitle: S.of(context).statistic_moodScore_content(
                              statisticProvider.moodDays,
                            ),
                        height: 180.w,
                        statistic: const StatisticWeekMood(),
                      );
                    },
                  ),
                ),

                /// 心情统计
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.w,
                    left: 24.w,
                    right: 24.w,
                  ),
                  child: Consumer<StatisticProvider>(
                    builder: (_, statisticProvider, child) {
                      return StatisticLayout(
                        title: S.of(context).statistic_moodStatistics_title,
                        subTitle:
                            S.of(context).statistic_moodStatistics_content(
                                  statisticProvider.moodDays,
                                ),
                        height: 320.w,
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
          height: 240.w,
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
          listData = List.generate((days), (i) {
            return StatisticMoodScoreAverageRecentlyData(
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
            maxX: (days + 1),
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
                barWidth: 2.sp,
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
                tooltipRoundedRadius: 24.sp,
                tooltipMargin: 24.w,
                tooltipBgColor: Theme.of(context).primaryColor,
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: listFlSpot[i].datetime.substring(5, 10),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
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
                  reservedSize: 18.w,
                  interval: days > 7 ? ((days / 7) + 1) : (days / 7),
                  getTitlesWidget: (value, titleMeta) {
                    final nowListDate = listFlSpot[(value).toInt()].datetime;
                    return Text(
                      (nowListDate.toString() != ''
                          ? nowListDate.toString().substring(8, 10)
                          : ''),
                      style: TextStyle(
                        color: AppTheme.subColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
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
      child: Padding(
        padding: EdgeInsets.only(
          top: 24.w,
          left: 24.w,
          right: 24.w,
        ),
        child: Consumer<StatisticProvider>(
          builder: (_, statisticProvider, child) {
            return IntrinsicHeight(
              child: Row(
                children: [
                  StatisticsCard(
                    icon: Remix.time_line,
                    title: S.of(context).statistic_overall_daysCount_title(
                          statisticProvider.daysCount,
                        ),
                    subTitle:
                        S.of(context).statistic_overall_daysCount_subTitle,
                  ),
                  StatisticsCard(
                    icon: Remix.file_list_2_line,
                    title: S.of(context).statistic_overall_moodCount_title(
                          statisticProvider.moodCount,
                        ),
                    subTitle:
                        S.of(context).statistic_overall_moodCount_subTitle,
                  ),
                  StatisticsCard(
                    icon: Remix.pulse_line,
                    title:
                        S.of(context).statistic_overall_moodScoreAverage_title(
                              statisticProvider.moodScoreAverage,
                            ),
                    subTitle: S
                        .of(context)
                        .statistic_overall_moodScoreAverage_subTitle,
                  ),
                ],
              ),
            );
          },
        ),
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
            return StatisticMoodScoreAverageRecentlyData(
              datetime: '---------- --------',
              score: 0,
            );
          });
        }

        /// 根据数据适应每条数据宽度
        final double barWidth = switch (moodDays) {
          7 => 14.w,
          15 => 10.w,
          30 => 4.w,
          _ => 14.w,
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
                tooltipRoundedRadius: 12.sp,
                tooltipBgColor: Theme.of(context).primaryColor,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '',
                    const TextStyle(),
                    children: [
                      TextSpan(
                        text: '${rod.toY}\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: listData[group.x].datetime.substring(5, 10),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
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
                    return Text(
                      '',
                      style: TextStyle(fontSize: 12.sp),
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
          width: width ?? 14.w,
          borderRadius: BorderRadius.circular(14.w),
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
          return Empty(
            padding: EdgeInsets.only(top: 48.w),
            width: 120.w,
            height: 100.w,
          );
        }

        return PieChart(
          PieChartData(
            sections: List<PieChartSectionData>.generate(listData.length, (i) {
              /// 数据
              final item = listData[i];

              /// 样式
              final isTouched = i == _touchedIndex;
              final fontSize = isTouched ? 20.sp : 14.sp;
              final radius = isTouched ? 120.w : 100.w;

              return makeSectionData(
                double.parse(item.count.toString()),
                title: item.icon,
                radius: radius,
                fontSize: fontSize,
                color: statisticColors[i],
                badgeFontSize: 16.sp,
                badgeHeight: 28.w,
                badgeWidth: 28.w,
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
        padding: EdgeInsets.all(1.w),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              fontSize: badgeFontSize,
            ),
          ),
        ),
      ),
      badgePositionPercentageOffset: 0.9.w,
      titlePositionPercentageOffset: 0.6.w,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 72.w,
            minHeight: 110.w,
          ),
          margin: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.w, bottom: 10.w),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14.sp),
                  strutStyle: const StrutStyle(
                    forceStrutHeight: false,
                    leading: 1.5,
                  ),
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  color: AppTheme.subColor,
                  fontSize: 12.sp,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Container(
          height: height,
          margin: EdgeInsets.all(24.w),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: AppTheme.subColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 38.w),
                  Expanded(child: statistic),
                ],
              ),
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
            width: 40.w,
            height: 40.w,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: checked ? primaryColor : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(14.sp),
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
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
