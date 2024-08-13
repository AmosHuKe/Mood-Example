import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';

import 'package:moodexample/widgets/animation/animation.dart';

/// 引导页
class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SwiperBody(),
      ),
    );
  }
}

class SwiperBody extends StatefulWidget {
  const SwiperBody({super.key});

  @override
  State<SwiperBody> createState() => _SwiperBodyState();
}

class _SwiperBodyState extends State<SwiperBody> with TickerProviderStateMixin {
  /// 进步按钮动画
  late AnimationController _stepButtonController;
  late Animation<double> _stepButtonAnimation;
  late CurvedAnimation _stepButtonCurve;

  /// 进步按钮颜色动画
  late AnimationController _stepButtonColorController;
  late Animation _stepButtonColorAnimation;
  late final Color _stepButtonColor = Colors.black;

  /// Swiper下标
  int swiperIndex = 0;

  /// Swiper内容
  List<Widget> _swiperList = [];

  /// Swiper控制
  final SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();

    /// 进步按钮Icon动画
    _stepButtonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _stepButtonCurve = CurvedAnimation(
      parent: _stepButtonController,
      curve: Curves.linearToEaseOut,
    );
    _stepButtonAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_stepButtonController);
    _stepButtonAnimation.addListener(() {
      setState(() {});
    });

    /// 进步按钮颜色动画
    _stepButtonColorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _stepButtonColorAnimation = ColorTween(
      begin: _stepButtonColor,
      end: _stepButtonColor.withAlpha(200),
    ).animate(_stepButtonColorController);
  }

  @override
  void dispose() {
    /// 进步按钮Icon动画
    _stepButtonController.dispose();

    /// 进步按钮颜色动画
    _stepButtonColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 内容字体样式
    final textContentStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );

    /// Swiper内容
    _swiperList = [
      TextImageSwiper(
        title: S.of(context).onboarding_title_1,
        image: Image.asset(
          'assets/images/onboarding/onboarding_1.png',
          fit: BoxFit.cover,
          height: 320,
        ),
        describe: Column(
          children: [
            Text(
              S.of(context).onboarding_content_1_1,
              style: textContentStyle,
            ),
          ],
        ),
      ),
      TextImageSwiper(
        title: S.of(context).onboarding_title_2,
        image: Image.asset(
          'assets/images/onboarding/onboarding_2.png',
          fit: BoxFit.cover,
          height: 320,
        ),
        describe: Column(
          children: [
            Text(
              S.of(context).onboarding_content_2_1,
              style: textContentStyle,
            ),
            Text(
              S.of(context).onboarding_content_2_2,
              style: textContentStyle,
            ),
          ],
        ),
      ),
      TextImageSwiper(
        title: S.of(context).onboarding_title_3,
        image: Image.asset(
          'assets/images/onboarding/onboarding_3.png',
          fit: BoxFit.cover,
          height: 320,
        ),
        describe: Text(
          S.of(context).onboarding_content_3_1,
          style: textContentStyle,
        ),
      ),
    ];

    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return _swiperList[index];
            },
            onIndexChanged: (index) {
              if (index != _swiperList.length - 1) {
                _stepButtonController.reverse();
                _stepButtonColorController.reverse();
              } else {
                _stepButtonController.forward();
                _stepButtonColorController.forward();
              }
              setState(() {
                swiperIndex = index;
              });
            },
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: isDarkMode(context) ? Colors.white : Colors.black,
                color: Colors.grey,
                size: 8,
                space: 10,
              ),
              margin: const EdgeInsets.only(bottom: 24),
            ),
            controller: _swiperController,
            indicatorLayout: PageIndicatorLayout.WARM,
            loop: false,
            itemCount: _swiperList.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: AnimatedPress(
            child: AnimatedBuilder(
              animation: _stepButtonColorAnimation,
              builder: (context, child) => OutlinedButton(
                key: const Key('widget_next_button'),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor: WidgetStateProperty.all(
                    _stepButtonColorAnimation.value,
                  ),
                  textStyle: WidgetStateProperty.all(
                    const TextStyle(
                      fontSize: 240,
                    ),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: const BorderSide(
                        width: 0,
                      ),
                    ),
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.white10),
                ),
                onPressed: () {
                  if (swiperIndex == _swiperList.length - 1) {
                    context.pop();
                  } else {
                    _swiperController.next(animation: true);
                  }
                },
                child: Transform.rotate(
                  angle: _stepButtonCurve.value * 1.58,
                  child: Icon(
                    Remix.arrow_right_line,
                    size: 24,
                    semanticLabel:
                        swiperIndex == _swiperList.length - 1 ? '开始' : '下一页',
                  ),
                ),
              ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(child: image),
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14, left: 32, right: 32),
          child: describe,
        ),
      ],
    );
  }
}
