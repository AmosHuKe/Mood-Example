import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///
import 'package:moodexample/db/preferences_db.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 语言设置
class SettingLanguage extends StatefulWidget {
  const SettingLanguage({Key? key}) : super(key: key);

  @override
  _SettingLanguageState createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  /// 语言列表
  static const languageList = [
    {
      "language": "简体中文",
      "locale": Locale('zh', 'CN'),
    },
    {
      "language": "繁體中文（台灣）",
      "locale": Locale('zh', 'TW'),
    },
    {
      "language": "繁體中文（香港）",
      "locale": Locale('zh', 'HK'),
    },
    {
      "language": "English",
      "locale": Locale('en'),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 跟随系统
        Selector<ApplicationViewModel, bool>(
          selector: (_, applicationViewModel) =>
              applicationViewModel.localeSystem,
          builder: (_, localeSystem, child) {
            return RadioListTile(
              value: localeSystem,
              groupValue: true,
              title: Text(
                "跟随系统",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              onChanged: (value) async {
                print("跟随系统");
                await PreferencesDB().setAppIsLocaleSystem(context, true);
              },
            );
          },
        ),

        /// 语言
        Consumer<ApplicationViewModel>(
          builder: (_, applicationViewModel, child) {
            return Column(
              children: List<Widget>.generate(languageList.length, (index) {
                return RadioListTile(
                  value: languageList[index]["locale"].toString(),
                  groupValue: !applicationViewModel.localeSystem
                      ? applicationViewModel.locale.toString()
                      : false,
                  title: Text(
                    languageList[index]["language"].toString(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.normal),
                  ),
                  onChanged: (value) async {
                    print(
                        "语言切换为:" + languageList[index]["language"].toString());
                    await PreferencesDB()
                        .setAppLocale(context, value.toString());
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
