import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_github/common/interceptors/error_interceptor.dart';
import 'package:flutter_github/common/interceptors/header_interceptor.dart';
import 'package:flutter_github/common/interceptors/log_interceptor.dart';
import 'package:flutter_github/common/interceptors/response_interceptor.dart';
import 'package:flutter_github/common/interceptors/token_interceptors.dart';
import 'package:flutter_github/common/net/result_data.dart';

import 'net_code.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = new Dio();

  final TokenInterceptor _tokenInterceptor = new TokenInterceptor();

  HttpManager(){
    _dio.interceptors.add(HeaderInterceptor());

    _dio.interceptors.add(_tokenInterceptor);

    _dio.interceptors.add(LogsInterceptor());

    _dio.interceptors.add(ErrorInterceptor(_dio));

    _dio.interceptors.add(ResponseInterceptor());
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  Future<ResultData> netFetch(
      url, params, Map<String, dynamic> header, Options option,
      {noTip = false}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {//默认get
      option = new Options(method: "get");
      option.headers = headers;
    }

    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = NetCode.NETWORK_TIMEOUT;
      }
      return new ResultData(
          NetCode.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptor.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptor.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();

