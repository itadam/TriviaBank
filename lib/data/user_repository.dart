import 'package:triviabank/auth/auth_provider.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:flutter/material.dart';

class UserRepository {

  final AuthProvider authProvider = AuthProvider();

  Future<User> login(String email, String password) => authProvider.login(email: email, password: password);
}