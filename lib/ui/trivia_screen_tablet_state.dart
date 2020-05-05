
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_bloc.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_state.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/ui/trivia_question_card.dart';
import 'package:triviabank/ui/trivia_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:triviabank/util/app_config.dart';

class TriviaScreenTabletState extends State<TriviaScreen> {

  bool _showTopDollarMenu;

  @override
  void initState() {
    super.initState();
    _showTopDollarMenu = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                user: widget.user,
                appConfig: Provider.of<AppConfig>(context),
                triviaQuestionDao: Provider.of<AppDatabase>(context).triviaQuestionDao,
                homeState: widget.homeState
            ),

            builder: (BuildContext context, state) => Stack(

              children: <Widget>[

                Positioned(
                  width: MediaQuery.of(context).size.width / 5,
                  height: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[

                      for (var i in ['100','500','1000','2000','5000'])
                        Stack(
                          children: <Widget>[
                            SvgPicture.asset('assets/icons/dollar_bill.svg'),
                            Text('\$$i')
                          ],
                        )

                    ],
                  ),
                ),

                NotificationListener(

                  onNotification: (scrollState) {
                    if (scrollState is ScrollStartNotification) {
                      setState(() {
                        _showTopDollarMenu = false;
                      });
                    } else if (scrollState is ScrollEndNotification) {
                      setState(() {
                        _showTopDollarMenu = true;
                      });
                    }
                    return false;
                  },

                  child: ListView( // create a horizontal (scrollable) listview for Phones similar to YouTube's subscription tab page

                    scrollDirection: Axis.vertical,

                    children: <Widget>[
                      if (state.triviaQuestionList != null)
                        for (TriviaQuestion triviaQuestionRecord in state.triviaQuestionList)
                          TriviaQuestionCard(triviaQuestion: triviaQuestionRecord, onValueSelected: _letUserKnowIfIncorrect)
                    ],

                  ),

                ),

                Positioned(
                  height: MediaQuery.of(context).size.height / 6,
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
    );
  }
}