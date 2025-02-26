import 'dart:ui';

/// 多语言
enum Language {
  zhCN(title: '简体中文', locale: Locale('zh', 'CN')),
  zhTW(title: '繁體中文（台灣）', locale: Locale('zh', 'TW')),
  zhHK(title: '繁體中文（香港）', locale: Locale('zh', 'HK')),
  en(title: 'English', locale: Locale('en'));

  const Language({required this.title, required this.locale});

  final String title;
  final Locale locale;

  static Language fromString(String language) =>
      values.firstWhere((e) => e.name == language, orElse: () => zhCN);
}
