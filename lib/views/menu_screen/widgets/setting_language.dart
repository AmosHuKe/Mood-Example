import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'package:moodexample/config/language.dart';

import 'package:moodexample/providers/application/application_provider.dart';

/// 语言设置
class SettingLanguage extends StatelessWidget {
  const SettingLanguage({super.key});

  /// 语言列表
  static const _languageConfig = languageConfig;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 跟随系统
        Selector<ApplicationProvider, bool>(
          selector: (_, applicationProvider) =>
              applicationProvider.localeSystem,
          builder: (_, localeSystem, child) {
            final ApplicationProvider applicationProvider =
                context.read<ApplicationProvider>();
            return RadioListTile<bool>(
              value: localeSystem,
              groupValue: true,
              title: Text(
                S.of(context).app_setting_language_system,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              onChanged: (_) => applicationProvider.localeSystem = true,
            );
          },
        ),

        /// 语言
        Consumer<ApplicationProvider>(
          builder: (_, applicationProvider, child) {
            return Column(
              children: List<Widget>.generate(_languageConfig.length, (index) {
                return RadioListTile<Locale>(
                  value: _languageConfig[index].locale,
                  groupValue: !applicationProvider.localeSystem
                      ? applicationProvider.locale
                      : null,
                  title: Text(
                    _languageConfig[index].language,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
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
