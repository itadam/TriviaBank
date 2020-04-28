
import 'package:equatable/equatable.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_service.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeQueryDatabaseEvent extends HomeEvent {

  final Function(BankTransactionDao bankTransactionDao) onQuery;

  const HomeQueryDatabaseEvent({this.onQuery}) : super();

  @override
  List<Object> get props => [onQuery];

  @override
  String toString() => 'HomeQueryDatabaseEvent';
}

class HomeCallApiEvent extends HomeEvent {

  final Function(TriviaApiService triviaApiService) onApiCall;

  const HomeCallApiEvent({this.onApiCall}) : super();

  @override
  List<Object> get props => [onApiCall];

  @override
  String toString() => 'HomeCallApiEvent';

}