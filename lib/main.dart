
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/model/trivia_question_entry.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:triviabank/bloc/authorization_bloc.dart';
import 'package:triviabank/theme/am_bank_theme.dart';
import 'package:triviabank/ui/home_screen.dart';
import 'package:triviabank/ui/login_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

void main() {
  runApp(BankMobileApp());
}

class BankMobileApp extends StatelessWidget {

  BankMobileApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: AmLocalizations.of(context).appTitle,
      theme: AmBankTheme.defaultTheme,
      supportedLocales: [
        const Locale('en'), // English only for now
      ],
      localizationsDelegates: [
        AmLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: createHomeOrLoginContent()
    );
  }

  Widget createHomeOrLoginContent() { // return the HomeScreen if there's a valid auth session.

    return StreamBuilder<bool> (
      stream: authBloc.isSessionValid,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return HomeScreen();
        }
        return LoginScreen();
      });
  }
}