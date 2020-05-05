import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:triviabank/data/app_database.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {

  final User user;
  const LoggedIn({@required this.user}) : super();

  String get token => user?.toJsonString();

  @override
  List<Object> get props => [user,];

  @override
  String toString() => 'LoggedIn { user: ${user?.emailAddress} }';
}

class LoggedOut extends AuthenticationEvent {}