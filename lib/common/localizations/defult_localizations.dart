import 'package:flutter/material.dart';
import 'package:flutter_github/common/localizations/string_base.dart';
import 'package:flutter_github/common/localizations/string_en.dart';
import 'package:flutter_github/common/localizations/string_zh.dart';

class HARLocalization{
  final Locale locale;

  HARLocalization(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, StringBase> _localizedValues = {
    'en': new StringEn(),
    'zh': new StringZh(),
  };

  StringBase get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static HARLocalization of(BuildContext context) {
    return Localizations.of(context, HARLocalization);
  }


  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static StringBase i18n(BuildContext context) {
    return (Localizations.of(context, HARLocalization) as HARLocalization)
        .currentLocalized;
  }
}