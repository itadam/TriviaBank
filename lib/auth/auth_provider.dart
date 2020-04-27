
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:flutter/material.dart';

class AuthProvider {

  Future<User> login({
    @required String email,
    @required String password,
  }) async {

    var db = AppDatabase();

    var tUser = new User(emailAddress: email);

    await db.userDao.insertUser(tUser);

    var user = await db.userDao.findUser(email);

    if (user == null) { // TODO: this shouldn't happen. However we will want to add exception handling later.

    }

    return user;
  }
}