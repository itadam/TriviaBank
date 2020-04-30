
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/authentication/authentication_bloc.dart';
import 'package:triviabank/bloc/login/login_bloc.dart';
import 'package:triviabank/bloc/login/login_event.dart';
import 'package:triviabank/bloc/login/login_state.dart';
import 'package:triviabank/bloc/login/login_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';
import 'package:triviabank/ui/home_screen.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(userRepository: Provider.of<UserRepository>(context, listen: false), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    _loginBloc.listen((lState) {

      if (lState.loginStatus == LoginStatus.successful) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (lState.loginStatus == LoginStatus.failure) {

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${lState.error}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _usernameController.addListener(() => _loginBloc.add(EmailChanged(email: _usernameController.text)));
    _passwordController.addListener(() => _loginBloc.add(PasswordChanged(password: _passwordController.text)));

    return Scaffold(
      appBar: AppBar(
        title: Text(AmLocalizations.of(context).login),
      ),
      body: Container(

        margin: EdgeInsets.all(20.0),

        child: BlocBuilder<LoginBloc, LoginState>(

          bloc: _loginBloc,

          builder: (context, state) => Form(

            child: Column(

              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AmLocalizations.of(context).emailAddress,
                    hintText: AmLocalizations.of(context).emailAddressHint,
                  ),
                  autovalidate: true,
                  validator: (_) => state.loginStatus != LoginStatus.emailChanged || state.isEmailValid ? null : AmLocalizations.of(context).emailAddressIsInvalid,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AmLocalizations.of(context).password,
                    hintText: AmLocalizations.of(context).password,
                  ),
                  autovalidate: true,
                  validator: (_) => state.loginStatus != LoginStatus.passwordChanged || state.isPasswordValid ? null : AmLocalizations.of(context).passwordDoesNotMeetRequirements,
                ),
                Container(margin: EdgeInsets.only(top: 25.0)),
                RaisedButton(
                  onPressed: () => (state.loginStatus != LoginStatus.authenticating) ? _loginBloc.add(LoginButtonPressed(username: _usernameController.text, password: _passwordController.text, ),) : null,
                  child: Text(AmLocalizations.of(context).login, style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                ),
                Container(
                  child: (state.loginStatus == LoginStatus.authenticating) ? CircularProgressIndicator() : null,
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
