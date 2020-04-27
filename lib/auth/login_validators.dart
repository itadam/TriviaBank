
import 'dart:async';

import 'package:triviabank/util/app_config.dart';
import 'package:flutter/material.dart';

class LoginValidators {

  static bool isValidEmail(String str) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(str);
  }

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
      if (!isValidEmail(email)) {
        sink.addError('$email is not a valid Email address.');
      } else {
        sink.add(email);
      }
    }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      // TODO: add real Password validation here.
      sink.add(password);
    }
  );
}