import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:animations/animations.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/widgets/animation/animation.dart';
import 'package:moodexample/views/mood/mood_content.dart';
import 'package:moodexample/views/web_view/web_view.dart';

///
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: HomeBody(key: Key("widget_home_body")),
      ),
    );
  }
}

/// 首页主体
class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

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
          backgroundColor: Colors.transparent,
          flexibleSpace: Align(
            child: Container(
              margin: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      S.of(context).home_hi,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                          ),
                      semanticsLabel:
                          S.of(context).app_bottomNavigationBar_title_home,
                    ),
                  ),
                  Image.asset(
                    "assets/images/woolly/woolly-yellow-star.png",
                    height: 60.w,
                    excludeFromSemantics: true,
                  ),
                ],
              ),
            ),
          ),
          collapsedHeight: 100.w,
          expandedHeight: 100.w,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 48.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 头部
                    Semantics(
                      container: true,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          top: 0.w,
                          bottom: 12.w,
                        ),
                        child: const Header(),
                      ),
                    ),

                    /// 情绪选项卡
                    const OptionMood(key: Key("widget_option_mood")),

                    /// 公告卡片
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 24.w,
                        bottom: 24.w,
                      ),
                      child: const MergeSemantics(child: NoticeCard()),
                    ),

                    /// 相关文章
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 24.w,
                        bottom: 24.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            container: true,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 24.w),
                              child: Text(
                                S.of(context).home_help_title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
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
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}

/// 头部
class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.w),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  S.of(context).home_moodChoice_title,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 20.sp,
                      ),
                ),
              ),
              Consumer<MoodViewModel>(
                builder: (_, moodViewModel, child) {
                  /// 加载数据的占位
                  if (moodViewModel.moodCategoryList!.isEmpty) {
                    return Align(
                      child: CupertinoActivityIndicator(radius: 12.sp),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 情绪选项卡
class OptionMood extends StatefulWidget {
  const OptionMood({Key? key}) : super(key: key);

  @override
  State<OptionMood> createState() => _OptionMoodState();
}

class _OptionMoodState extends State<OptionMood> {
  @override
  void initState() {
    super.initState();
    MoodViewModel moodViewModel =
        Provider.of<MoodViewModel>(context, listen: false);

    /// 获取所有心情类别
    MoodService.getMoodCategoryAll(moodViewModel);
  }

  /// Return
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 12.w,
        bottom: 12.w,
      ),
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Consumer<MoodViewModel>(
        builder: (_, moodViewModel, child) {
          /// 所有心情类型数据
          List<Widget> widgetList = [];

          /// 数据渲染
          for (MoodCategoryData list in moodViewModel.moodCategoryList ?? []) {
            /// 获取所有心情类别
            moodViewModel.setMoodCategoryData(list);
            MoodCategoryData moodCategoryData = moodViewModel.moodCategoryData;
            widgetList.add(
              OptionCard(
                title: moodCategoryData.title ?? "",
                icon: moodCategoryData.icon ?? "",
              ),
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
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  /// 标题
  final String title;
  final String icon;

  /// 图标大小
  static final double _iconSize = 32.sp;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      useRootNavigator: true,
      clipBehavior: Clip.none,
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 450),
      closedBuilder: (_, openContainer) {
        return GestureDetector(
          child: Column(
            children: [
              AnimatedPress(
                child: Container(
                  constraints: BoxConstraints(minWidth: 52.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode(context)
                          ? [const Color(0xFF2B3034), const Color(0xFF2B3034)]
                          : [
                              AppTheme.backgroundColor1,
                              AppTheme.backgroundColor1
                            ],
                    ),
                    borderRadius: BorderRadius.circular(18.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                      right: 8.w,
                      top: 18.w,
                      bottom: 18.w,
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
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ],
          ),
          onTap: () {
            openContainer();
          },
        );
      },
      openElevation: 0,
      openColor: Colors.transparent,
      middleColor: Colors.transparent,
      closedElevation: 0,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.w)),
      closedColor: Colors.transparent,
      openBuilder: (_, closeContainer) {
        // 跳转输入内容页
        String nowDateTime = DateTime.now().toString().substring(0, 10);
        MoodData moodData = MoodData();
        moodData.icon = icon;
        moodData.title = title;
        moodData.createTime = nowDateTime;
        moodData.updateTime = nowDateTime;
        return MoodContent(moodData: moodData);
      },
    );
  }
}

/// 公告卡片
class NoticeCard extends StatelessWidget {
  const NoticeCard({Key? key}) : super(key: key);

  /// 阴影
  Widget shadow({EdgeInsetsGeometry? margin, required double opacity}) {
    return Container(
      height: 190.w,
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFBBBB).withOpacity(opacity),
            const Color(0xFFFFBBBB).withOpacity(opacity)
          ],
        ),
        borderRadius: BorderRadius.circular(24.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 阴影
        shadow(
          opacity: 0.2,
          margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.w),
        ),
        shadow(
          opacity: 0.4,
          margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.w),
        ),

        /// 正文
        SizedBox(
          height: 190.w,
          child: const ActionCard(),
        ),
      ],
    );
  }
}

/// 操作卡片
class ActionCard extends StatefulWidget {
  const ActionCard({Key? key}) : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFFFFBBBB),
            Color(0xFFFFBBBB),
            Color(0xFFFFC5C5),
          ],
        ),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 24.w,
          bottom: 24.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                /// 图片或装饰
                Positioned(
                  bottom: -18.w,
                  left: 128.w,
                  child: Image.asset(
                    'assets/images/onboarding/onboarding_3.png',
                    fit: BoxFit.contain,
                    width: 180.w,
                  ),
                ),

                /// 文字和按钮
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
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
                            padding: EdgeInsets.only(
                              top: 8.w,
                            ),
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
                    ),
                    Container(
                      constraints:
                          BoxConstraints(minHeight: 45.w, minWidth: 95.w),
                      child: AnimatedPress(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
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
                            overlayColor:
                                MaterialStateProperty.all(Colors.white10),
                          ),
                          onPressed: () => {
                            /// 导航到新路由
                            Navigator.pushNamed(
                              context,
                              Routes.onboarding,
                            ).then((result) {})
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.w, right: 4.w),
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
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// 相关文章
class Article extends StatefulWidget {
  const Article({Key? key}) : super(key: key);

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
              key: const Key("widget_home_article_1"),
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
                          padding: EdgeInsets.only(
                            top: 6.w,
                            bottom: 6.w,
                          ),
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
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.w)),
          closedColor: const Color(0xFFFFCEBD),
          openBuilder: (_, closeContainer) {
            return WebViewPage(
              url: ValueConvert("https://github.com/AmosHuKe/Mood-Example")
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
              key: const Key("widget_home_article_2"),
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
                          padding: EdgeInsets.only(
                            top: 6.w,
                            bottom: 6.w,
                          ),
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
                        )
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
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.w)),
          closedColor: const Color(0xFFFFD390),
          openBuilder: (_, closeContainer) {
            return WebViewPage(
              url: ValueConvert("https://amoshk.top/").encode(),
            );
          },
        ),
      ],
    );
  }
}

/// 文章卡片
class ArticleCard extends StatelessWidget {
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

  final Function()? onTap;

  const ArticleCard({
    Key? key,
    required this.height,
    required this.width,
    required this.gradient,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.children,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      scaleEnd: 0.9,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(17.w),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 14.w,
                right: 14.w,
                top: 14.w,
                bottom: 14.w,
              ),
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
