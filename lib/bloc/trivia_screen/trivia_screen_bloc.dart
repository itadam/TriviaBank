
import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/bloc/home/home_bloc.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_event.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:triviabank/util/dart_extensions.dart';

class TriviaScreenBloc extends Bloc<TriviaScreenEvent, TriviaScreenState> {

  final AppConfig appConfig;
  final ChopperClient _chopperClient;
  final TriviaQuestionDao triviaQuestionDao;
  final User user;
  final HomeState homeState;

  TriviaScreenBloc({
    @required this.user,
    @required this.appConfig,
    @required this.triviaQuestionDao,
    @required this.homeState
  }) :
        assert(user != null, 'Provided User data is invalid.'),
        assert(appConfig != null, 'Provided app config is invalid.'),
        assert(triviaQuestionDao != null, 'TriviaQuestionDao is invalid.'),
        assert(homeState != null, 'HomeState is invalid.'),
        _chopperClient = ChopperClient(
          baseUrl: appConfig?.triviaApiUrl,
          services: [
            TriviaApiService.create()
          ],
        ),
        super();

  @override
  Future<void> close() {
    _chopperClient.dispose();
    return super.close();
  }

  @override
  TriviaScreenState get initialState => TriviaScreenState(triviaScreenStatus: TriviaScreenStatus.Initialized, triviaQuestionList: null, error: null);

  final numberOfQuestions = 10;

  Stream<TriviaScreenState> _mapApiCall(TriviaScreenEvent event) async* {
    yield state.mergeWith(triviaScreenStatus: TriviaScreenStatus.FetchingData);
    try {

      var apiSvc = _chopperClient.getService<TriviaApiService>();

      var triviaQuestionListResponse = await apiSvc.getQuestions(difficulty: homeState.bankBalance.userDifficultyLevel(), amount: numberOfQuestions);

      if (triviaQuestionListResponse == null || !triviaQuestionListResponse.isSuccessful) {
        throw triviaQuestionListResponse?.error;
      }

      var genericListTriviaQuestions = jsonDecode(triviaQuestionListResponse.body) as List;

      var triviaQuestionList = genericListTriviaQuestions.map((e) => TriviaQuestion.fromJson(e));

      yield state.mergeWith(triviaScreenStatus: TriviaScreenStatus.DataLoaded, triviaQuestionList: triviaQuestionList);

    } catch (error) {
      yield state.mergeWith(triviaScreenStatus: TriviaScreenStatus.DataFailedToLoad, error: error?.toString());
    }
  }

  @override
  Stream<TriviaScreenState> mapEventToState(TriviaScreenEvent event) async* {

    if (event is TriviaScreenLoadQuestions) {
      yield* _mapApiCall(event);
    }
  }
}