import 'dart:convert';

import 'package:triviabank/data/app_database.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationBloc {

  final _userKey = 'token';
  String _userString = '';

  final PublishSubject _isSessionValid = PublishSubject<bool>();

  Stream<bool> get isSessionValid => _isSessionValid.stream;

  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userString = prefs.get(_userKey);
    if (_userString != null && _userString.length > 0) {
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }

  void openSession(String userStr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, userStr);
    _userString = userStr;
    _isSessionValid.sink.add(true);
  }

  void closeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
    _isSessionValid.sink.add(false);
  }

  User get user => _userString == null || _userString.isEmpty ? null : User.fromJson(jsonDecode(_userString));

}

final authBloc = AuthorizationBloc();