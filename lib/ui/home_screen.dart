
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/authentication/authentication_bloc.dart';
import 'package:triviabank/bloc/authentication/authentication_event.dart';
import 'package:triviabank/bloc/home/home_bloc.dart';
import 'package:triviabank/bloc/home/home_event.dart';
import 'package:triviabank/bloc/home/home_state.dart';
import 'package:triviabank/bloc/home/home_status.dart';
import 'package:triviabank/bloc/login/login_bloc.dart';

import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/model/trivia_question_entry.dart';
import 'package:triviabank/net/trivia_api_service.dart';

import 'package:triviabank/ui/trivia_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(AmLocalizations.of(context).welcome),),
      body: BlocBuilder<HomeBloc, HomeState>(

        builder: (context, state) => Container(
          height: double.maxFinite,
          child: new Stack(
            children: <Widget>[
              new Positioned(
                  child: new Align(
                      alignment: FractionalOffset.topCenter,
                      child: FutureProvider<List<BankTransaction>>( // TODO: refactor this
                        create: (BuildContext context) async =>
                                          await BlocProvider.of<HomeBloc>(context).bankTransactionDao.getAllBankTransactionsByUser(BlocProvider.of<LoginBloc>(context).user.id),
                        child: Consumer<List<BankTransaction>>(
                          builder: (context, lstValue, child) => ClipOval(
                              child: Container(
                              color: _balanceColor(_computeTotalCents(lstValue)),
                              height: 120.0, // height of the button
                              width: 120.0, // width of the button
                              child: Center(child: Text(AmLocalizations.of(context).currentBalanceStringFormat(NumberFormat.simpleCurrency().format(_computeTotalCents(lstValue) / 100)), style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
                            ),
                          )
                        ),
                      )
                  )
              ),
              Visibility(
                  visible: state.homeStatus == HomeStatus.Loading || state.homeStatus == HomeStatus.FetchingData,
                  child: CircularProgressIndicator()
              ),
              new Positioned(
                  child: new Align(
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {

                          return AlertDialog(
                            title: new Text(AmLocalizations.of(context).addMore),
                            content: new Text(AmLocalizations.of(context).addMoreToBalance),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text(AmLocalizations.of(context).yesWithExclamation),
                                onPressed: () => FutureBuilder(
                                  future: BlocProvider.of<HomeBloc>(context).getApiService<TriviaApiService>().getQuestions(difficulty: 'easy', amount: 5, category: 9),
                                  builder: (buildContext, snapshot) {

                                    if (snapshot.hasData) {
                                      List genericList = json.decode(snapshot.data);
                                      var questionList = genericList.map((e) => TriviaQuestionEntry.fromJson(e));
                                      Navigator.push(buildContext, MaterialPageRoute(builder: (context) => TriviaScreen(triviaQuestionEntryList: questionList)));
                                    }

                                    return ;
                                  },
                                )
                              ),
                              new FlatButton(
                                child: new Text(AmLocalizations.of(context).cancel),
                                onPressed: () async => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                        },
                      ),
                      child: ClipOval(
                        child: Container(
                          color: Colors.blue,
                          height: 120.0, // height of the button
                          width: 120.0, // width of the button
                          child: Center(child: Text(AmLocalizations.of(context).tryToEarnMore, style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                  )
              ),
              new Positioned(
                child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: RaisedButton(
                    onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
                    child: Text(AmLocalizations.of(context).logout, style: TextStyle(color: Colors.white),),
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  static String _userLevelOfDifficulty(num accountBalanceInCents) {
    if (accountBalanceInCents >= 10 ^ 4) {
      return 'hard';
    }
    return 'easy';
  }

  static Color _balanceColor(num accountBalanceInCents) {
    if (accountBalanceInCents >= 10 ^ 8) {
      return Colors.green;
    } else if (accountBalanceInCents >= 10 ^ 6) {
      return Colors.blueGrey;
    } else if (accountBalanceInCents >= 10 ^ 4) {
      return Colors.lightGreen;
    }
    return Colors.red;
  }

  static num _computeTotalCents(List<BankTransaction> bankTransactions) {
    num result = 0;
    bankTransactions.forEach((t) => result += t.amount);
    return result;
  }
}