
import 'package:intl/intl.dart';
import 'package:triviabank/bloc/authorization_bloc.dart';
import 'package:triviabank/bloc/home_bloc.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/net/trivia_api_client.dart';
import 'package:triviabank/ui/trivia_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  HomeBloc bloc = HomeBloc();

  bool _busy = false;

  num _balance = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(AmLocalizations.of(context).welcome),),
      body: Container(
        height: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.topCenter,
                child: FutureBuilder<List<BankTransaction>>(
                  future: bloc.transactionDao.getAllBankTransactionsByUser(authBloc.user.id),
                  builder: (context, snapshot) {

                    var resultText = AmLocalizations.of(context).errorRetrievingBalance;
                    var ovalColor = Colors.red;

                    if (snapshot.hasData) {

                      var totalCents = _computeTotalSends(snapshot.data);
                      //resultText = AmLocalizations.of(context).currentBalanceStringFormat(NumberFormat.simpleCurrency().format(totalCents / 100));
                      resultText = 'Your current balance is ${NumberFormat.simpleCurrency().format(totalCents / 100)}';
                      ovalColor = _balanceColor(totalCents);

                      setState(() {
                        _balance = totalCents;
                      });

                    } else if (!snapshot.hasError) {
                      //resultText = AmLocalizations.of(context).currentBalanceStringFormat(0);
                    }

                    return ClipOval(
                      child: Container(
                        color: ovalColor,
                        height: 120.0, // height of the button
                        width: 120.0, // width of the button
                        child: Center(child: Text(resultText, style: TextStyle(color: Colors.white),)),
                      ),
                    );
                  },
                )
              )
            ),
            Visibility(
              visible: _busy,
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
                            onPressed: () async {

                              setState(() {
                                _busy = true;
                              });

                              var userDifficultyLevel = _userLevelOfDifficulty(_balance);
                              var triviaQuestions = await TriviaApiClient.getInstance.getQuestions(difficulty: userDifficultyLevel, amount: 5, category: 9);

                              setState(() {
                                _busy = false;
                              });

                              await Navigator.push(context, MaterialPageRoute(builder: (context) => TriviaScreen(triviaQuestionEntryList: null)));
                            },
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
                  onPressed: bloc.logoutUser,
                  child: Text(AmLocalizations.of(context).logout, style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
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

  static num _computeTotalSends(List<BankTransaction> bankTransactions) {
    num result = 0;
    bankTransactions.forEach((t) => result += t.amount);
    return result;
  }
}