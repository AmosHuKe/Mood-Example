import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../widgets/action_button/action_button.dart';
import '../laboratory.dart' show OpenCard;

class UniMPMiniappsScreen extends StatelessWidget {
  const UniMPMiniappsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: .new(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F3),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF1F2F3),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const .new(color: Colors.black, fontSize: 14),
          title: const Text('uniapp 小程序'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: const SafeArea(child: UniMPMiniappsBody()),
      ),
    );
  }
}

class UniMPMiniappsBody extends StatelessWidget {
  const UniMPMiniappsBody({super.key});

  // 创建渠道与原生沟通
  static const channel = MethodChannel('UniMP_mini_apps');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .only(left: 24, right: 24, top: 24, bottom: 20),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        /// 版本
        const Padding(
          padding: .only(bottom: 24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('UniMPSDK_Android 版本：4.75'),
              Text('UniMPSDK_iOS 版本：4.75'),
              Text('HBuilderX 版本：4.75'),
            ],
          ),
        ),

        /// 小程序
        OpenCard(
          icon: Remix.mini_program_fill,
          title: 'uView UI',
          subtitle: '多平台快速开发的 UI 框架',
          onTap: () async {
            await callNativeMethod('__UNI__F87B0CE');
          },
        ),
        OpenCard(
          icon: Remix.mini_program_fill,
          title: 'hello-uniapp',
          subtitle: '演示 uni-app 框架的组件、接口、模板等',
          onTap: () async {
            await callNativeMethod('__UNI__3BC70CE');
          },
        ),
      ],
    );
  }

  Future callNativeMethod(String appID) async {
    try {
      // 通过渠道，调用原生代码代码的方法
      final future = await channel.invokeMethod('open', {'AppID': appID});
      // 打印执行的结果
      print(future.toString());
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
