
import 'package:encrypted_moor/encrypted_moor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/authentication/authentication_bloc.dart';
import 'package:triviabank/bloc/authentication/authentication_state.dart';
import 'package:triviabank/bloc/login/login_bloc.dart';
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
          FutureProvider<AppConfig>.value(value: AppConfig.forEnvironment(env),),
          Provider<AppDatabase>(
            create: (context) => AppDatabase(
              queryExecutor: EncryptedExecutor.inDatabaseFolder(path: 'am.sqlite', password: dbPassword, logStatements: kDebugMode)
            ),
            lazy: false,
            dispose: (context, db) => db?.close(),
          ),
          ProxyProvider<AppDatabase, UserDao>(
            update: (context, db, previousUsrDao) => db.userDao,
          ),
          ProxyProvider<UserDao, UserRepository>(
            update: (context, usrDao, previousUserRepository) => UserRepository(userDao: usrDao),
          )
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
      home: BlocProvider.value(
        value: AuthenticationBloc(userRepository: Provider.of<UserRepository>(context, listen: false)),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) =>
              (authState is AuthenticationAuthenticated && authState.user != null)
                  ?
              HomeScreen(user: authState.user,)
                  :
              BlocProvider<LoginBloc>.value(value: LoginBloc(userRepository: Provider.of<UserRepository>(context, listen: false), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)), child: LoginScreen(),)
              ,
        ),
      )
    );
  }
}