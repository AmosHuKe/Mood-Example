import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../router.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../utils/utils.dart';
import '../../widgets/animation/animation.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../domain/models/mood/mood_category_model.dart';
import 'view_models/home_view_model.dart';

/// 首页
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeViewModel(moodCategoryLoadUseCase: context.read());
      },
      child: const Scaffold(body: HomeBody(key: Key('widget_home_body'))),
    );
  }
}

/// 首页主体
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

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
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appL10n.home_hi,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    semanticsLabel: appL10n.app_bottomNavigationBar_title_home,
                  ),
                  Image.asset(
                    'assets/images/woolly/woolly-yellow-star.png',
                    height: 60,
                    excludeFromSemantics: true,
                  ),
                ],
              ),
            ),
          ),
          collapsedHeight: 100,
          expandedHeight: 100,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 头部
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
                  child: Semantics(container: true, child: const Header()),
                ),

                /// 情绪选项卡
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: MoodOption(key: Key('widget_mood_option')),
                ),

                /// 公告卡片
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: MergeSemantics(child: NoticeCard()),
                ),

                /// 相关文章
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        container: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Text(
                            appL10n.home_help_title,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const Article(),
                    ],
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

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            appL10n.home_moodChoice_title,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
          ),
        ),
        Selector<HomeViewModel, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
          selector: (_, homeViewModel) {
            return (loading: homeViewModel.loading, moodCategoryAll: homeViewModel.moodCategoryAll);
          },
          builder: (context, data, child) {
            /// 加载数据的占位
            if (data.loading && data.moodCategoryAll.isEmpty) {
              return const Align(child: CupertinoActivityIndicator(radius: 12));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

/// 情绪选项卡
class MoodOption extends StatelessWidget {
  const MoodOption({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Selector<HomeViewModel, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
        selector: (_, homeViewModel) {
          return (loading: homeViewModel.loading, moodCategoryAll: homeViewModel.moodCategoryAll);
        },
        builder: (context, data, child) {
          if (data.loading) return const SizedBox();

          /// 所有心情类型数据
          final widgetList = <Widget>[];
          for (final list in data.moodCategoryAll) {
            widgetList.add(OptionCard(title: list.title, icon: list.icon));
          }

          return Wrap(
            spacing: 24,
            alignment: WrapAlignment.spaceBetween,
            children: widgetList, // dart format
          );
        },
      ),
    );
  }
}

/// 小型选项卡片
class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.title, required this.icon});

  /// 标题
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;
    const double iconSize = 32;

    return GestureDetector(
      onTap: () {
        // 跳转输入内容页
        final nowDateTime = Utils.datetimeFormatToString(DateTime.now());
        final moodData = MoodDataModel(
          icon: icon,
          title: title,
          score: 50,
          create_time: nowDateTime,
          update_time: nowDateTime,
        );
        GoRouter.of(context).pushNamed(
          Routes.moodContentEdit,
          pathParameters: {'moodData': jsonEncode(moodData.toJson())},
        );
      },
      child: Column(
        children: [
          AnimatedPress(
            child: Container(
              constraints: const BoxConstraints(minWidth: 52),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2B3034) : AppTheme.staticBackgroundColor1,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Align(
                  child: Text(icon, style: const TextStyle(fontSize: iconSize)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

/// 公告卡片
class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Tilt(
      disable: Utils.envTestMode,
      tiltConfig: const TiltConfig(
        leaveDuration: Duration(seconds: 1),
        leaveCurve: Curves.elasticOut,
      ),
      lightConfig: const LightConfig(disable: true),
      shadowConfig: const ShadowConfig(disable: true),
      childLayout: ChildLayout(
        outer: [
          Positioned(
            right: -20,
            child: TiltParallax(
              size: const Offset(15, 15),
              child: Image.asset(
                'assets/images/onboarding/onboarding_3.png',
                fit: BoxFit.contain,
                width: 180,
              ),
            ),
          ),
        ],
        inner: [
          Positioned(
            left: 24,
            bottom: 24,
            child: TiltParallax(
              size: const Offset(5, 5),
              child: Container(
                constraints: const BoxConstraints(minHeight: 45, minWidth: 95),
                child: AnimatedPress(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      backgroundColor: WidgetStateProperty.all(Colors.black87),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.white10),
                    ),
                    onPressed: () {
                      /// 导航到新路由
                      GoRouter.of(context).pushNamed(Routes.onboarding);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            appL10n.home_upgrade_button,
                            strutStyle: const StrutStyle(forceStrutHeight: false, leading: 1),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const Icon(Remix.play_circle_fill, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        behind: [
          /// 阴影
          TiltParallax(
            size: const Offset(-16, -16),
            child: shadow(
              opacity: 0.2,
              margin: const EdgeInsets.only(left: 24, right: 24, top: 32),
            ),
          ),
          TiltParallax(
            size: const Offset(-8, -8),
            child: shadow(
              opacity: 0.4,
              margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
            ),
          ),
        ],
      ),
      child: const SizedBox(height: 190, child: ActionCard()),
    );
  }

  /// 阴影
  Widget shadow({EdgeInsetsGeometry? margin, required double opacity}) {
    return Container(
      height: 190,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFFFFBBBB).withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

/// 操作卡片
class ActionCard extends StatelessWidget {
  const ActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFBBBB), Color(0xFFFFBBBB), Color(0xFFFFC5C5)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appL10n.home_upgrade_title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      appL10n.home_upgrade_content,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 相关文章
class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        const minWidth = 120.0;
        const maxWidth = 200.0;
        final widgetWidth = (availableWidth / 2 - 8).clamp(minWidth, maxWidth);

        return Wrap(
          spacing: 16,
          runSpacing: 24,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            ArticleCard(
              key: const Key('widget_home_article_1'),
              width: widgetWidth,
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFFFFCEBD), Color(0xFFFFCEBD), Color(0xFFFFDCCF)],
              ),
              onTap: () {
                GoRouter.of(context).pushNamed(
                  Routes.webViewPage,
                  pathParameters: {
                    'url': ValueBase64('https://github.com/AmosHuKe/Mood-Example').encode(),
                  },
                );
              },
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      bottom: -12,
                      left: 0,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_2.png',
                        fit: BoxFit.contain,
                        height: 120,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appL10n.home_help_article_title_1,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            appL10n.home_help_article_content_1,
                            style: const TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(
                            Remix.arrow_right_circle_fill,
                            size: 24,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            ArticleCard(
              key: const Key('widget_home_article_2'),
              width: widgetWidth,
              mainAxisAlignment: MainAxisAlignment.end,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFD390), Color(0xFFFFD390), Color(0xFFFFE1B3)],
              ),
              onTap: () {
                GoRouter.of(context).pushNamed(
                  Routes.webViewPage,
                  pathParameters: {'url': ValueBase64('https://amooos.com/').encode()},
                );
              },
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      top: -64,
                      left: 0,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_1.png',
                        fit: BoxFit.contain,
                        height: 120,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 72),
                        Text(
                          appL10n.home_help_article_title_2,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            appL10n.home_help_article_content_2,
                            style: const TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(
                            Remix.arrow_right_circle_fill,
                            size: 24,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// 文章卡片
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.width,
    required this.gradient,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.children,
    this.onTap,
  });

  final double width;
  final Gradient gradient;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      scaleEnd: 0.9,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
