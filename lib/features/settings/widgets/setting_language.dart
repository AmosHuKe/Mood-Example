import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../../../shared/config/language.dart';
import '../../../shared/providers/application_provider.dart';

/// 语言设置
class SettingLanguage extends StatelessWidget {
  const SettingLanguage({super.key});

  /// 语言列表
  List<Language> get languageList => Language.values;

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);
    final theme = Theme.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        /// 跟随系统
        Selector<ApplicationProvider, bool>(
          selector: (_, applicationProvider) => applicationProvider.localeSystem,
          builder: (context, localeSystem, child) {
            final applicationProvider = context.read<ApplicationProvider>();
            return RadioGroup(
              groupValue: true,
              onChanged: (_) => applicationProvider.localeSystem = true,
              child: RadioListTile<bool>(
                value: localeSystem,
                title: Text(
                  appL10n.app_setting_language_system,
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: .normal),
                ),
              ),
            );
          },
        ),

        /// 语言
        Selector<ApplicationProvider, ({Locale locale, bool localeSystem})>(
          selector: (_, applicationProvider) {
            return (
              locale: applicationProvider.locale,
              localeSystem: applicationProvider.localeSystem,
            );
          },
          builder: (context, data, child) {
            return RadioGroup(
              groupValue: !data.localeSystem ? data.locale : null,
              onChanged: (value) {
                final applicationProvider = context.read<ApplicationProvider>();
                applicationProvider.locale = value!;
              },
              child: Column(
                children: List<Widget>.generate(languageList.length, (index) {
                  return RadioListTile<Locale>(
                    value: languageList[index].locale,
                    title: Text(
                      languageList[index].title,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: .normal,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}
