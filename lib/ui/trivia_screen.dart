
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_bloc.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_state.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/ui/trivia_question_card.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class TriviaScreen extends StatefulWidget {

  TriviaScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {

  void _letUserKnowIfIncorrect(TriviaQuestion question, String newValueSelected) {

    showDialog(
      context: context,
      builder: (BuildContext context) {

        final correctAnswer = newValueSelected == question.correctAnswer;

        return AlertDialog(
          title: new Text(correctAnswer ? AmLocalizations.of(context).correct : AmLocalizations.of(context).incorrect),
          content: new Text(correctAnswer ? AmLocalizations.of(context).answerCorrect : AmLocalizations.of(context).answerIncorrect),
          actions: <Widget>[
            new FlatButton(
              child: new Text(AmLocalizations.of(context).ok),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
            ),
          ],
        );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(AmLocalizations.of(context).triviaTime,),),
      body: BlocBuilder<TriviaScreenBloc, TriviaScreenState>(

        bloc: TriviaScreenBloc(
          triviaQuestionDao: Provider.of<AppDatabase>(context).triviaQuestionDao,

        ),

        builder: (BuildContext context, state) => Container(
          height: double.maxFinite,
          child: new Stack(
            children: <Widget>[
              new Positioned(
                child: new Align(
                  alignment: FractionalOffset.topCenter,
                  child: Text(AmLocalizations.of(context).youHaveNumberOfQuestions(state.triviaQuestionList?.length), style: TextStyle(color: Colors.white),),
                )
              ),
              new Positioned(
                child: new Align(
                  alignment: FractionalOffset.topCenter,
                  child: Column(
                    children: <Widget>[
                      for (TriviaQuestion triviaQuestionRecord in state.triviaQuestionList)
                        TriviaQuestionCard(triviaQuestion: triviaQuestionRecord, onValueSelected: _letUserKnowIfIncorrect)
                    ],
                  )
                )
              ),
              new Positioned(
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(AmLocalizations.of(context).back, style: TextStyle(color: Colors.white),),
                        color: Colors.blue,
                      ),
                      RaisedButton(
                        //onPressed: bloc.logoutUser,
                        child: Text(AmLocalizations.of(context).next, style: TextStyle(color: Colors.white),),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        )
      )
    );
  }
}