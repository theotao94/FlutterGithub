import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github/common/event/http_error_event.dart';
import 'package:flutter_github/common/event/index.dart';
import 'package:flutter_github/common/localizations/defult_localizations.dart';
import 'package:flutter_github/common/localizations/localizations_delegate.dart';
import 'package:flutter_github/common/net/net_code.dart';
import 'package:flutter_github/common/style/har_style.dart';
import 'package:flutter_github/model/User.dart';
import 'package:flutter_github/page/home/home_page.dart';
import 'package:flutter_github/page/net_test.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

import 'common/utils/common_utils.dart';

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> with HttpErrorListener{

  final store =new Store<HARState>(
    appReducer,

    ///拦截器
    middleware: middleware,
    ///初始化数据
    initialState: new HARState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeData(HARColors.primarySwatch),
        locale: Locale('zh', 'CH')
        ),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<HARState>(builder: (context,state){
        ///使用 StoreBuilder 获取 store 中的 theme 、locale
        store.state.platformLocale = WidgetsBinding.instance.window.locale;
        return MaterialApp(
          ///多语言实现代理
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            HARLocalizationsDelegate.delegate,
          ],
          supportedLocales: [store.state.locale],
          locale: store.state.locale,
          theme: store.state.themeData,
          routes: {
            "/":(context){
              return HomePage();
            }
          },
        );
      }),
    );
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription stream;

  ///这里为什么用 _context 你理解吗？
  ///因为此时 State 的 context 是 FlutterReduxApp 而不是 MaterialApp
  ///所以如果直接用 context 是会获取不到 MaterialApp 的 Localizations 哦。
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case NetCode.NETWORK_ERROR:
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error);
        break;
      case 401:
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error_401);
        break;
      case 403:
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error_403);
        break;
      case 404:
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error_404);
        break;
      case NetCode.NETWORK_TIMEOUT:
      //超时
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error_timeout);
        break;
      default:
        Fluttertoast.showToast(
            msg: HARLocalization.i18n(_context).network_error_unknown +
                " " +
                message);
        break;
    }
  }
}
