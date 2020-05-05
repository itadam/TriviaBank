
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/bloc/authentication/authentication_event.dart';
import 'package:triviabank/bloc/authentication/authentication_state.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null, 'Provided UserRepository is invalid, and must not be null.'), super();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AppStarted) {
      //final bool hasToken = await userRepository.hasToken();
      final userToken = await userRepository.getToken();

      if (userToken != null) {
        var user = User.fromJson(jsonDecode(userToken));
        if (user == null) {
          yield AuthenticationUnauthenticated();
        } else {
          yield AuthenticationAuthenticated(user: user);
        }
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}