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
import 'package:moodexample/generated/l10n.dart';

///
import 'package:moodexample/view_models/application/application_view_model.dart';

/// 安全
class SettingKey extends StatelessWidget {
  const SettingKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 安全
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 2.w),
          child: Text(
            S.of(context).app_setting_security,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6.w, top: 6.w, bottom: 14.w),
          child: Text(
            S.of(context).app_setting_security_content,
            style: TextStyle(
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
  const KeyBody({super.key});

  @override
  State<KeyBody> createState() => _KeyBodyState();
}

class _KeyBodyState extends State<KeyBody> {
  static final _titleIconSize = 18.sp;
  List<BiometricType> localAuthList = [];
  IconData? localAuthIcon;
  String localAuthText = '';

  void init(BuildContext context) async {
    final ApplicationViewModel applicationViewModel =
        Provider.of<ApplicationViewModel>(context, listen: false);
    final localAuthUtils = await LocalAuthUtils();
    localAuthList = await localAuthUtils.localAuthList();
    localAuthIcon = localAuthUtils.localAuthIcon(localAuthList);
    localAuthText = localAuthUtils.localAuthText(context, localAuthList);

    /// 获取-安全-生物特征识别是否开启
    await PreferencesDB().getAppKeyBiometric(applicationViewModel);
  }

  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationViewModel>(
      builder: (_, applicationViewModel, child) {
        final String keyPassword = applicationViewModel.keyPassword;
        final bool keyBiometric = applicationViewModel.keyBiometric;

        Widget biometricsAuth = const SizedBox();
        if (keyPassword != '' && localAuthText != '') {
          biometricsAuth = ListTile(
            leading: Icon(
              localAuthIcon,
              size: _titleIconSize,
              color:
                  isDarkMode(context) ? Colors.white : const Color(0xFF202427),
            ),
            title: Text(
              localAuthText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
            ),
            trailing: Semantics(
              label: localAuthText,
              checked: keyBiometric,
              child: CupertinoSwitch(
                value: keyBiometric,
                onChanged: (value) async {
                  applicationViewModel.keyPasswordScreenOpen = false;
                  if (value) {
                    await LocalAuthUtils().localAuthBiometric(context)
                        ? await PreferencesDB()
                            .setAppKeyBiometric(applicationViewModel, value)
                        : null;
                  } else {
                    await PreferencesDB()
                        .setAppKeyBiometric(applicationViewModel, value);
                  }
                },
              ),
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
                S.of(context).app_setting_security_lock,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              trailing: Semantics(
                label: S.of(context).app_setting_security_lock,
                checked: keyPassword != '',
                child: CupertinoSwitch(
                  value: keyPassword != '',
                  onChanged: (value) async {
                    applicationViewModel.keyPasswordScreenOpen = false;
                    if (value) {
                      createlockScreen(
                        context,
                        (password) async {
                          await PreferencesDB().setAppKeyPassword(
                            applicationViewModel,
                            password,
                          );
                        },
                      );
                    } else {
                      await PreferencesDB()
                          .setAppKeyPassword(applicationViewModel, '');
                      await PreferencesDB()
                          .setAppKeyBiometric(applicationViewModel, false);
                    }
                  },
                ),
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
