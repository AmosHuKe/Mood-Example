import 'package:flutter/material.dart';

/// 语言数据
@immutable
class LanguageData {
  const LanguageData(
    this.language,
    this.locale,
  );

  // 语言名称
  final String language;
  // Locale
  final Locale locale;
}
