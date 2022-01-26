import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/app_theme.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

///
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

/// 心情数据
late MoodData _moodData;

/// 心情内容创建页
class MoodContent extends StatefulWidget {
  const MoodContent({
    Key? key,
    required this.moodData,
  }) : super(key: key);

  /// 心情详细数据
  final MoodData moodData;

  @override
  _MoodContentState createState() => _MoodContentState();
}

class _MoodContentState extends State<MoodContent> {
  @override
  void initState() {
    super.initState();

    /// 心情数据
    _moodData = widget.moodData;
    _moodData.score = _moodData.score ?? 50;
  }

  /// 关闭返回
  Function? onClose(BuildContext context) {
    FocusScope.of(context).unfocus();
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("确认关闭？"),
        content: const Text("内容不会保存"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('确认'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕自适应 设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      designSize: const Size(AppTheme.wdp, AppTheme.hdp),
      orientation: Orientation.landscape,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
        ),
        centerTitle: true,
        title: Text(_moodData.createTime ?? ""),
        leading: ActionButton(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.backgroundColor1, AppTheme.backgroundColor1],
              ),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(18.w))),
          child: Icon(
            Remix.close_fill,
            size: 24.sp,
            color: Colors.black87,
          ),
          onTap: () {
            onClose(context);
          },
        ),
        actions: [
          ActionButton(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD6F2E2), Color(0xFFD6F2E2)],
                ),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(18.w))),
            child: Icon(
              Remix.check_fill,
              size: 24.sp,
              color: const Color(0xFF587966),
            ),
            onTap: () async {
              MoodViewModel _moodViewModel =
                  Provider.of<MoodViewModel>(context, listen: false);

              /// 是否操作成功
              late bool _result = false;
              final String _nowDateTime =
                  _moodViewModel.nowDateTime.toString().substring(0, 10);

              /// 存在ID的操作（代表修改）
              if (_moodData.moodId != null) {
                /// 修改心情数据
                /// 赋值修改时间
                _moodData.updateTime =
                    DateTime.now().toString().substring(0, 10);
                print("修改心情数据:${moodDataToJson(_moodData)}");
                _result = await MoodService.editMood(_moodData);
              } else {
                /// 创建心情数据
                print("创建心情数据:${moodDataToJson(_moodData)}");
                _result = await MoodService.addMoodData(_moodData);
              }
              if (_result) {
                /// 获取心情数据
                MoodService.getMoodData(_moodViewModel, _nowDateTime);

                /// 获取所有已记录心情的日期
                MoodService.getMoodRecordedDate(_moodViewModel);

                /// 返回
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            onClose(context);
            return true;
          },
          child: const MoodContentBody(),
        ),
      ),
    );
  }
}

class MoodContentBody extends StatefulWidget {
  const MoodContentBody({Key? key}) : super(key: key);

  @override
  _MoodContentBodyState createState() => _MoodContentBodyState();
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
          padding: EdgeInsets.only(
            top: 24.w,
            left: 24.w,
            right: 24.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Consumer<MoodViewModel>(
                  builder: (_, moodViewModel, child) {
                    /// 心情卡片
                    return MoodChoiceCard(
                      icon: _moodData.icon,
                      title: _moodData.title,
                    );
                  },
                ),
                onTap: () {
                  /// 切换心情
                  Navigator.pushNamed(
                          context,
                          Routes.moodCategorySelect +
                              Routes.transformParams(["edit"]))
                      .then((result) {
                    if (result == null) return;
                    setState(() {
                      MoodCategoryData moodCategoryData =
                          moodCategoryDataFromJson(result.toString());
                      _moodData.icon = moodCategoryData.icon;
                      _moodData.title = moodCategoryData.title;
                    });
                  });
                },
              ),

              /// 打分
              const Align(
                child: MoodScore(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 24.w,
            bottom: 48.w,
            left: 24.w,
            right: 24.w,
          ),
          child: const AddContent(),
        ),
      ],
    );
  }
}

/// 心情选择卡片
class MoodChoiceCard extends StatelessWidget {
  const MoodChoiceCard({
    Key? key,
    this.icon,
    this.title,
  }) : super(key: key);

  /// 图标
  final String? icon;

  /// 标题
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.w,
      height: 128.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
          ),
          borderRadius: BorderRadius.circular(32.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 6.w),
              child: Text(
                icon ?? "",
                style: TextStyle(
                  fontSize: 32.sp,
                ),
              ),
            ),
            Text(
              title ?? "",
              style: TextStyle(
                fontSize: 16.sp,
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
  const AddContent({Key? key}) : super(key: key);

  @override
  _AddContentState createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  /// 内容表单
  final GlobalKey<FormState> _formContentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(32.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.w,
          bottom: 12.w,
          left: 24.w,
          right: 24.w,
        ),
        child: Form(
          key: _formContentKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                key: const Key("content"),
                initialValue: _moodData.content,
                autocorrect: true,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                maxLength: 5000,
                scrollPhysics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                decoration: const InputDecoration(
                  hintText: '跟我说说，发生什么事情？',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _moodData.content = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 心情程度
class MoodScore extends StatefulWidget {
  const MoodScore({Key? key}) : super(key: key);

  @override
  _MoodScoreState createState() => _MoodScoreState();
}

class _MoodScoreState extends State<MoodScore> {
  @override
  Widget build(BuildContext context) {
    /// 心情分数
    double _moodScore =
        _moodData.score != null ? double.parse(_moodData.score.toString()) : 50;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 12.w,
            left: 24.w,
            right: 24.w,
          ),
          child: Text(
            "心情程度",
            style: TextStyle(
              fontSize: 16.w,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 12.w,
            left: 24.w,
            right: 24.w,
          ),
          child: Text(
            (_moodScore ~/ 1).toString(),
            style: TextStyle(
              fontSize: 24.w,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Slider(
          value: _moodScore,
          min: 0.0,
          max: 100.0,
          activeColor: AppTheme.primaryColor,
          thumbColor: AppTheme.primaryColor,
          onChanged: (val) {
            setState(() {
              _moodScore = val;
            });

            /// 赋值分数
            _moodData.score = val ~/ 1;
          },
        ),
      ],
    );
  }
}
