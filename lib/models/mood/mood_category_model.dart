import 'dart:convert';

MoodCategoryModel moodCategoryModelFromJson(String str) =>
    MoodCategoryModel.fromJson(json.decode(str));
String moodCategoryModelToJson(MoodCategoryModel data) =>
    json.encode(data.toJson());

/// 心情类别数据
class MoodCategoryModel {
  MoodCategoryModel({
    this.moodCategoryData,
  });

  final List<MoodCategoryData>? moodCategoryData;

  factory MoodCategoryModel.fromJson(Map<String, dynamic> json) =>
      MoodCategoryModel(
        moodCategoryData: List<MoodCategoryData>.from(
          json["data"].map(
            (x) => MoodCategoryData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "moodCategoryData": List<dynamic>.from(
          moodCategoryData!.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

MoodCategoryData moodCategoryDataFromJson(String str) =>
    MoodCategoryData.fromJson(json.decode(str));
String moodCategoryDataToJson(MoodCategoryData data) =>
    json.encode(data.toJson());

/// 心情类别数据
class MoodCategoryData {
  MoodCategoryData({
    this.icon,
    this.title,
  });

  /// 表情
  late String? icon;

  /// 标题
  late String? title;

  factory MoodCategoryData.fromJson(Map<String, dynamic> json) =>
      MoodCategoryData(
        icon: json["icon"],
        title: json["title"],
      );

  get length => null;

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
      };
}
