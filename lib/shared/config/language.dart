import 'dart:ui';

/// 多语言
enum Language {
  zhCN(title: '简体中文', locale: .new('zh', 'CN')),
  zhTW(title: '繁體中文（台灣）', locale: .new('zh', 'TW')),
  zhHK(title: '繁體中文（香港）', locale: .new('zh', 'HK')),
  en(title: 'English', locale: .new('en'));

  const Language({required this.title, required this.locale});

  final String title;
  final Locale locale;

  static Language fromString(String language) =>
      values.firstWhere((e) => e.name == language, orElse: () => zhCN);
}
