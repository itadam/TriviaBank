
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_bloc.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_event.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_state.dart';
import 'package:triviabank/bloc/trivia_screen/trivia_screen_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/ui/trivia_question_card.dart';
import 'package:triviabank/ui/trivia_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:triviabank/util/app_config.dart';

class TriviaScreenPhoneState extends State<TriviaScreen> {

  bool _showTopDollarMenu;
  TriviaScreenBloc _triviaScreenBloc;

  @override
  void initState() {
    super.initState();
    _showTopDollarMenu = true;
  }

  @override
  void dispose() {
    _triviaScreenBloc.close();
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

    _triviaScreenBloc = TriviaScreenBloc(
        user: widget.user,
        appConfig: Provider.of<AppConfig>(context),
        triviaQuestionDao: Provider.of<AppDatabase>(context).triviaQuestionDao,
        homeState: widget.homeState
    );

    _triviaScreenBloc.add(TriviaScreenLoadQuestions());

    return Scaffold(
        appBar: AppBar(title: Text(AmLocalizations.of(context).triviaTime,),),
        body: BlocBuilder<TriviaScreenBloc, TriviaScreenState>(

            bloc: _triviaScreenBloc,

            builder: (BuildContext context, state) => Stack(
              fit: StackFit.expand,
              children: <Widget>[

                Visibility(
                    visible: state.triviaScreenStatus == TriviaScreenStatus.FetchingData,
                    child: CircularProgressIndicator()
                ),

                Visibility(
                    visible: _showTopDollarMenu,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 1, top: 5),
                        child: ListView(
                          scrollDirection: Axis.horizontal,

                          children: <Widget>[

                            for (var i in [100,500,1000,2000,5000])
                              Padding(
                                padding: EdgeInsets.only(left: (i > 100 ? 10 : 0), right: (i < 5000 ? 10 : 0)),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    fit: StackFit.loose,
                                    overflow: Overflow.clip,
                                    children: <Widget>[
                                      Text(AmLocalizations.of(context).wageSelectionAlex(i)),
                                      SvgPicture.asset('assets/icons/dollar_bill.svg', height: MediaQuery.of(context).size.height / 10,),
                                    ],
                                  ),
                                ),
                              )

                          ],
                        ),
                      ),
                    )
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
                        Padding(
                          child: RaisedButton(
                            child: Text(AmLocalizations.of(context).back, style: TextStyle(color: Colors.white),),
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Padding(
                          child: RaisedButton(
                            //onPressed: bloc.logoutUser,
                            child: Text(AmLocalizations.of(context).next, style: TextStyle(color: Colors.white),),
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.only(left: 10),
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