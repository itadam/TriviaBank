
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_status.dart';
import 'package:triviabank/data/app_database.dart';

class TriviaScreenState extends Equatable {

  final TriviaScreenStatus triviaScreenStatus;
  final List<TriviaQuestion> triviaQuestionList;
  final String error;

  TriviaScreenState({
    @required this.triviaScreenStatus,
    @required this.triviaQuestionList,
    @required this.error
  }) : super();

  TriviaScreenState mergeWith({
    TriviaScreenStatus triviaScreenStatus,
    List<TriviaQuestion> triviaQuestionList,
    String error,
  }) {
    return TriviaScreenState(
      triviaScreenStatus: triviaScreenStatus ?? this.triviaScreenStatus,
      triviaQuestionList: triviaQuestionList ?? this.triviaQuestionList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [triviaScreenStatus,triviaQuestionList,error];

}