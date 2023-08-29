import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

import 'package:moodexample/widgets/will_pop_scope_route/will_pop_scope_route.dart';

import 'package:moodexample/models/mood/mood_model.dart';

import 'package:moodexample/views/mood/index.dart';
import 'package:moodexample/views/home/index.dart';
import 'package:moodexample/views/onboarding/index.dart';
import 'package:moodexample/views/mood/mood_category_select.dart';
import 'package:moodexample/views/mood/mood_content.dart';
import 'package:moodexample/views/settings/laboratory/index.dart';
import 'package:moodexample/views/web_view/web_view.dart';

/// 路由管理
class Routes {
  /// 定义路由名称
  /// 主页
  static String home = '/';

  /// 心情详情列表页
  static String mood = '/mood';

  /// 添加心情页
  static String moodCategorySelect = '/mood_category_select';

  /// 添加心情内容页
  static String moodContent = '/mood_content';

  /// 用户引导页
  static String onboarding = '/onboarding';

  /// 设置页-实验室
  static String settingLaboratory = '/setting_laboratory';

  /// WebView
  static String webViewPage = '/web_view_page';

  // 定义路由处理函数
  static final Handler _homeHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const WillPopScopeRoute(child: HomePage());
    },
  );
  static final Handler _moodHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const WillPopScopeRoute(child: MoodPage());
    },
  );
  static final Handler _addMoodHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return MoodCategorySelect(type: params['type'][0]);
    },
  );
  static final Handler _moodContentHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      final MoodData moodData = moodDataFromJson((params['moodData'][0]));
      return MoodContent(moodData: moodData);
    },
  );
  static final Handler _onboardingHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const Onboarding();
    },
  );
  static final Handler _settingLaboratoryHandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const LaboratoryPage();
    },
  );
  static final Handler _webViewPage = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return WebViewPage(url: params['url'][0]);
    },
  );

  /// 关联路由名称和处理函数
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        print('路由不存在!!!');
        return;
      },
    );
    router.define(home, handler: _homeHandle);
    router.define(mood, handler: _moodHandle);
    router.define(
      '$moodCategorySelect/:type',
      handler: _addMoodHandle,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '$moodContent/:moodData',
      handler: _moodContentHandle,
      transitionType: TransitionType.cupertinoFullScreenDialog,
    );
    router.define(
      onboarding,
      handler: _onboardingHandle,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      settingLaboratory,
      handler: _settingLaboratoryHandle,
      transitionType: TransitionType.cupertino,
    );
    router.define(
      '$webViewPage/:url',
      handler: _webViewPage,
      transitionType: TransitionType.fadeIn,
    );
  }

  /// 路由带参数
  ///
  /// 在路由需要传输参数时，将参数一一对应传入，返回String
  ///
  /// 例如：transformParams(router,["1","2"]) => router/1/2
  static String transformParams({
    required String router,
    required List<dynamic> params,
  }) {
    String transform = '';
    for (final value in params) {
      transform += '/$value';
    }
    print('$router$transform');
    return '$router$transform';
  }
}
