import 'package:dio/dio.dart';
import 'package:flutter_github/common/net/net_code.dart';
import 'package:flutter_github/common/net/result_data.dart';

///响应拦截器
class ResponseInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        //响应中是纯文本的处理
        value = new ResultData(response.data, true, NetCode.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new ResultData(response.data, true, NetCode.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return value;
  }
}
