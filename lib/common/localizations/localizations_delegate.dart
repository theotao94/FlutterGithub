import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github/common/localizations/defult_localizations.dart';

class HARLocalizationsDelegate extends LocalizationsDelegate<HARLocalization> {
  HARLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  @override
  Future<HARLocalization> load(Locale locale) {
    return new SynchronousFuture<HARLocalization>(new HARLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<HARLocalization> old) {
    return false;
  }

  ///全局静态的代理
  static HARLocalizationsDelegate delegate = new HARLocalizationsDelegate();
}