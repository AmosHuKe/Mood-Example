// dart format width=80
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../router.dart';
import '../../utils/utils.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../widgets/show_modal_bottom_detail/show_modal_bottom_detail.dart';
import 'widgets/setting_theme.dart';
import 'widgets/setting_language.dart';
import 'widgets/setting_database.dart';
import 'widgets/setting_key.dart';

/// 外层抽屉设置菜单（左）
class SettingMenuScreen extends StatelessWidget {
  const SettingMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const SettingMenuBody(),
      onTap: () => ZoomDrawer.of(context)?.toggle.call(),
    );
  }
}

class SettingMenuBody extends StatelessWidget {
  const SettingMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: .light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            const Padding(
              padding: .only(top: 72, bottom: 48, left: 24, right: 24),
              child: Header(),
            ),
            const Padding(
              padding: .only(bottom: 24, left: 24, right: 24),
              child: Menu(),
            ),

            /// 插画
            BlockSemanticsToDrawerClosed(
              child: Padding(
                padding: const .only(left: 24, bottom: 24),
                child: Image.asset(
                  'assets/images/woolly/woolly-comet-2.png',
                  width: 240,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '关闭设置',
      child: SafeArea(
        child: Row(
          children: [
            ClipRRect(
              key: const .new('widget_menu_screen_left_logo'),
              borderRadius: .circular(14),
              child: Image.asset(
                'assets/images/logo.png',
                width: 42,
                height: 42,
              ),
            ),
            const Padding(
              padding: .only(left: 12),
              child: Text(
                'Mood',
                style: .new(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: .bold,
                ),
                semanticsLabel: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 菜单
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        MenuItem(
          icon: Remix.database_2_line,
          title: appL10n.app_setting_database,
          onTap: () {
            print('数据');
            showModalBottomDetail(
              context: context,
              child: const SettingDatabase(),
            );
          },
        ),
        MenuItem(
          icon: Remix.shield_keyhole_line,
          title: appL10n.app_setting_security,
          onTap: () {
            print('安全');
            showModalBottomDetail(context: context, child: const SettingKey());
          },
        ),
        MenuItem(
          icon: Remix.bubble_chart_line,
          title: appL10n.app_setting_theme,
          onTap: () {
            print('主题');
            showModalBottomDetail(
              context: context,
              child: const SettingTheme(),
            );
          },
        ),
        MenuItem(
          icon: Remix.global_line,
          title: appL10n.app_setting_language,
          onTap: () {
            print('语言');
            showModalBottomDetail(
              context: context,
              child: const SettingLanguage(),
            );
          },
        ),
        MenuItem(
          icon: Remix.flask_line,
          title: appL10n.app_setting_laboratory,
          onTap: () {
            print('实验室');
            GoRouter.of(context).pushNamed(Routes.settingLaboratory);
          },
        ),
        MenuItem(
          icon: Remix.heart_3_line,
          title: appL10n.app_setting_about,
          onTap: () {
            print('关于');
            final url = ValueBase64(
              'https://github.com/AmosHuKe/Mood-Example',
            ).encode();
            GoRouter.of(
              context,
            ).pushNamed(Routes.webViewPage, pathParameters: {'url': url});
          },
        ),
      ],
    );
  }
}

/// 菜单列表
class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const menuTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1,
    );
    const menuTextStrutStyle = StrutStyle(
      forceStrutHeight: true,
      fontSize: 14,
      height: 1,
    );
    const menuIconSize = 20.0;

    return BlockSemanticsToDrawerClosed(
      child: GestureDetector(
        onTap: onTap,
        behavior: .opaque,
        child: Padding(
          padding: const .only(left: 10.0, top: 12.0, bottom: 12.0),
          child: Row(
            spacing: 20.0,
            children: [
              Icon(icon, size: menuIconSize, color: Colors.white),
              Text(title, style: menuTextStyle, strutStyle: menuTextStrutStyle),
            ],
          ),
        ),
      ),
    );
  }
}

/// 侧栏关闭状态下就不显示语义
class BlockSemanticsToDrawerClosed extends StatelessWidget {
  const BlockSemanticsToDrawerClosed({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (_, state, child) {
        return BlockSemantics(blocking: state == .closed, child: child);
      },
      child: child,
    );
  }
}
