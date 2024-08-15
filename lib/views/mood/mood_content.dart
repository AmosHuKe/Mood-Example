import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/common/utils_intl.dart';

import 'package:moodexample/widgets/action_button/action_button.dart';
import 'package:moodexample/widgets/animation/animation.dart';

import 'package:moodexample/views/mood/mood_category_select.dart'
    show MoodCategorySelectType;

import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/providers/mood/mood_provider.dart';

/// 心情数据
late MoodData _moodData;

/// 心情内容创建页
class MoodContent extends StatefulWidget {
  const MoodContent({
    super.key,
    required this.moodData,
  });

  /// 心情详细数据
  final MoodData moodData;

  @override
  State<MoodContent> createState() => _MoodContentState();
}

class _MoodContentState extends State<MoodContent> {
  @override
  void initState() {
    super.initState();

    /// 心情数据
    _moodData = widget.moodData;
    _moodData.score = _moodData.score ?? 50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.displayLarge!.color,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          LocaleDatetime.yMMMd(context, _moodData.createTime ?? ''),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        leading: ActionButton(
          key: const Key('widget_action_button_close'),
          semanticsLabel: '关闭',
          decoration: BoxDecoration(
            color: isDarkMode(context)
                ? Theme.of(context).cardColor
                : AppTheme.backgroundColor1,
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(18)),
          ),
          child: const Icon(
            Remix.close_fill,
            size: 24,
          ),
          onTap: () {
            onClose(context);
          },
        ),
        actions: [
          ActionButton(
            key: const Key('widget_mood_actions_button'),
            semanticsLabel: '确认记录',
            decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? Theme.of(context).cardColor
                  : const Color(0xFFD6F2E2),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(18)),
            ),
            child: Icon(
              Remix.check_fill,
              size: 24,
              color: isDarkMode(context)
                  ? Theme.of(context).textTheme.displayLarge!.color
                  : const Color(0xFF587966),
            ),
            onTap: () async {
              FocusScope.of(context).unfocus();
              final MoodProvider moodProvider = context.read<MoodProvider>();

              /// 是否操作成功
              late bool result = false;

              /// 存在ID的操作（代表修改）
              if (_moodData.moodId != null) {
                /// 修改心情数据
                /// 赋值修改时间
                _moodData.updateTime =
                    DateTime.now().toString().substring(0, 10);
                result = await moodProvider.editMoodData(_moodData);
              } else {
                /// 创建心情数据
                result = await moodProvider.addMoodData(_moodData);
              }
              if (result) {
                /// 获取心情数据
                moodProvider.loadMoodDataList();

                /// 获取所有已记录心情的日期
                moodProvider.loadMoodRecordDateAllList();

                if (!mounted) return;

                /// 返回
                context.pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, _) {
            if (didPop) return;
            onClose(context);
          },
          child: const MoodContentBody(),
        ),
      ),
    );
  }

  /// 关闭返回
  Function? onClose(BuildContext context) {
    FocusScope.of(context).unfocus();
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => Theme(
        data: isDarkMode(context) ? ThemeData.dark() : ThemeData.light(),
        child: CupertinoAlertDialog(
          title: Text(S.of(context).mood_content_close_button_title),
          content: Text(S.of(context).mood_content_close_button_content),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: Text(S.of(context).mood_content_close_button_cancel),
              onPressed: () {
                context.pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(S.of(context).mood_content_close_button_confirm),
              onPressed: () {
                context.pop();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
    return null;
  }
}

class MoodContentBody extends StatefulWidget {
  const MoodContentBody({super.key});

  @override
  State<MoodContentBody> createState() => _MoodContentBodyState();
}

class _MoodContentBodyState extends State<MoodContentBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Consumer<MoodProvider>(
                  builder: (_, moodProvider, child) {
                    /// 心情卡片
                    return Semantics(
                      button: true,
                      label: '当前选择心情：${_moodData.title}，再次选择换一种心情',
                      excludeSemantics: true,
                      child: MoodChoiceCard(
                        icon: _moodData.icon,
                        title: _moodData.title,
                      ),
                    );
                  },
                ),
                onTap: () {
                  /// 切换心情
                  GoRouter.of(context).pushNamed(
                    Routes.moodCategorySelect,
                    pathParameters: {'type': MoodCategorySelectType.edit.type},
                  ).then((result) {
                    if (result == null) return;
                    final MoodCategoryData moodCategoryData =
                        moodCategoryDataFromJson(result.toString());
                    setState(() {
                      _moodData.icon = moodCategoryData.icon;
                      _moodData.title = moodCategoryData.title;
                    });
                  });
                },
              ),

              /// 打分
              const Expanded(
                child: Align(
                  child: MoodScore(),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 24,
            bottom: 48,
            left: 24,
            right: 24,
          ),
          child: AddContent(),
        ),
      ],
    );
  }
}

/// 心情选择卡片
class MoodChoiceCard extends StatelessWidget {
  const MoodChoiceCard({
    super.key,
    this.icon,
    this.title,
  });

  /// 图标
  final String? icon;

  /// 标题
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      child: Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          color: isDarkMode(context) ? const Color(0xFF202427) : Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                icon ?? '',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            Text(
              title ?? '',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 内容输入
class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  /// 内容表单
  final GlobalKey<FormState> _formContentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Form(
        key: _formContentKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: const Key('content'),
              initialValue: _moodData.content,
              autocorrect: true,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              maxLength: 5000,
              scrollPhysics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
              decoration: InputDecoration(
                hintText: S.of(context).mood_content_hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
                border: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              buildCounter: (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) {
                return Text(
                  '$currentLength/$maxLength',
                  style: const TextStyle(fontSize: 12),
                );
              },
              onChanged: (value) {
                _moodData.content = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 心情程度
class MoodScore extends StatefulWidget {
  const MoodScore({super.key});

  @override
  State<MoodScore> createState() => _MoodScoreState();
}

class _MoodScoreState extends State<MoodScore> {
  /// 心情分数
  double moodScore =
      _moodData.score != null ? double.parse(_moodData.score.toString()) : 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
          child: Text(
            S.of(context).mood_data_score_title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
          child: Text(
            (moodScore ~/ 1).toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Slider(
          value: moodScore,
          label: '心情程度调整',
          min: 0.0,
          max: 100.0,
          activeColor: Theme.of(context).primaryColor,
          thumbColor: Theme.of(context).primaryColor,
          semanticFormatterCallback: (value) => '当前心情程度：${value ~/ 1}',
          onChanged: (value) {
            setState(() {
              moodScore = value;
            });

            /// 赋值分数
            _moodData.score = value ~/ 1;
          },
        ),
      ],
    );
  }
}
