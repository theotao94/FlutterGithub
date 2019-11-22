import 'package:dio/dio.dart';

/// 头部拦截器
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    ///超时
    options.connectTimeout = 30000;

    return options;
  }
}
