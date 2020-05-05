
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:flutter/material.dart';
import 'package:triviabank/util/entire_result.dart';

class UserRepository {

  final _userKey = 'token';

  final UserDao userDao;

  UserRepository({this.userDao});

  Future<EntireResult<User>> authenticate({
    @required String username,
    @required String password,
  }) async {

    if (kDebugMode) {
      return EntireResult(User(id: 1, emailAddress: username));
    }

    try {
      var user = await userDao.findUser(username);
      if (user == null) {
        await userDao.insertUser(User(emailAddress: username));
        user = await userDao.findUser(username);
      }
      return EntireResult(user);
    } catch (exception) {
      return EntireResult(null,error: exception.toString());
    }
  }

  Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey) ? prefs.getString(_userKey) : null;
  }

  Future<void> deleteToken() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    return;
  }

  Future<void> persistToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, token);
    return;
  }

  Future<bool> hasToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }
}