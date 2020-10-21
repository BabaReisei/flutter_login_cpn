import 'package:flutter/material.dart';
import 'package:login_mod/domain/Crypto.dart';
import 'package:login_mod/domain/SignIn.dart';
import 'package:login_mod/repository/db/LoginDao.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int _counter = 0;
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var pushedLoginButton = true;
/**/
    LoginDao dao = new LoginDao();
    dao.getAll().then((users) {
      Crypto crypto = new Crypto();
      for (User user in users) {
        print(
            "id: ${user.id}, loginId: ${user.loginId}, loginPw: ${crypto.targetDecrypt(user.loginPw)}, email: ${user.email}");
      }
    });
/**/

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: new Builder(builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  left: 50.0,
                  right: 50.0,
                ),
                child: TextFormField(
                  maxLength: 16,
                  controller: idController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return '必須項目です';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'ログインＩＤ',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: TextFormField(
                  controller: pwController,
                  validator: (value) {
                    if (value.isEmpty && pushedLoginButton) {
                      return '必須項目です';
                    } else if (value.isNotEmpty && !pushedLoginButton) {
                      return 'パスワード再発行時には入力しないでください';
                    } else {
                      return null;
                    }
                  },
                  maxLength: 16,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: (() {
                        pushedLoginButton = true;
                        if (_formKey.currentState.validate()) {
                          SignIn signIn = new SignIn(
                              loginId: idController.text,
                              loginPw: pwController.text);
                          signIn.check().then((flg) {
                            if (flg) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/topPage');
                            }
                          });
                        }
                      }),
                      child: Text(
                        'ログイン',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: (() {
                        pushedLoginButton = false;
                        if (_formKey.currentState.validate()) {
                          LoginDao dao = new LoginDao();
                          //print(dao.count(idController.text));
                          dao.count(idController.text).then((num) {
                            if (num == 1) {
                              Navigator.of(context).pushNamed('/ReissueView',
                                  arguments: idController.text);
                            }
                          });
                          _formKey.currentState.save();
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: Text(
                                'ログインIDが間違っています。',
                              ),
                            ),
                          );
                        }
                      }),
                      child: Text(
                        '再発行',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: (() {
                      Navigator.of(context).pushNamed('/signUp');
                    }),
                    child: Text(
                      '新規登録',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      }),
    );
  }
}
