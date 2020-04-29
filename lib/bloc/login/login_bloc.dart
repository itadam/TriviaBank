
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

  User _user;

  User get user => _user;

  static bool _isValidEmail(String str) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(str);
  }

  static bool _isPasswordValid(String str) {
    return !(str == null || str.isEmpty);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is LoginInitialized) {
      yield LoginState(loginStatus: LoginStatus.initial, error: null, isEmailValid: false, isPasswordValid: false);
    }
    if (event is EmailChanged) {
      yield state.mergeWith(isEmailValid: _isValidEmail(event.email));
    }
    if (event is PasswordChanged) {
      yield state.mergeWith(isPasswordValid: _isPasswordValid(event.password),);
    }
    if (event is LoginButtonPressed) {
      yield state.mergeWith(loginStatus: LoginStatus.loading);

      try {

        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        _user = User.fromJson(jsonDecode(token));
        authenticationBloc.add(LoggedIn(token: token));
        yield state.mergeWith(loginStatus: LoginStatus.initial);
      } catch (error) {
        _user = null;
        yield state.mergeWith(loginStatus: LoginStatus.failure, error: error.toString());
      }
    }
  }
}