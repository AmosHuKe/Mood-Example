import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../widgets/animation/animation.dart';

/// 引导页
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: OnboardingBody()), // dart format
    );
  }
}

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> with TickerProviderStateMixin {
  int swiperIndex = 0;
  List<Widget> swiperList = [];
  final SwiperController swiperController = SwiperController();

  /// 进步按钮动画
  late AnimationController stepButtonController;
  late Animation<double> stepButtonAnimation;
  late CurvedAnimation stepButtonCurve;

  /// 进步按钮颜色动画
  late AnimationController stepButtonColorController;
  late Animation stepButtonColorAnimation;
  final Color stepButtonColor = Colors.black;

  @override
  void initState() {
    super.initState();

    /// 进步按钮Icon动画
    stepButtonController = .new(duration: const .new(milliseconds: 500), vsync: this);
    stepButtonCurve = .new(parent: stepButtonController, curve: Curves.linearToEaseOut);
    stepButtonAnimation = Tween(begin: 0.0, end: 1.0).animate(stepButtonController);
    stepButtonAnimation.addListener(() {
      setState(() {});
    });

    /// 进步按钮颜色动画
    stepButtonColorController = .new(duration: const .new(milliseconds: 500), vsync: this);
    stepButtonColorAnimation = ColorTween(
      begin: stepButtonColor,
      end: stepButtonColor.withAlpha(200),
    ).animate(stepButtonColorController);
  }

  @override
  void dispose() {
    stepButtonController.dispose();
    stepButtonColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    const textContentStyle = TextStyle(fontSize: 18, fontWeight: .w400);
    swiperList = [
      TextImageSwiper(
        title: appL10n.onboarding_title_1,
        image: Image.asset('assets/images/onboarding/onboarding_1.png', fit: .cover, height: 320),
        describe: Column(children: [Text(appL10n.onboarding_content_1_1, style: textContentStyle)]),
      ),
      TextImageSwiper(
        title: appL10n.onboarding_title_2,
        image: Image.asset('assets/images/onboarding/onboarding_2.png', fit: .cover, height: 320),
        describe: Column(
          children: [
            Text(appL10n.onboarding_content_2_1, style: textContentStyle),
            Text(appL10n.onboarding_content_2_2, style: textContentStyle),
          ],
        ),
      ),
      TextImageSwiper(
        title: appL10n.onboarding_title_3,
        image: Image.asset('assets/images/onboarding/onboarding_3.png', fit: .cover, height: 320),
        describe: Text(appL10n.onboarding_content_3_1, style: textContentStyle),
      ),
    ];

    return Flex(
      direction: .vertical,
      children: [
        Expanded(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return swiperList[index];
            },
            onIndexChanged: (index) {
              if (index != swiperList.length - 1) {
                stepButtonController.reverse();
                stepButtonColorController.reverse();
              } else {
                stepButtonController.forward();
                stepButtonColorController.forward();
              }
              setState(() {
                swiperIndex = index;
              });
            },
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: isDark ? Colors.white : Colors.black,
                color: Colors.grey,
                size: 8,
                space: 10,
              ),
              margin: const .only(bottom: 24),
            ),
            controller: swiperController,
            indicatorLayout: .WARM,
            loop: false,
            itemCount: swiperList.length,
          ),
        ),
        Padding(
          padding: const .symmetric(vertical: 24),
          child: AnimatedPress(
            child: AnimatedBuilder(
              animation: stepButtonColorAnimation,
              builder: (context, child) {
                return OutlinedButton(
                  key: const .new('widget_next_button'),
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(.all(20)),
                    foregroundColor: const WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(stepButtonColorAnimation.value),
                    textStyle: const WidgetStatePropertyAll(.new(fontSize: 240)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: .circular(100),
                        side: const .new(width: 0),
                      ),
                    ),
                    overlayColor: const WidgetStatePropertyAll(Colors.white10),
                  ),
                  onPressed: () {
                    if (swiperIndex == swiperList.length - 1) {
                      context.pop();
                    } else {
                      swiperController.next(animation: true);
                    }
                  },
                  child: Transform.rotate(
                    angle: stepButtonCurve.value * 1.58,
                    child: Icon(
                      Remix.arrow_right_line,
                      size: 24,
                      semanticLabel: swiperIndex == swiperList.length - 1 ? '开始' : '下一页',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// 图片和文字组合的引导
class TextImageSwiper extends StatelessWidget {
  const TextImageSwiper({
    super.key,
    required this.title,
    required this.describe,
    required this.image,
  });

  /// 标题（最多两行为视图最佳）
  final String title;

  /// 描述（最多两行为视图最佳）
  final Widget describe;

  /// 图片
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        Align(child: image),
        Padding(
          padding: const .only(left: 32, right: 32),
          child: Text(
            title,
            style: const .new(fontSize: 32, fontWeight: .w900), // dart format
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14, left: 32, right: 32),
          child: describe, // dart format
        ),
      ],
    );
  }
}
