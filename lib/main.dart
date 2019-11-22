import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_github/env/config_wrapper.dart';
import 'package:flutter_github/env/env_config.dart';
import 'package:flutter_github/page/error_page.dart';

import 'app.dart';
import 'env/dev.dart';


void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return ErrorPage(
          details.exception.toString() + "\n " + details.stack.toString());
    };
    runApp(ConfigWrapper(
      child: FlutterReduxApp(),
      config: EnvConfig.fromJson(config),
    ));
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}
