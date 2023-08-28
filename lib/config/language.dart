import 'package:flutter/material.dart';

import 'package:moodexample/models/config/language_model.dart';

/// 语言配置
const List<LanguageData> languageConfig = [
  LanguageData('简体中文', Locale('zh', 'CN')),
  LanguageData('繁體中文（台灣）', Locale('zh', 'TW')),
  LanguageData('繁體中文（香港）', Locale('zh', 'HK')),
  LanguageData('English', Locale('en')),
];
