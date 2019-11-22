//全局状态
import 'package:flutter/material.dart';
import 'package:flutter_github/model/User.dart';
import 'package:flutter_github/redux/local_redux.dart';
import 'package:flutter_github/redux/login_redux.dart';
import 'package:flutter_github/redux/middleware/epic_middleware.dart';
import 'package:flutter_github/redux/theme_redux.dart';
import 'package:flutter_github/redux/user_redux.dart';
import 'package:redux/redux.dart';

class HARState{

  ///用户信息
  User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///是否登录
  bool login;

  HARState({this.userInfo, this.themeData, this.locale, this.login});

}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
HARState appReducer(HARState state, action) {
  return HARState(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

    ///通过 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
    locale: LocaleReducer(state.locale, action),
    login: LoginReducer(state.login, action),
  );
}
final List<Middleware<HARState>> middleware = [
  EpicMiddleware<HARState>(UserInfoEpic()),
  EpicMiddleware<HARState>(LoginEpic()),
  UserInfoMiddleware(),
  LoginMiddleware(),
];