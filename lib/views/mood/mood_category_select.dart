import 'package:flutter/material.dart';

/// Packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/app_theme.dart';
import 'package:moodexample/common/utils_intl.dart';
import 'package:moodexample/generated/l10n.dart';
import 'package:moodexample/routes.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

///
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';

/// 状态
late String _type;

/// 当前选择的时间
late String _nowDateTime;

/// 新增心情页
class MoodCategorySelect extends StatefulWidget {
  const MoodCategorySelect({
    Key? key,
    required this.type,
  }) : super(key: key);

  /// 状态 add:新增 edit:修改
  final String type;

  @override
  _MoodCategorySelectState createState() => _MoodCategorySelectState();
}

class _MoodCategorySelectState extends State<MoodCategorySelect> {
  @override
  void initState() {
    super.initState();
    MoodViewModel _moodViewModel =
        Provider.of<MoodViewModel>(context, listen: false);

    /// 状态
    _type = widget.type;

    /// 当前选择的时间
    _nowDateTime = _moodViewModel.nowDateTime.toString().substring(0, 10);

    /// 获取所有心情类别
    MoodService.getMoodCategoryAll(_moodViewModel);
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
        foregroundColor: Theme.of(context).textTheme.headline1!.color,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
        ),
        leading: ActionButton(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode(context)
                    ? [Theme.of(context).cardColor, Theme.of(context).cardColor]
                    : [AppTheme.backgroundColor1, AppTheme.backgroundColor1],
              ),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(18.w))),
          child: Icon(
            Remix.arrow_left_line,
            size: 24.sp,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const SafeArea(
        child: MoodCategorySelectBody(),
      ),
    );
  }
}

class MoodCategorySelectBody extends StatefulWidget {
  const MoodCategorySelectBody({Key? key}) : super(key: key);

  @override
  _MoodCategorySelectBodyState createState() => _MoodCategorySelectBodyState();
}

class _MoodCategorySelectBodyState extends State<MoodCategorySelectBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        /// 标题
        Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.w,
            bottom: 48.w,
          ),
          child: Column(
            children: [
              Text(
                _type == "edit"
                    ? S.of(context).mood_category_select_title_2
                    : S.of(context).mood_category_select_title_1,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: Text(
                  _type == "edit" ? "" : LocaleDatetime().yMMMd(_nowDateTime),
                  style: TextStyle(
                    color: AppTheme.subColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// 心情选项
        const MoodChoice(),
      ],
    );
  }
}

/// 心情选择
class MoodChoice extends StatelessWidget {
  const MoodChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 48.w),
        child: Consumer<MoodViewModel>(
          builder: (_, moodViewModel, child) {
            MoodViewModel _moodViewModel = moodViewModel;
            List<Widget> widgetList = [];
            for (var list in _moodViewModel.moodCategoryList ?? []) {
              /// 获取所有心情类别
              _moodViewModel.setMoodCategoryData(list);
              MoodCategoryData _moodCategoryData =
                  _moodViewModel.moodCategoryData;

              widgetList.add(
                MoodChoiceCard(
                  icon: _moodCategoryData.icon ?? "",
                  title: _moodCategoryData.title ?? "",
                ),
              );
            }

            /// 显示
            return Wrap(
              spacing: 24.w,
              runSpacing: 24.w,
              children: widgetList,
            );
          },
        ),
      ),
    );
  }
}

/// 心情选择卡片
class MoodChoiceCard extends StatelessWidget {
  const MoodChoiceCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  /// 图标
  final String icon;

  /// 标题
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 128.w,
        height: 128.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).cardColor,
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
                  icon,
                  style: TextStyle(
                    fontSize: 32.sp,
                  ),
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        switch (_type) {
          case "add":
            // 关闭当前页并跳转输入内容页
            MoodData _moodData = MoodData();
            _moodData.icon = icon;
            _moodData.title = title;
            _moodData.createTime = _nowDateTime;
            _moodData.updateTime = _nowDateTime;
            // 跳转输入内容页
            Navigator.popAndPushNamed(
                context,
                Routes.moodContent +
                    Routes.transformParams([moodDataToJson(_moodData)]));
            break;
          case "edit":
            // 关闭当前页并返回数据
            MoodCategoryData _moodCategoryData = MoodCategoryData();
            _moodCategoryData.icon = icon;
            _moodCategoryData.title = title;
            Navigator.pop(context, moodCategoryDataToJson(_moodCategoryData));
            break;
        }
      },
    );
  }
}
