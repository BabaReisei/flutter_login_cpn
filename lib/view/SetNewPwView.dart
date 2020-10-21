import 'package:flutter/material.dart';
import 'package:login_mod/domain/Crypto.dart';
import 'package:login_mod/repository/db/LoginDao.dart';

class SetNewPwView extends StatefulWidget {
  SetNewPwView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SetNewPwViewState createState() => _SetNewPwViewState();
}

class _SetNewPwViewState extends State<SetNewPwView> {
  final _formKey = GlobalKey<FormState>();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String loginId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('パスワード再設定'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 100.0,
                left: 50.0,
                right: 50.0,
              ),
              child: TextFormField(
                controller: pwController,
                validator: (value) {
                  if (value.isEmpty) {
                    return '必須項目です';
                  } else {
                    return null;
                  }
                },
                maxLength: 16,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '新パスワード',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: (() {
                    if (_formKey.currentState.validate()) {
                      LoginDao dao = new LoginDao();
                      Crypto crypto = new Crypto();
                      print("loginId = $loginId");
                      dao.get(loginId).then((user) {
                        print("user=$user");
                        User newPwUser = new User(
                          id: user.toMap()['id'],
                          loginId: loginId,
                          loginPw: crypto.targetEncrypt(pwController.text),
                          email: user.toMap()['email'],
                        );
                        dao.update(newPwUser);
                      });
                      _formKey.currentState.save();
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(
                                '登録完了',
                              ),
                              content: Text('登録が完了しました。'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('ログイン画面へ'),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed('/login'),
                                ),
                              ],
                            );
                          });
                    }
                  }),
                  child: Text(
                    '更新',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: (() {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
                    }),
                    child: Text(
                      'キャンセル',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
