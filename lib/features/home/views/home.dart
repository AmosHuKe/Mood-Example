import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../domain/models/mood/mood_category_model.dart';
import '../../../domain/models/mood/mood_data_model.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../router.dart';
import '../../../shared/themes/app_theme.dart';
import '../../../utils/utils.dart';
import '../../../widgets/animation/animation.dart';
import '../providers/home_provider.dart';

/// 首页
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeProvider(moodCategoryLoadUseCase: context.read());
      },
      child: const Scaffold(body: HomeBody(key: .new('widget_home_body'))),
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
            child: Padding(
              padding: const .symmetric(horizontal: 24),
              child: Align(
                alignment: .center,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      appL10n.home_hi,
                      style: const .new(fontSize: 48, fontWeight: .bold),
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
          ),
          collapsedHeight: 100,
          expandedHeight: 100,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .only(bottom: 48),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                /// 头部
                Padding(
                  padding: const .only(top: 12, left: 24, right: 24),
                  child: Semantics(container: true, child: const Header()),
                ),

                /// 情绪选项卡
                const Padding(
                  padding: .only(top: 12),
                  child: MoodOption(key: .new('widget_mood_option')),
                ),

                /// 公告卡片
                const Padding(
                  padding: .all(24),
                  child: MergeSemantics(child: NoticeCard()),
                ),

                /// 相关文章
                Padding(
                  padding: const .all(24),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Semantics(
                        container: true,
                        child: Padding(
                          padding: const .only(bottom: 24),
                          child: Text(
                            appL10n.home_help_title,
                            style: const .new(fontSize: 24, fontWeight: .bold),
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
            style: const .new(fontWeight: .normal, fontSize: 24),
          ),
        ),
        Selector<HomeProvider, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
          selector: (_, homeProvider) {
            return (loading: homeProvider.loading, moodCategoryAll: homeProvider.moodCategoryAll);
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
      padding: const .symmetric(horizontal: 24, vertical: 12),
      scrollDirection: .horizontal,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Selector<HomeProvider, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
        selector: (_, homeProvider) {
          return (loading: homeProvider.loading, moodCategoryAll: homeProvider.moodCategoryAll);
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
            alignment: .spaceBetween,
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
    const iconSize = 32.0;

    return GestureDetector(
      onTap: () {
        // 跳转输入内容页
        final nowDateTime = Utils.datetimeFormatToString(.now());
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
            child: ConstrainedBox(
              constraints: const .new(minWidth: 52),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2B3034) : AppTheme.staticBackgroundColor1,
                  borderRadius: .circular(18),
                ),
                child: Padding(
                  padding: const .symmetric(horizontal: 8, vertical: 18),
                  child: Align(
                    child: Text(icon, style: const .new(fontSize: iconSize)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const .only(top: 10),
            child: Text(title, style: const .new(fontSize: 14)),
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
    return Center(
      child: ConstrainedBox(
        constraints: const .new(maxWidth: 328),
        child: Stack(
          children: [
            /// 阴影
            shadow(opacity: 0.2, margin: const .only(left: 24, right: 24, top: 16)),
            shadow(opacity: 0.4, margin: const .only(left: 12, right: 12, top: 8)),

            /// 正文
            const SizedBox(height: 190, child: NoticeMainCard()),
          ],
        ),
      ),
    );
  }

  /// 阴影
  Widget shadow({required EdgeInsetsGeometry margin, required double opacity}) {
    return Padding(
      padding: margin,
      child: SizedBox(
        width: double.infinity,
        height: 190,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFFFBBBB).withValues(alpha: opacity),
            borderRadius: .circular(24),
          ),
        ),
      ),
    );
  }
}

/// 公告主卡片
class NoticeMainCard extends StatelessWidget {
  const NoticeMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: .bottomLeft,
          end: .topRight,
          colors: [Color(0xFFFFBBBB), Color(0xFFFFBBBB), Color(0xFFFFC5C5)],
        ),
        borderRadius: .circular(30),
      ),
      child: Padding(
        padding: const .all(24),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            Stack(
              clipBehavior: .none,
              alignment: .centerLeft,
              children: [
                /// 图片或装饰
                Positioned(
                  bottom: -18,
                  left: 140,
                  child: Image.asset(
                    'assets/images/onboarding/onboarding_3.png',
                    fit: .contain,
                    width: 180,
                  ),
                ),

                /// 文字和按钮
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            appL10n.home_upgrade_title,
                            style: const .new(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: .w900,
                            ),
                          ),
                          Padding(
                            padding: const .only(top: 8),
                            child: Text(
                              appL10n.home_upgrade_content,
                              style: const .new(color: Colors.black87, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const .new(minHeight: 45, minWidth: 95),
                      child: AnimatedPress(
                        child: OutlinedButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(Routes.onboarding);
                          },
                          style: .new(
                            foregroundColor: const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: const WidgetStatePropertyAll(Colors.black87),
                            textStyle: const WidgetStatePropertyAll(
                              .new(fontSize: 14, fontWeight: .w400),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(borderRadius: .circular(14)),
                            ),
                            overlayColor: const WidgetStatePropertyAll(Colors.white10),
                          ),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              Padding(
                                padding: const .only(right: 4),
                                child: Text(
                                  appL10n.home_upgrade_button,
                                  strutStyle: const .new(forceStrutHeight: false, leading: 1),
                                  style: const .new(fontSize: 14),
                                ),
                              ),
                              const Icon(Remix.play_circle_fill, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
          crossAxisAlignment: .end,
          children: [
            ArticleCard(
              key: const .new('widget_home_article_1'),
              width: widgetWidth,
              gradient: const LinearGradient(
                begin: .bottomLeft,
                end: .topRight,
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
                  clipBehavior: .none,
                  alignment: .bottomCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      bottom: -12,
                      left: 0,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_2.png',
                        fit: .contain,
                        height: 120,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          appL10n.home_help_article_title_1,
                          style: const .new(color: Colors.black, fontSize: 16, fontWeight: .w900),
                        ),
                        Padding(
                          padding: const .symmetric(vertical: 6),
                          child: Text(
                            appL10n.home_help_article_content_1,
                            style: const .new(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: .only(top: 4),
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
              key: const .new('widget_home_article_2'),
              width: widgetWidth,
              mainAxisAlignment: .end,
              gradient: const LinearGradient(
                begin: .topLeft,
                end: .bottomRight,
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
                  clipBehavior: .none,
                  alignment: .topCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      top: -64,
                      left: 0,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_1.png',
                        fit: .contain,
                        height: 120,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        const SizedBox(height: 72),
                        Text(
                          appL10n.home_help_article_title_2,
                          style: const .new(color: Colors.black, fontSize: 16, fontWeight: .w900),
                        ),
                        Padding(
                          padding: const .symmetric(vertical: 6),
                          child: Text(
                            appL10n.home_help_article_content_2,
                            style: const .new(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                        const Padding(
                          padding: .only(top: 4),
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
      scaleEnd: 0.95,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const .all(14),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
