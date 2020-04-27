
import 'package:triviabank/bloc/login_bloc.dart';
import 'package:triviabank/util/am_localizations.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AmLocalizations.of(context).login),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            StreamBuilder<String>( // Email input
              stream: bloc.email,
              builder: (context, snap) {
                return TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: bloc.changeEmail,
                  decoration: InputDecoration(
                      labelText: AmLocalizations.of(context).emailAddress,
                      hintText: AmLocalizations.of(context).emailAddressHint,
                      errorText: snap.error
                  ),
                );
              },
            ),
            StreamBuilder<String>( // Password input
                stream: bloc.password,
                builder:(context, snap) {
                  return TextField(
                    obscureText: true,
                    onChanged: bloc.changePassword,
                    decoration: InputDecoration(
                        labelText: AmLocalizations.of(context).password,
                        hintText: AmLocalizations.of(context).password,
                        errorText: snap.error
                    ),
                  );
                }
            ),
            Container(margin: EdgeInsets.only(top: 25.0)),
            StreamBuilder<bool>( // Submit button
              stream: bloc.submitValid,
              builder: (context, snap) {
                return RaisedButton(
                  onPressed: (!snap.hasData) ? null : bloc.submit,
                  child: Text(AmLocalizations.of(context).login, style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                );
              },
            ),
            StreamBuilder<bool>( // Loading indicator
              stream: bloc.loading,
              builder: (context, snap) {
                return Container(
                  child: (snap.hasData && snap.data)
                      ? CircularProgressIndicator()
                      : null,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
