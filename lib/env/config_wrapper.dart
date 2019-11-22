import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';

import 'env_config.dart';

class ConfigWrapper extends StatelessWidget {
  final EnvConfig config;

  final Widget child;

  ConfigWrapper({Key key, this.config, this.child});

  @override
  Widget build(BuildContext context) {
    Config.DEBUG = this.config.debug;
    print("ConfigWrapper build ${Config.DEBUG}");
    return new _InheritedConfig(config: this.config, child: this.child);
  }

  static EnvConfig of(BuildContext context) {
    final _InheritedConfig inheritedConfig =
        context.inheritFromWidgetOfExactType(_InheritedConfig);
    return inheritedConfig.config;
  }
}

class _InheritedConfig extends InheritedWidget {
  const _InheritedConfig(
      {Key key, @required this.config, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  final EnvConfig config;

  @override
  bool updateShouldNotify(_InheritedConfig oldWidget) =>
      //刷新条件有config是否修改来配置
      config != oldWidget.config;
}
