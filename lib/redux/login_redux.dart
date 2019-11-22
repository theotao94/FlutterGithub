import 'package:flutter/material.dart';
import 'package:flutter_github/common/dao/user_dao.dart';
import 'package:flutter_github/common/utils/common_utils.dart';
import 'package:flutter_github/common/utils/navigator_utils.dart';
import 'package:flutter_github/db/sql_manager.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_github/redux/middleware/epic.dart';
import 'package:flutter_github/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';

/**
 * 登录相关Redux
 */
final LoginReducer = combineReducers<bool>([
  TypedReducer<bool, LoginSuccessAction>(_loginResult),
  TypedReducer<bool, LogoutAction>(_logoutResult),
]);

bool _loginResult(bool result, LoginSuccessAction action) {
  if (action.success == true) {
    NavigatorUtils.goHome(action.context);
  }
  return action.success;
}

bool _logoutResult(bool result, LogoutAction action) {
  return true;
}

//reducer 使用的状态
class LoginSuccessAction {
  final BuildContext context;
  final bool success;

  LoginSuccessAction(this.context, this.success);
}
//reducer 使用的状态
class LogoutAction {
  final BuildContext context;

  LogoutAction(this.context);
}

//EPIC 使用的状态
class LoginAction {
  final BuildContext context;
  final String username;
  final String password;

  LoginAction(this.context, this.username, this.password);
}

class LoginMiddleware implements MiddlewareClass<HARState> {
  @override
  void call(Store<HARState> store, dynamic action, NextDispatcher next) {
    if (action is LogoutAction) {
      UserDao.clearAll(store);
      SqlManager.close();
      NavigatorUtils.goLogin(action.context);
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}

class LoginEpic implements EpicClass<HARState> {
  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<HARState> store) {
    return Observable(actions)
        .whereType<LoginAction>()
        .switchMap((action) => _loginIn(action, store));
  }

  Stream<dynamic> _loginIn(
      LoginAction action, EpicStore<HARState> store) async* {
    CommonUtils.showLoadingDialog(action.context);
    var res = await UserDao.login(
        action.username.trim(), action.password.trim(), store);
    Navigator.pop(action.context);
    yield LoginSuccessAction(action.context, (res != null && res.result));
  }
}