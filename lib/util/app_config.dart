
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {

  static AppConfig _instance;

  AppConfig._({this.dbPassword, this.triviaApiUrl});

  static AppConfig get getInstance => _instance = _instance ?? AppConfig._();

  final String dbPassword;

  final String triviaApiUrl;

  //static bool get isProduction => bool.fromEnvironment('dart.vm.product');
  static bool get isProduction => kReleaseMode;

  static Future<AppConfig> forEnvironment(String env) async {

    // set default to dev if nothing was passed
    env = env ?? 'dev';
    // load the json file
    final contents = await rootBundle.loadString('assets/config/$env.json');
    // decode our json
    final json = jsonDecode(contents);
    // convert our JSON into an instance of our AppConfig class
    return AppConfig._(
        dbPassword: json['DbPassword'],
        triviaApiUrl: json['TriviaApiUrl'],
    );
  }
}