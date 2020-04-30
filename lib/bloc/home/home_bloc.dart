
import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/bloc/home/home_event.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/home/home_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final User user;
  final BankTransactionDao bankTransactionDao;

  HomeBloc({
    @required this.user,
    @required this.bankTransactionDao
  }) :  assert(user != null, 'Provided User data is invalid.'),
        assert(bankTransactionDao != null, 'Provided BankTransactionao DAO is invalid'),
        super()
    ;

  @override
  HomeState get initialState => HomeState();

  Stream<HomeState> _mapDatabaseQueryEvent(HomeScreenLoadedEvent event) async* {
    yield state.mergeWith(homeStatus: HomeStatus.FetchingData);
    try {
      var transactionList = await bankTransactionDao.getAllBankTransactionsByUser(user.id);
      yield state.mergeWith(homeStatus: HomeStatus.DataLoaded, bankTransactionList: transactionList);
    } catch (error) {
      yield state.mergeWith(homeStatus: HomeStatus.DataFailedToLoad);
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {

    if (event is HomeScreenLoadedEvent) {
      yield* _mapDatabaseQueryEvent(event);
    }
  }
}