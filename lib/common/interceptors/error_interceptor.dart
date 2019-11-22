import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_github/common/net/net_code.dart';
import 'package:flutter_github/common/net/result_data.dart';

//错误拦截器
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptor(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
//没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new ResultData(
          NetCode.errorHandleFunction(NetCode.NETWORK_ERROR, "", false),
          false,
          NetCode.NETWORK_ERROR));
    }
    return options;
  }
}
