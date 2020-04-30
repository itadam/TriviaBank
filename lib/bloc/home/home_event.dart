
import 'package:equatable/equatable.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_service.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeScreenLoadedEvent extends HomeEvent {

  const HomeScreenLoadedEvent() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'HomeScreenLoadedEvent';
}