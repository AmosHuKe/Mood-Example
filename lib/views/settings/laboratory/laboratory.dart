// dart format width=80
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../router.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../widgets/animation/animation.dart';
import '../../../widgets/action_button/action_button.dart';

class LaboratoryScreen extends StatelessWidget {
  const LaboratoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themePrimaryColor = theme.primaryColor;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Theme(
        data: ThemeData(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF1F2F3),
          floatingActionButton: ActionButton(
            key: const Key('widget_laboratory_back_button'),
            semanticsLabel: '返回',
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: themePrimaryColor,
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
          body: const LaboratoryBody(key: Key('widget_laboratory_page')),
        ),
      ),
    );
  }
}

class LaboratoryBody extends StatelessWidget {
  const LaboratoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 64),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 标题
        SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appL10n.app_setting_laboratory,
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
        ),

        OpenCard(
          icon: Remix.mini_program_line,
          title: 'uniapp 小程序',
          subtitle: '集成 UniMPSDK 可在 APP 内打开 uniapp 小程序。',
          onTap: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryUniMPMiniapps);
          },
        ),
        OpenCard(
          icon: Remix.building_2_line,
          title: '3D 城市',
          subtitle: '3D 来源 https://github.com/pissang/little-big-city',
          onTap: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryPage3D);
          },
        ),
        OpenCard(
          icon: Remix.gamepad_line,
          title: '游戏合集',
          subtitle: '基于 Flame、Bonfire 的 2D 游戏。',
          onTap: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryGame);
          },
        ),
        OpenCard(
          icon: Remix.align_vertically,
          title: 'FFI 异步调用 C/C++',
          subtitle: '通过 FFI 异步调用 C/C++ 并监听',
          onTap: () {
            GoRouter.of(context).pushNamed(Routes.laboratoryFFI);
          },
        ),
      ],
    );
  }
}

class OpenCard extends StatelessWidget {
  const OpenCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 描述
  final String subtitle;

  /// 点击打开触发
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      scaleEnd: 0.95,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10.0,
              children: [
                Icon(icon, size: 32, color: Colors.black87),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                  strutStyle: const StrutStyle(
                    forceStrutHeight: true,
                    fontSize: 16,
                    height: 1,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsGeometry.only(left: 4),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: onTap,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: 4,
                    bottom: 4,
                    left: 4,
                    right: 6,
                  ),
                  child: Text('打开'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
