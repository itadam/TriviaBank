
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:flutter/material.dart';

class UserRepository {

  final _userKey = 'token';

  UserDao _userDao;

  UserRepository(this._userDao);

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {

    var user = await _userDao.findUser(username);

    if (user == null) {
      await _userDao.insertUser(User(emailAddress: username));
      user = await _userDao.findUser(username);
    }

    return user?.toJsonString();
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