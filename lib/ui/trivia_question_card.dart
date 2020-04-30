
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:triviabank/data/app_database.dart';

class TriviaQuestionCard extends StatelessWidget {

  TriviaQuestionCard({@required this.triviaQuestion, this.onValueSelected}) :
      assert(triviaQuestion != null, 'TriviaQuestion data was not provided or is invalid.'),
      super()
  ;

  final TriviaQuestion triviaQuestion;

  // Callback, called when a Question is answered.
  final Function(TriviaQuestion question, String newValueSelected) onValueSelected;

  @override
  Widget build(BuildContext context) {

    //final _isAnswered = !(triviaQuestionEntry.answer == null || triviaQuestionEntry.answer.isEmpty);

    final _randomGroupValue = 'question-${Random().nextInt(1000)}';

    var answerList = List.from(triviaQuestion.incorrectAnswers, growable: true);
    answerList.add(triviaQuestion.correctAnswer);
    answerList.shuffle();

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12)
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              bottomLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 48.0),
            child: Text(triviaQuestion.question),
          ),
        ),
        for (String answerEntry in answerList)
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12)
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 48.0),
              child: RadioListTile<String>(
                title: Text(answerEntry),
                value: answerEntry.toLowerCase(),
                groupValue: _randomGroupValue,
                onChanged: (String value) => onValueSelected == null ? null : onValueSelected(triviaQuestion, value),
              ),
            ),
          )
      ],
    );
  }
}