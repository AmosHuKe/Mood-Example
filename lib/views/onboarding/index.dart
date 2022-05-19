import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:card_swiper/card_swiper.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/generated/l10n.dart';

/// 引导页
class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      context,
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: SwiperBody(),
      ),
    );
  }
}

class SwiperBody extends StatefulWidget {
  const SwiperBody({Key? key}) : super(key: key);

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
        duration: const Duration(milliseconds: 500), vsync: this);
    _stepButtonColorAnimation =
        ColorTween(begin: _stepButtonColor, end: Theme.of(context).primaryColor)
            .animate(_stepButtonColorController);
  }

  /// 释放
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
    final textContentStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        );

    /// Swiper内容
    _swiperList = [
      TextImageSwiper(
        title: S.of(context).onboarding_title_1,
        image: Image.asset(
          "assets/images/onboarding/onboarding_1.png",
          fit: BoxFit.cover,
          height: 320.h,
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
          "assets/images/onboarding/onboarding_2.png",
          fit: BoxFit.cover,
          height: 320.h,
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
          "assets/images/onboarding/onboarding_3.png",
          fit: BoxFit.cover,
          height: 320.h,
        ),
        describe: Text(
          S.of(context).onboarding_content_3_1,
          style: textContentStyle,
        ),
      ),
    ];

    /// Return
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return _swiperList[index];
            },
            onIndexChanged: (index) => {
              if (index != _swiperList.length - 1)
                {
                  _stepButtonController.reverse(),
                  _stepButtonColorController.reverse()
                }
              else
                {
                  _stepButtonController.forward(),
                  _stepButtonColorController.forward()
                },
              setState(() {
                /// 赋值当前下标
                swiperIndex = index;
              })
            },
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: isDarkMode(context) ? Colors.white : Colors.black,
                color: Colors.grey,
                size: 8.w,
                space: 10.w,
              ),
              margin: EdgeInsets.only(
                bottom: 24.h,
              ),
            ),
            controller: _swiperController,
            indicatorLayout: PageIndicatorLayout.WARM,
            loop: false,
            itemCount: _swiperList.length,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 24.h,
          ),
          child: AnimatedBuilder(
            animation: _stepButtonColorAnimation,
            builder: (context, child) => OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(20.w)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all(_stepButtonColorAnimation.value),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 240.sp,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.h),
                    side: const BorderSide(
                      width: 0,
                    ),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Colors.white10),
              ),
              onPressed: () => {
                if (swiperIndex == _swiperList.length - 1)
                  {
                    /// 导航到新路由
                    Navigator.of(context).pop(),
                  }
                else
                  {
                    _swiperController.next(animation: true),
                  }
              },
              child: Transform.rotate(
                angle: _stepButtonCurve.value * 1.58,
                child: Icon(
                  Remix.arrow_right_line,
                  size: 24.sp,
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
  /// 标题（最多两行为视图最佳）
  final String title;

  /// 描述（最多两行为视图最佳）
  final Widget describe;

  /// 图片
  final Image image;

  const TextImageSwiper({
    Key? key,
    required this.title,
    required this.describe,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          child: image,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 32.w,
            right: 32.w,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 14.h,
            left: 32.w,
            right: 32.w,
          ),
          child: describe,
        ),
      ],
    );
  }
}
