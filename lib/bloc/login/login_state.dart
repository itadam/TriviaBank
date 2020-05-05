import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:triviabank/data/app_database.dart';

import 'login_status.dart';

class LoginState extends Equatable {

  const LoginState({this.loginStatus = LoginStatus.initial, this.error, this.isEmailValid = false, this.isPasswordValid = false, this.userResult});

  final LoginStatus loginStatus;
  final String error;
  final bool isEmailValid;
  final bool isPasswordValid;
  final User userResult;

  LoginState mergeWith({
    LoginStatus loginStatus,
    String error,
    bool isEmailValid,
    bool isPasswordValid,
    User user
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      error: error ?? this.error,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      userResult: user ?? this.userResult
    );
  }

  @override
  List<Object> get props => [loginStatus,error,isEmailValid,isPasswordValid,userResult];
}