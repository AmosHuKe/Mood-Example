import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:animations/animations.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';
import 'package:moodexample/common/utils.dart';

import 'package:moodexample/widgets/animation/animation.dart';

import 'package:moodexample/views/mood/mood_content.dart';
import 'package:moodexample/views/web_view/web_view.dart';

import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/providers/mood/mood_provider.dart';
import 'package:moodexample/providers/application/application_provider.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(key: Key('widget_home_body')),
    );
  }
}

/// 首页主体
class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).home_hi,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    semanticsLabel:
                        S.of(context).app_bottomNavigationBar_title_home,
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
                  child: Semantics(
                    container: true,
                    child: const Header(),
                  ),
                ),

                /// 情绪选项卡
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: OptionMood(key: Key('widget_option_mood')),
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
                            S.of(context).home_help_title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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

/// 头部
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).home_moodChoice_title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
          ),
        ),
        Consumer<MoodProvider>(
          builder: (_, moodProvider, child) {
            /// 加载数据的占位
            if (moodProvider.moodCategoryList.isEmpty) {
              return const Align(
                child: CupertinoActivityIndicator(radius: 12),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

/// 情绪选项卡
class OptionMood extends StatefulWidget {
  const OptionMood({super.key});

  @override
  State<OptionMood> createState() => _OptionMoodState();
}

class _OptionMoodState extends State<OptionMood> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Consumer<MoodProvider>(
        builder: (_, moodProvider, child) {
          /// 所有心情类型数据
          final List<Widget> widgetList = [];

          /// 数据渲染
          for (final MoodCategoryData list in moodProvider.moodCategoryList) {
            widgetList.add(
              OptionCard(title: list.title, icon: list.icon),
            );
          }

          /// 显示
          return Wrap(
            spacing: 24, // 主轴(水平)方向间距
            alignment: WrapAlignment.spaceBetween, //沿主轴方向居中
            children: widgetList,
          );
        },
      ),
    );
  }
}

/// 小型选项卡片
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.title,
    required this.icon,
  });

  /// 标题
  final String title;

  /// Icon
  final String icon;

  @override
  Widget build(BuildContext context) {
    /// 图标大小
    final double _iconSize = 32;

    return Consumer<ApplicationProvider>(
      builder: (_, applicationProvider, child) {
        return OpenContainer(
          useRootNavigator: true,
          clipBehavior: Clip.none,
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 450),
          closedBuilder: (_, openContainer) {
            return GestureDetector(
              onTap: openContainer,
              child: Column(
                children: [
                  AnimatedPress(
                    child: Container(
                      constraints: const BoxConstraints(minWidth: 52),
                      decoration: BoxDecoration(
                        color: isDarkMode(context)
                            ? const Color(0xFF2B3034)
                            : AppTheme.backgroundColor1,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 18,
                        ),
                        child: Align(
                          child: Text(
                            icon,
                            style: TextStyle(fontSize: _iconSize),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          openElevation: 0,
          openColor: Colors.transparent,
          middleColor: Colors.transparent,
          closedElevation: 0,
          closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          closedColor: Colors.transparent,
          openBuilder: (_, closeContainer) {
            // 跳转输入内容页
            final String nowDateTime =
                DateTime.now().toString().substring(0, 10);
            final MoodData moodData = MoodData();
            moodData.icon = icon;
            moodData.title = title;
            moodData.createTime = nowDateTime;
            moodData.updateTime = nowDateTime;
            return MoodContent(moodData: moodData);
          },
        );
      },
    );
  }
}

/// 公告卡片
class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Tilt(
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
                constraints: const BoxConstraints(
                  minHeight: 45,
                  minWidth: 95,
                ),
                child: AnimatedPress(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      backgroundColor: WidgetStateProperty.all(Colors.black87),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      overlayColor: WidgetStateProperty.all(Colors.white10),
                    ),
                    onPressed: () => {
                      /// 导航到新路由
                      GoRouter.of(context).pushNamed(Routes.onboarding),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            S.of(context).home_upgrade_button,
                            strutStyle: const StrutStyle(
                              forceStrutHeight: false,
                              leading: 1,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Icon(
                          Remix.play_circle_fill,
                          size: 24,
                        ),
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
      child: const SizedBox(
        height: 190,
        child: ActionCard(),
      ),
    );
  }

  /// 阴影
  Widget shadow({
    EdgeInsetsGeometry? margin,
    required double opacity,
  }) {
    return Container(
      height: 190,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFFFFBBBB).withOpacity(opacity),
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
          /// 文字和按钮
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).home_upgrade_title,
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
                      S.of(context).home_upgrade_content,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final double minWidth = 120;
        final double maxWidth = 200;
        final double widgetWidth =
            (availableWidth / 2 - 8).clamp(minWidth, maxWidth);

        return Wrap(
          spacing: 16, // 主轴(水平)方向间距
          runSpacing: 24, // 纵轴（垂直）方向间距
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            OpenContainer(
              useRootNavigator: true,
              clipBehavior: Clip.none,
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(milliseconds: 450),
              closedBuilder: (_, openContainer) {
                return ArticleCard(
                  key: const Key('widget_home_article_1'),
                  width: widgetWidth,
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFFFFCEBD),
                      Color(0xFFFFCEBD),
                      Color(0xFFFFDCCF),
                    ],
                  ),
                  onTap: () {
                    openContainer();
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
                              S.of(context).home_help_article_title_1,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                S.of(context).home_help_article_content_1,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
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
                );
              },
              openElevation: 0,
              openColor: Theme.of(context).scaffoldBackgroundColor,
              middleColor: Theme.of(context).scaffoldBackgroundColor,
              closedElevation: 0,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              closedColor: const Color(0xFFFFCEBD),
              openBuilder: (_, closeContainer) {
                return WebViewPage(
                  url: ValueConvert('https://github.com/AmosHuKe/Mood-Example')
                      .encode(),
                );
              },
            ),
            OpenContainer(
              useRootNavigator: true,
              clipBehavior: Clip.none,
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(milliseconds: 450),
              closedBuilder: (_, openContainer) {
                return ArticleCard(
                  key: const Key('widget_home_article_2'),
                  width: widgetWidth,
                  mainAxisAlignment: MainAxisAlignment.end,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFD390),
                      Color(0xFFFFD390),
                      Color(0xFFFFE1B3),
                    ],
                  ),
                  onTap: () {
                    openContainer();
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
                              S.of(context).home_help_article_title_2,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                S.of(context).home_help_article_content_2,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
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
                );
              },
              openElevation: 0,
              openColor: Theme.of(context).scaffoldBackgroundColor,
              middleColor: Theme.of(context).scaffoldBackgroundColor,
              closedElevation: 0,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              closedColor: const Color(0xFFFFD390),
              openBuilder: (_, closeContainer) {
                return WebViewPage(
                  url: ValueConvert('https://amooos.com/').encode(),
                );
              },
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

  /// 宽
  final double width;

  /// 背景渐变色
  final Gradient gradient;

  /// Column
  final MainAxisAlignment mainAxisAlignment;

  /// Column
  final CrossAxisAlignment crossAxisAlignment;

  /// 组件
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
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(18),
          ),
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
