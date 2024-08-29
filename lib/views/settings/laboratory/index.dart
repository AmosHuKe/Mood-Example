import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/routes.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';

import 'package:moodexample/widgets/animation/animation.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

class LaboratoryPage extends StatelessWidget {
  const LaboratoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        floatingActionButton: ActionButton(
          key: const Key('widget_laboratory_back_button'),
          semanticsLabel: '返回',
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Remix.arrow_left_line,
            size: 18,
            color: Colors.white,
          ),
          onTap: () {
            context.pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: const SafeArea(
          key: Key('widget_laboratory_page'),
          child: LaboratoryBody(),
        ),
      ),
    );
  }
}

class LaboratoryBody extends StatelessWidget {
  const LaboratoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 24, bottom: 20),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 标题
        Container(
          margin: const EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).app_setting_laboratory,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Remix.flask_line, size: 48, color: Colors.black12),
            ],
          ),
        ),
        ListCard(
          leading: const Icon(
            Remix.mini_program_line,
            size: 32,
            color: Colors.black87,
          ),
          title: 'uniapp 小程序',
          subtitle: '集成 UniMPSDK 可在 APP 内打开 uniapp 小程序。',
          onPressed: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryUniMPMiniapps);
          },
        ),
        ListCard(
          leading: const Icon(
            Remix.building_2_line,
            size: 32,
            color: Colors.black87,
          ),
          title: '3D 城市',
          subtitle: '3D 来源 https://github.com/pissang/little-big-city',
          onPressed: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryPage3D);
          },
        ),
        ListCard(
          leading: const Icon(
            Remix.gamepad_line,
            size: 32,
            color: Colors.black87,
          ),
          title: '游戏合集',
          subtitle: '基于 Flame、Bonfire 的 2D 游戏。',
          onPressed: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryGame);
          },
        ),
        ListCard(
          leading: const Icon(
            Remix.align_vertically,
            size: 32,
            color: Colors.black87,
          ),
          title: 'FFI 异步调用 C/C++',
          subtitle: '通过 FFI 异步调用 C/C++ 并监听',
          onPressed: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryFFI);
          },
        ),
        const ListCard(
          leading: Icon(
            Remix.account_box_line,
            size: 32,
            color: Colors.black87,
          ),
          title: '...',
          subtitle: '......',
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
    return AnimatedPress(
      scaleEnd: 0.95,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 12),
        shadowColor: Colors.black38,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
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
      ),
    );
  }
}
