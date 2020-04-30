
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/authentication/authentication_bloc.dart';
import 'package:triviabank/bloc/authentication/authentication_state.dart';
import 'package:triviabank/constants.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';
import 'package:triviabank/net/trivia_api_service.dart';
import 'package:triviabank/util/app_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:triviabank/theme/am_bank_theme.dart';
import 'package:triviabank/ui/home_screen.dart';
import 'package:triviabank/ui/login_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

void main() {
  launchApp(env: 'dev');
}

void launchApp({String env}) {

  runApp(
      MultiProvider(
        providers: [
          Provider<AppDatabase>(create: (context) => AppDatabase(), dispose: (context, db) => db?.close(),),
          FutureProvider<AppConfig>(create: (context) async => await AppConfig.forEnvironment(env)),
        ],
        child: BankMobileApp(),
      )
  );
}

class BankMobileApp extends StatelessWidget {

  BankMobileApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
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
      home: Provider<UserRepository>(

        create: (context) => UserRepository(Provider.of<AppDatabase>(context, listen: false).userDao),

        child: BlocProvider<AuthenticationBloc>(

          create: (context) => AuthenticationBloc(userRepository: Provider.of<UserRepository>(context, listen: false)),

          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) => (authState is AuthenticationAuthenticated) ? HomeScreen() : LoginScreen(),
          )
        ),
      )
    );
  }
}