import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'login_status.dart';

class LoginState extends Equatable {

  const LoginState({@required this.loginStatus, this.error, this.isEmailValid = false, this.isPasswordValid = false});

  final LoginStatus loginStatus;
  final String error;
  final bool isEmailValid;
  final bool isPasswordValid;

  LoginState mergeWith({
    LoginStatus loginStatus,
    String error,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      error: error ?? this.error,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
    );
  }

  @override
  List<Object> get props => [loginStatus,error,isEmailValid,isPasswordValid];
}