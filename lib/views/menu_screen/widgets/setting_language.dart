import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/app_theme.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            "语言",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),

        /// 测试
        InkWell(
          child: const Text("跟随系统"),
          onTap: () {
            print("跟随系统");
            Provider.of<ApplicationViewModel>(context, listen: false)
                .setLocaleSystem(true);
          },
        ),
        InkWell(
          child: const Text("简体中文"),
          onTap: () {
            print("简体中文");
            Provider.of<ApplicationViewModel>(context, listen: false)
                .setLocale(const Locale('zh', 'CN'));
          },
        ),
        InkWell(
          child: const Text("English"),
          onTap: () {
            print("English");
            Provider.of<ApplicationViewModel>(context, listen: false)
                .setLocale(const Locale('en'));
          },
        ),
      ],
    );
  }
}
