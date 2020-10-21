import 'package:flutter/material.dart';
import 'package:login_mod/view/LoginView.dart';
import 'package:login_mod/view/ReissueView.dart';
import 'package:login_mod/view/SetNewPwView.dart';
import 'package:login_mod/view/SignUpView.dart';
import 'package:login_mod/view/TopPageView.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LoginMod',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginView(title: 'Login'),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new LoginView(),
          '/signUp': (BuildContext context) => new SignUpView(),
          '/topPage': (BuildContext context) => new TopPageView(),
          '/ReissueView': (BuildContext context) => new ReissueView(),
          '/setNewPw': (BuildContext context) => new SetNewPwView(),
        });
  }
}
