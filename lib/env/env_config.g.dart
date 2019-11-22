
part of 'env_config.dart';

EnvConfig _$EnvConfigFromJson(Map<String, dynamic> json) {
  return EnvConfig(
    env: json['env'] as String,
    debug: json['debug'] as bool,
  );
}