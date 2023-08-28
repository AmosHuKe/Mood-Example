import 'dart:convert';

MoodModel moodModelFromJson(String str) => MoodModel.fromJson(json.decode(str));
String moodModelToJson(MoodModel data) => json.encode(data.toJson());

/// 心情详细数据
class MoodModel {
  MoodModel({
    this.moodData,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) => MoodModel(
        moodData: List<MoodData>.from(
          json['data'].map(
            (x) => MoodData.fromJson(x),
          ),
        ),
      );

  final List<MoodData>? moodData;

  Map<String, dynamic> toJson() => {
        'moodData': List<dynamic>.from(
          moodData!.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

MoodData moodDataFromJson(String str) => MoodData.fromJson(json.decode(str));
String moodDataToJson(MoodData data) => json.encode(data.toJson());

/// 心情详细数据
class MoodData {
  MoodData({
    this.moodId,
    this.icon,
    this.title,
    this.score,
    this.content,
    this.createTime,
    this.updateTime,
  });

  factory MoodData.fromJson(Map<String, dynamic> json) => MoodData(
        moodId: json['moodId'],
        icon: json['icon'],
        title: json['title'],
        score: json['score'],
        content: json['content'],
        createTime: json['createTime'],
        updateTime: json['updateTime'],
      );

  // ID
  late int? moodId;
  // 图标
  late String? icon;
  // 标题（当前的心情）
  late String? title;
  // 分数
  late int? score;
  // 内容
  late String? content;
  // 创建日期
  late String? createTime;
  // 修改日期
  late String? updateTime;

  Map<String, dynamic> toJson() => {
        'moodId': moodId,
        'icon': icon,
        'title': title,
        'score': score,
        'content': content,
        'createTime': createTime,
        'updateTime': updateTime,
      };
}
