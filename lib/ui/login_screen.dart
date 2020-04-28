
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triviabank/bloc/login/login_bloc.dart';
import 'package:triviabank/bloc/login/login_event.dart';
import 'package:triviabank/bloc/login/login_state.dart';
import 'package:triviabank/bloc/login/login_status.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void loginPressed() {

    BlocProvider.of<LoginBloc>(context).add(
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

        child: BlocListener<LoginBloc, LoginState>(

          listener: (context, state) {
            if (state.loginStatus == LoginStatus.failure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },

          child: BlocBuilder<LoginBloc, LoginState>(

            builder: (context, state) => Column(

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
                  validator: (_) => state.isEmailValid ? null : AmLocalizations.of(context).emailAddressIsInvalid,
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
                  validator: (_) => state.isPasswordValid ? null : AmLocalizations.of(context).passwordDoesNotMeetRequirements,
                ),
                Container(margin: EdgeInsets.only(top: 25.0)),
                RaisedButton(
                  onPressed: () => (state.loginStatus != LoginStatus.loading) ? loginPressed() : null,
                  child: Text(AmLocalizations.of(context).login, style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                ),
                Container(
                  child: (state.loginStatus == LoginStatus.loading) ? CircularProgressIndicator() : null,
                )
              ],
            ),
          )
        )
      ),
    );
  }
}
