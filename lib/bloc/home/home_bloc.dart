
import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/bloc/home/home_event.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/home/home_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final AppConfig appConfig;
  final BankTransactionDao bankTransactionDao;
  final ChopperClient _chopperClient;

  HomeBloc(this.appConfig, this.bankTransactionDao) :
        _chopperClient = ChopperClient(
          baseUrl: appConfig.triviaApiUrl,
          services: [
            TriviaApiService.create()
          ],
        )
    ;

  @override
  HomeState get initialState => HomeState(homeStatus: HomeStatus.Loading);

  @override
  Future<void> close() {
    _chopperClient.dispose();
    return super.close();
  }

  T getApiService<T extends ChopperService>() => _chopperClient.getService<T>();

  Stream<HomeState> _mapApiCall(HomeCallApiEvent event) async* {
    yield state.mergeWith(homeStatus: HomeStatus.Loading);
    try {
      var apiSvc = _chopperClient.getService<TriviaApiService>();
      event.onApiCall(apiSvc);
      yield state.mergeWith(homeStatus: HomeStatus.Loaded);
    } catch (error) {
      yield state.mergeWith(homeStatus: HomeStatus.DataFailedToLoad);
    }
  }

  Stream<HomeState> _mapDatabaseQueryEvent(HomeQueryDatabaseEvent event) async* {
    yield state.mergeWith(homeStatus: HomeStatus.FetchingData);
    try {
      event.onQuery(bankTransactionDao);
      yield state.mergeWith(homeStatus: HomeStatus.DataLoaded);
    } catch (error) {
      yield state.mergeWith(homeStatus: HomeStatus.DataFailedToLoad);
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {

    if (event is HomeCallApiEvent) {
      yield* _mapApiCall(event);
    } else if (event is HomeQueryDatabaseEvent) {
      yield* _mapDatabaseQueryEvent(event);
    }
  }
}