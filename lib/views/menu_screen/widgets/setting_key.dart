import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/lock_screen/lock_screen.dart';
import 'package:moodexample/common/local_auth_utils.dart';
import 'package:moodexample/db/preferences_db.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 安全
class SettingKey extends StatefulWidget {
  const SettingKey({Key? key}) : super(key: key);

  @override
  State<SettingKey> createState() => _SettingKeyState();
}

class _SettingKeyState extends State<SettingKey> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 安全
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 2.w),
          child: Text(
            "安全设置",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            "重新打开应用时需要进行解锁。",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                ),
          ),
        ),

        const KeyBody(),
        SizedBox(height: 48.w),
      ],
    );
  }
}

/// 安全设置
class KeyBody extends StatefulWidget {
  const KeyBody({Key? key}) : super(key: key);

  @override
  State<KeyBody> createState() => _KeyBodyState();
}

class _KeyBodyState extends State<KeyBody> {
  static final _titleIconSize = 20.sp;
  List<BiometricType> localAuthList = [];
  IconData? localAuthIcon;

  void init() async {
    ApplicationViewModel applicationViewModel =
        Provider.of<ApplicationViewModel>(context, listen: false);
    localAuthList = await LocalAuthUtils().localAuthList();
    localAuthIcon = await LocalAuthUtils().localAuthIcon();

    /// 获取-安全-生物特征识别是否开启
    await PreferencesDB().getAppKeyBiometric(applicationViewModel);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final String keyPassword = applicationViewModel.keyPassword;
        final bool keyBiometric = applicationViewModel.keyBiometric;

        /// 生物识别处理
        String authText = "";
        localAuthList.contains(BiometricType.weak)
            ? authText = "指纹、面部等识别"
            : null;
        localAuthList.contains(BiometricType.iris) ? authText = "虹膜识别" : null;
        localAuthList.contains(BiometricType.face) ? authText = "面部识别" : null;
        localAuthList.contains(BiometricType.fingerprint)
            ? authText = "指纹识别"
            : null;

        Widget biometricsAuth = const SizedBox();
        if (keyPassword != "" && authText != "") {
          biometricsAuth = ListTile(
            leading: Icon(
              localAuthIcon,
              size: _titleIconSize,
              color:
                  isDarkMode(context) ? Colors.white : const Color(0xFF202427),
            ),
            title: Text(
              authText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
            ),
            trailing: CupertinoSwitch(
              value: keyBiometric,
              onChanged: (value) async {
                applicationViewModel.setKeyPasswordScreenOpen(false);
                if (value) {
                  await LocalAuthUtils().localAuthBiometric()
                      ? await PreferencesDB()
                          .setAppKeyBiometric(applicationViewModel, value)
                      : null;
                } else {
                  await PreferencesDB()
                      .setAppKeyBiometric(applicationViewModel, value);
                }
              },
            ),
          );
        }

        return Column(
          children: [
            /// 密码设置
            ListTile(
              leading: Icon(
                Remix.lock_line,
                size: _titleIconSize,
                color: isDarkMode(context)
                    ? Colors.white
                    : const Color(0xFF202427),
              ),
              title: Text(
                "密码",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              trailing: CupertinoSwitch(
                value: keyPassword != "",
                onChanged: (value) async {
                  applicationViewModel.setKeyPasswordScreenOpen(false);
                  if (value) {
                    createlockScreen(
                      context,
                      (password) async {
                        await PreferencesDB()
                            .setAppKeyPassword(applicationViewModel, password);
                      },
                    );
                  } else {
                    await PreferencesDB()
                        .setAppKeyPassword(applicationViewModel, "");
                    await PreferencesDB()
                        .setAppKeyBiometric(applicationViewModel, false);
                  }
                },
              ),
            ),

            /// 生物特征识别
            biometricsAuth,
          ],
        );
      },
    );
  }
}
