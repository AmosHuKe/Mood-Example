import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:moodexample/config/language.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';

import 'package:moodexample/providers/application/application_provider.dart';

/// 语言设置
class SettingLanguage extends StatelessWidget {
  const SettingLanguage({super.key});

  /// 语言列表
  List<Language> get languageList => Language.values;

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        /// 跟随系统
        Selector<ApplicationProvider, bool>(
          selector: (_, applicationProvider) => applicationProvider.localeSystem,
          builder: (_, localeSystem, child) {
            final applicationProvider = context.read<ApplicationProvider>();
            return RadioListTile<bool>(
              value: localeSystem,
              groupValue: true,
              title: Text(
                appL10n.app_setting_language_system,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              onChanged: (_) => applicationProvider.localeSystem = true,
            );
          },
        ),

        /// 语言
        Consumer<ApplicationProvider>(
          builder: (_, applicationProvider, child) {
            return Column(
              children: List<Widget>.generate(languageList.length, (index) {
                return RadioListTile<Locale>(
                  value: languageList[index].locale,
                  groupValue: !applicationProvider.localeSystem ? applicationProvider.locale : null,
                  title: Text(
                    languageList[index].title,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  onChanged: (value) => applicationProvider.locale = value!,
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
