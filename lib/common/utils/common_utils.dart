import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/localizations/defult_localizations.dart';
import 'package:flutter_github/common/localizations/localizations_delegate.dart';
import 'package:flutter_github/common/style/har_style.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_github/redux/local_redux.dart';
import 'package:flutter_github/redux/theme_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale curLocale;

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }

  static pushTheme(Store store, int index) {
    ThemeData themeData;
    List<Color> colors = getThemeListColor();
    themeData = getThemeData(colors[index]);
    store.dispatch(new RefreshThemeDataAction(themeData));
  }

  static List<Color> getThemeListColor() {
    return [
      HARColors.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  /**
   * 切换语言
   */
  static changeLocale(Store<HARState> store, int index) {
    Locale locale = store.state.platformLocale;
    if (Config.DEBUG) {
      print(store.state.platformLocale);
    }
    switch (index) {
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    curLocale = locale;
    store.dispatch(RefreshLocaleAction(locale));
  }

  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialogWarp(
        context: context,
        builder: (BuildContext context) {
          return new Material(
            color: Colors.transparent,
            child: WillPopScope(
              onWillPop: () =>  Future.value(false),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  padding:  EdgeInsets.all(4.0),
                  decoration:  BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                  child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Container(child: SpinKitCubeGrid(color: Colors.white,),),
                      Container(height: 10,),
                      Container(child: Text(HARLocalization.i18n(context).loading_text,style: HARConstant.normalText,),)
                  ],),
                ),
              ),
            ),
          );
        });
  }

  static Future<T> showDialogWarp<T>(
      {@required BuildContext context,
      bool barrierDismissible = true,
      WidgetBuilder builder}) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .copyWith(textScaleFactor: 1),
            child:  SafeArea(child: builder(context)),
          );
        });
  }
}
