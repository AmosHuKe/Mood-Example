import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';

import 'package:moodexample/widgets/action_button/action_button.dart';

class UniMPMiniappsPage extends StatefulWidget {
  const UniMPMiniappsPage({super.key});

  @override
  State<UniMPMiniappsPage> createState() => _UniMPMiniappsPageState();
}

class _UniMPMiniappsPageState extends State<UniMPMiniappsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: const Text('uniapp 小程序'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor1,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(18)),
            ),
            child: const Icon(
              Remix.arrow_left_line,
              size: 24,
            ),
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: const SafeArea(
          child: UniMPMiniappsBody(),
        ),
      ),
    );
  }
}

class UniMPMiniappsBody extends StatefulWidget {
  const UniMPMiniappsBody({super.key});

  @override
  State<UniMPMiniappsBody> createState() => _UniMPMiniappsBodyState();
}

class _UniMPMiniappsBodyState extends State<UniMPMiniappsBody> {
  @override
  Widget build(BuildContext context) {
    // 创建渠道与原生沟通
    const channel = MethodChannel('UniMP_mini_apps');

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

    return ListView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 20),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 版本
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('UniMPSDK_Android 版本：4.15'),
              Text('UniMPSDK_iOS 版本：4.15'),
              Text('HBuilderX 版本：4.15'),
            ],
          ),
        ),

        /// 小程序
        ListCard(
          leading: const Icon(
            Remix.mini_program_fill,
            size: 32,
            color: Colors.black87,
          ),
          title: 'uView2.0',
          subtitle: 'uView UI，是 uni-app 生态优秀的 UI 框架，全面的组件和便捷的工具会让您信手拈来，如鱼得水',
          onPressed: () async {
            await callNativeMethod('__UNI__F87B0CE');
          },
        ),
        ListCard(
          leading: const Icon(
            Remix.mini_program_fill,
            size: 32,
            color: Colors.black87,
          ),
          title: 'hello-uniapp',
          subtitle: '演示 uni-app 框架的组件、接口、模板等',
          onPressed: () async {
            await callNativeMethod('__UNI__3BC70CE');
          },
        ),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    this.onPressed,
  });

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 图标
  final Widget leading;

  /// 点击打开触发
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shadowColor: Colors.black38,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(48)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            ListTile(
              leading: leading,
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: const Text('打开'),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
