import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../../../shared/config/language.dart';
import '../../../shared/view_models/application_view_model.dart';

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
        Selector<ApplicationViewModel, bool>(
          selector: (_, applicationViewModel) => applicationViewModel.localeSystem,
          builder: (context, localeSystem, child) {
            final applicationViewModel = context.read<ApplicationViewModel>();
            return RadioGroup(
              groupValue: true,
              onChanged: (_) => applicationViewModel.localeSystem = true,
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
        Selector<ApplicationViewModel, ({Locale locale, bool localeSystem})>(
          selector: (_, applicationViewModel) {
            return (
              locale: applicationViewModel.locale,
              localeSystem: applicationViewModel.localeSystem,
            );
          },
          builder: (context, data, child) {
            return RadioGroup(
              groupValue: !data.localeSystem ? data.locale : null,
              onChanged: (value) {
                final applicationViewModel = context.read<ApplicationViewModel>();
                applicationViewModel.locale = value!;
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
