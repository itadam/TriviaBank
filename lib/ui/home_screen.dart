
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
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/ui/trivia_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:triviabank/util/dart_extensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _homeBloc = HomeBloc(
        user: widget.user,
        bankTransactionDao: Provider.of<AppDatabase>(context).bankTransactionDao
    );

    return Scaffold(
      appBar: AppBar(title: Text(AmLocalizations.of(context).welcome),),
      body: BlocBuilder<HomeBloc, HomeState>(

        bloc: _homeBloc,

        builder: (context, state) => Container(
          height: double.maxFinite,
          child: new Stack(
            children: <Widget>[
              new Positioned(
                  child: new Align(
                      alignment: FractionalOffset.topCenter,
                      child: ClipOval(
                        child: Container(
                          color: state.bankBalance?.bankAccountBalanceColor(),
                          height: 120.0, // height of the button
                          width: 120.0, // width of the button
                          child: Center(child: Text(AmLocalizations.of(context).currentBalanceStringFormat(state.bankBalance), style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
                        ),
                      )
                  )
              ),
              Visibility(
                  visible: state.homeStatus == HomeStatus.FetchingData,
                  child: CircularProgressIndicator()
              ),
              new Positioned(
                  child: new Align(
                    alignment: FractionalOffset.center,
                    child: GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: new Text(AmLocalizations.of(context).addMore),
                          content: new Text(AmLocalizations.of(context).addMoreToBalance),
                          actions: <Widget>[
                            new FlatButton(
                                child: new Text(AmLocalizations.of(context).yesWithExclamation),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TriviaScreen(user: widget.user, homeState: state,)),
                                )
                            ),
                            new FlatButton(
                              child: new Text(AmLocalizations.of(context).cancel),
                              onPressed: () async => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
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
      ),
    );
  }
}