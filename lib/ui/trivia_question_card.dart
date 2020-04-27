
import 'dart:math';

import 'package:triviabank/data/model/trivia_question_entry.dart';
import 'package:flutter/material.dart';

class TriviaQuestionCard extends StatelessWidget {

  TriviaQuestionCard({this.triviaQuestionEntry, this.onValueSelected});

  final TriviaQuestionEntry triviaQuestionEntry;

  final Function(TriviaQuestionEntry questionEntry, String newValueSelected) onValueSelected;

  @override
  Widget build(BuildContext context) {

    //final _isAnswered = !(triviaQuestionEntry.answer == null || triviaQuestionEntry.answer.isEmpty);

    final _randomGroupValue = 'question-${Random().nextInt(1000)}';

    var answerList = List.from(triviaQuestionEntry.incorrect_answers, growable: true);
    answerList.add(triviaQuestionEntry.correct_answer);
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
            child: Text(triviaQuestionEntry.question),
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
                onChanged: (String value) => onValueSelected(triviaQuestionEntry, value),
              ),
            ),
          )
      ],
    );
  }
}