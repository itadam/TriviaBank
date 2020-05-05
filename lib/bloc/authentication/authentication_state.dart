import 'package:equatable/equatable.dart';
import 'package:triviabank/data/app_database.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {

  final User user;

  AuthenticationAuthenticated({this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}