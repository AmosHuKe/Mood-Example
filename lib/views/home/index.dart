import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:animations/animations.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/generated/l10n.dart';
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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  /// AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    /// AutomaticKeepAliveClientMixin
    super.build(context);
    return const Scaffold(
      body: SafeArea(
        child: HomeBody(key: Key('widget_home_body')),
      ),
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
          flexibleSpace: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).home_hi,
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  semanticsLabel:
                      S.of(context).app_bottomNavigationBar_title_home,
                ),
                Image.asset(
                  'assets/images/woolly/woolly-yellow-star.png',
                  height: 60.w,
                  excludeFromSemantics: true,
                ),
              ],
            ),
          ),
          collapsedHeight: 100.w,
          expandedHeight: 100.w,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 头部
                Padding(
                  padding: EdgeInsets.only(top: 12.w, left: 24.w, right: 24.w),
                  child: Semantics(
                    container: true,
                    child: const Header(),
                  ),
                ),

                /// 情绪选项卡
                Padding(
                  padding: EdgeInsets.only(top: 12.w),
                  child: const OptionMood(key: Key('widget_option_mood')),
                ),

                /// 公告卡片
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: const MergeSemantics(child: NoticeCard()),
                ),

                /// 相关文章
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        container: true,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24.w),
                          child: Text(
                            S.of(context).home_help_title,
                            style: TextStyle(
                              fontSize: 24.sp,
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
        Text(
          S.of(context).home_moodChoice_title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.sp,
          ),
        ),
        Consumer<MoodProvider>(
          builder: (_, moodProvider, child) {
            /// 加载数据的占位
            if (moodProvider.moodCategoryList.isEmpty) {
              return Align(
                child: CupertinoActivityIndicator(radius: 12.sp),
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
    final MoodProvider moodProvider = context.read<MoodProvider>();

    /// 获取所有心情类别
    moodProvider.loadMoodCategoryAllList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
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
            spacing: 24.w, // 主轴(水平)方向间距
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
    final double _iconSize = 32.sp;

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
                      constraints: BoxConstraints(minWidth: 52.w),
                      decoration: BoxDecoration(
                        color: isDarkMode(context)
                            ? const Color(0xFF2B3034)
                            : AppTheme.backgroundColor1,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 18.w,
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
                    padding: EdgeInsets.only(top: 10.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
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
            borderRadius: BorderRadius.circular(18.w),
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
            right: -20.w,
            child: TiltParallax(
              size: const Offset(15, 15),
              child: Image.asset(
                'assets/images/onboarding/onboarding_3.png',
                fit: BoxFit.contain,
                width: 180.w,
              ),
            ),
          ),
        ],
        inner: [
          Positioned(
            left: 24.w,
            bottom: 24.w,
            child: TiltParallax(
              size: const Offset(5, 5),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 45.w,
                  minWidth: 95.w,
                ),
                child: AnimatedPress(
                  child: OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black87),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all(Colors.white10),
                    ),
                    onPressed: () => {
                      /// 导航到新路由
                      Navigator.pushNamed(
                        context,
                        Routes.onboarding,
                      ).then((result) {}),
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            S.of(context).home_upgrade_button,
                            strutStyle: const StrutStyle(
                              forceStrutHeight: false,
                              leading: 1,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        Icon(
                          Remix.play_circle_fill,
                          size: 24.sp,
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
              margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 32.w),
            ),
          ),
          TiltParallax(
            size: const Offset(-8, -8),
            child: shadow(
              opacity: 0.4,
              margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.w),
            ),
          ),
        ],
      ),
      child: SizedBox(
        height: 190.w,
        child: const ActionCard(),
      ),
    );
  }

  /// 阴影
  Widget shadow({
    EdgeInsetsGeometry? margin,
    required double opacity,
  }) {
    return Container(
      height: 190.w,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFFFFBBBB).withOpacity(opacity),
        borderRadius: BorderRadius.circular(24.sp),
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
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFBBBB), Color(0xFFFFBBBB), Color(0xFFFFC5C5)],
        ),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 文字和按钮
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).home_upgrade_title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Text(
                  S.of(context).home_upgrade_content,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
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
    return Wrap(
      spacing: 16.w, // 主轴(水平)方向间距
      runSpacing: 24.w, // 纵轴（垂直）方向间距
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
              height: 220.w,
              width: 148.w,
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
                vibrate();
                openContainer();
              },
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      bottom: -12.w,
                      left: 0.w,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_2.png',
                        fit: BoxFit.contain,
                        height: 120.w,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).home_help_article_title_1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          child: Text(
                            S.of(context).home_help_article_content_1,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.w),
                          child: Icon(
                            Remix.arrow_right_circle_fill,
                            size: 24.sp,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 100.w),
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
            borderRadius: BorderRadius.circular(17.w),
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
              height: 200.w,
              width: 148.w,
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
                vibrate();
                openContainer();
              },
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    /// 图片或装饰
                    Positioned(
                      top: -48.w,
                      left: 0.w,
                      child: Image.asset(
                        'assets/images/onboarding/onboarding_1.png',
                        fit: BoxFit.contain,
                        height: 120.w,
                      ),
                    ),

                    /// 文字和按钮
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 72.w),
                        Text(
                          S.of(context).home_help_article_title_2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          child: Text(
                            S.of(context).home_help_article_content_2,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.w),
                          child: Icon(
                            Remix.arrow_right_circle_fill,
                            size: 24.sp,
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
            borderRadius: BorderRadius.circular(17.w),
          ),
          closedColor: const Color(0xFFFFD390),
          openBuilder: (_, closeContainer) {
            return WebViewPage(
              url: ValueConvert('https://amoshk.top/').encode(),
            );
          },
        ),
      ],
    );
  }
}

/// 文章卡片
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.height,
    required this.width,
    required this.gradient,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.children,
    this.onTap,
  });

  /// 高
  final double height;

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
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(17.w),
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
