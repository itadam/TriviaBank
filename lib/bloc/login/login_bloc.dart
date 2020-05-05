
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import '../authentication/authentication_bloc.dart';
import '../authentication/authentication_event.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'login_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc
  })  : assert(userRepository != null, 'Provided UserRepository is invalid, and must not be null.'),
        assert(authenticationBloc != null, 'Provided AuthenticationBloc is invalid, and must not be null.'),
        super();

  LoginState get initialState => LoginState(loginStatus: LoginStatus.initial);

  static bool isValidEmail(String str) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(str);
  }

  static bool isPasswordValid(String str) {
    return !(str == null || str.isEmpty);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is LoginInitialized) {
      yield LoginState(loginStatus: LoginStatus.initial, error: null, isEmailValid: false, isPasswordValid: false);
    }
    if (event is EmailChanged) {
      yield state.mergeWith(loginStatus: LoginStatus.emailChanged, isEmailValid: isValidEmail(event.email));
    }
    if (event is PasswordChanged) {
      yield state.mergeWith(loginStatus: LoginStatus.passwordChanged, isPasswordValid: isPasswordValid(event.password),);
    }
    if (event is LoginButtonPressed) {

      yield state.mergeWith(loginStatus: LoginStatus.authenticating);

      try {

        final userResult = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        if (userResult == null || userResult.result == null) {
          throw userResult?.error;
        }
        authenticationBloc.add(LoggedIn(user: userResult.result));
        yield state.mergeWith(loginStatus: LoginStatus.successful, isEmailValid: true, isPasswordValid: true, error: userResult.error, user: userResult.result);
      } catch (error) {
        yield state.mergeWith(loginStatus: LoginStatus.failure, error: error?.toString());
      }
    }
  }
}