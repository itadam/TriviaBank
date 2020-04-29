
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:triviabank/bloc/authentication/authentication_bloc.dart';
import 'package:triviabank/bloc/login/login_bloc.dart';
import 'package:triviabank/bloc/login/login_event.dart';
import 'package:triviabank/bloc/login/login_state.dart';
import 'package:triviabank/bloc/login/login_status.dart';
import 'package:triviabank/data/app_database.dart';
import 'package:triviabank/data/user_repository.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void loginPressed(BuildContext buildContext) {
    BlocProvider.of<LoginBloc>(buildContext).add(
      LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AmLocalizations.of(context).login),
      ),
      body: Container(

        margin: EdgeInsets.all(20.0),

        child: BlocProvider<LoginBloc>(

          create: (context) => LoginBloc(userRepository: Provider.of<UserRepository>(context, listen: false), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),

          child: BlocBuilder<LoginBloc, LoginState>(

            builder: (context, state) => Form(

              child: Column(

                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: AmLocalizations.of(context).emailAddress,
                      hintText: AmLocalizations.of(context).emailAddressHint,
                      //errorText: snap.error
                    ),
                    autovalidate: true,
                    validator: (_) => LoginBloc.isValidEmail(_) ? null : AmLocalizations.of(context).emailAddressIsInvalid,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: AmLocalizations.of(context).password,
                      hintText: AmLocalizations.of(context).password,
                      //errorText: snap.error
                    ),
                    autovalidate: true,
                    validator: (_) => LoginBloc.isPasswordValid(_) ? null : AmLocalizations.of(context).passwordDoesNotMeetRequirements,
                  ),
                  Container(margin: EdgeInsets.only(top: 25.0)),
                  RaisedButton(
                    onPressed: () => (state.loginStatus != LoginStatus.loading) ? loginPressed(context) : null,
                    child: Text(AmLocalizations.of(context).login, style: TextStyle(color: Colors.white),),
                    color: Colors.blue,
                  ),
                  Container(
                    child: (state.loginStatus == LoginStatus.loading) ? CircularProgressIndicator() : null,
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
