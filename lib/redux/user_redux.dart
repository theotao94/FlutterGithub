


import 'package:flutter_github/common/dao/user_dao.dart';
import 'package:flutter_github/model/User.dart';
import 'package:flutter_github/redux/har_state.dart';
import 'package:flutter_github/redux/middleware/epic.dart';
import 'package:flutter_github/redux/middleware/epic_store.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';





/**
 * 用户相关Redux
 */

/// redux 的 combineReducers, 通过 TypedReducer 将 UpdateUserAction 与 reducers 关联起来
final UserReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserAction>(_updateLoaded),
]);

/// 如果有 UpdateUserAction 发起一个请求时
/// 就会调用到 _updateLoaded
/// _updateLoaded 这里接受一个新的userInfo，并返回
User _updateLoaded(User user, action) {
  print("*********** this is reducer updateLoaded exec*********** ");
  user = action.userInfo;
  return user;
}

class UpdateUserAction {
  final User userInfo;

  UpdateUserAction(this.userInfo);
}

class FetchUserAction {
}
class UserInfoMiddleware extends MiddlewareClass<HARState>{

  @override
  void call(Store<HARState> store, dynamic action, NextDispatcher next) {
    if (action is UpdateUserAction) {
      print("*********** UserInfoMiddleware *********** ");
    }
    // Make sure to forward actions to the next middleware in the chain!
    next(action);
  }
}

class UserInfoEpic extends EpicClass<HARState>{
  @override
  Stream call(Stream actions, EpicStore<HARState> store) {
    return Observable(actions)
    // to UpdateUserAction actions
        .whereType<FetchUserAction>()
    // Don't start  until the 10ms
        .debounce(((_) => TimerStream(true, const Duration(milliseconds: 10))))
        .switchMap((action) => _loadUserInfo());;
  }

  // Use the async* function to make easier
  Stream<dynamic> _loadUserInfo() async* {
    print("*********** userInfoEpic _loadUserInfo ***********");
    var res = await UserDao.getUserInfo(null);
    yield UpdateUserAction(res.data);
  }

}