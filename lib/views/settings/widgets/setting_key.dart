import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../../themes/app_theme.dart';
import '../../../widgets/lock_screen/lock_screen.dart';
import '../../../utils/local_auth_utils.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../../shared/view_models/security_key_view_model.dart';

/// 安全
class SettingKey extends StatelessWidget {
  const SettingKey({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 安全
        Padding(
          padding: const .only(left: 6, top: 6, bottom: 2),
          child: Text(
            appL10n.app_setting_security,
            style: const .new(fontWeight: .bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const .only(left: 6, top: 6, bottom: 14),
          child: Text(
            appL10n.app_setting_security_content,
            style: const .new(fontWeight: .normal, fontSize: 14),
          ),
        ),

        const KeyBody(),
        const SizedBox(height: 48),
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
  static const double titleIconSize = 18;
  List<BiometricType> localAuthList = [];
  IconData? localAuthIcon;
  String localAuthText = '';

  Future<void> init(BuildContext context) async {
    final securityKeyViewModel = context.read<SecurityKeyViewModel>();
    final localAuthUtils = await LocalAuthUtils();
    localAuthList = await localAuthUtils.localAuthList();

    setState(() {
      localAuthIcon = LocalAuthUtils.localAuthIcon(localAuthList);
      localAuthText = LocalAuthUtils.localAuthText(context, localAuthList);
    });

    /// 获取-安全-生物特征识别是否开启
    await securityKeyViewModel.loadKeyBiometric();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;
    final appL10n = AppL10n.of(context);
    final localAuthUtils = LocalAuthUtils();

    return Selector<SecurityKeyViewModel, ({String keyPassword, bool keyBiometric})>(
      selector: (_, securityKeyViewModel) {
        return (
          keyPassword: securityKeyViewModel.keyPassword,
          keyBiometric: securityKeyViewModel.keyBiometric,
        );
      },
      builder: (context, data, child) {
        final securityKeyViewModel = context.read<SecurityKeyViewModel>();
        final keyPassword = data.keyPassword;
        final keyBiometric = data.keyBiometric;

        Widget biometricsAuth = const SizedBox();
        if (keyPassword != '' && localAuthText != '') {
          biometricsAuth = ListTile(
            leading: Icon(
              localAuthIcon,
              size: titleIconSize,
              color: isDark ? Colors.white : const Color(0xFF202427),
            ),
            title: Text(
              localAuthText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: .normal, height: 1.0),
            ),
            trailing: Semantics(
              label: localAuthText,
              checked: keyBiometric,
              child: CupertinoSwitch(
                value: keyBiometric,
                onChanged: (value) async {
                  securityKeyViewModel.keyPasswordScreenOpen = false;
                  if (value) {
                    if (await localAuthUtils.localAuthBiometric(context)) {
                      securityKeyViewModel.keyBiometric = value;
                    }
                  } else {
                    securityKeyViewModel.keyBiometric = value;
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
                size: titleIconSize,
                color: isDark ? Colors.white : const Color(0xFF202427),
              ),
              title: Text(
                appL10n.app_setting_security_lock,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14, fontWeight: .normal, height: 1.0),
              ),
              trailing: Semantics(
                label: appL10n.app_setting_security_lock,
                checked: keyPassword != '',
                child: CupertinoSwitch(
                  value: keyPassword != '',
                  onChanged: (value) async {
                    securityKeyViewModel.keyPasswordScreenOpen = false;
                    if (value) {
                      createLockScreen(
                        context,
                        (password) => securityKeyViewModel.keyPassword = password,
                      );
                    } else {
                      securityKeyViewModel.keyPassword = '';
                      securityKeyViewModel.keyBiometric = false;
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
