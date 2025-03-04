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

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        /// 跟随系统
        Selector<ApplicationViewModel, bool>(
          selector: (_, applicationViewModel) => applicationViewModel.localeSystem,
          builder: (context, localeSystem, child) {
            final applicationViewModel = context.read<ApplicationViewModel>();
            return RadioListTile<bool>(
              value: localeSystem,
              groupValue: true,
              title: Text(
                appL10n.app_setting_language_system,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              onChanged: (_) => applicationViewModel.localeSystem = true,
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
            return Column(
              children: List<Widget>.generate(languageList.length, (index) {
                return RadioListTile<Locale>(
                  value: languageList[index].locale,
                  groupValue: !data.localeSystem ? data.locale : null,
                  title: Text(
                    languageList[index].title,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  onChanged: (value) {
                    final applicationViewModel = context.read<ApplicationViewModel>();
                    applicationViewModel.locale = value!;
                  },
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
