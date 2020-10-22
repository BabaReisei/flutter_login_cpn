import 'package:flutter/material.dart';
import 'package:login_mod/domain/SignUp.dart';

/**
 * 新規登録画面クラス
 */
class SignUpView extends StatefulWidget {
  SignUpView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

/**
 * 新規登録画面Stateクラス
 */
class _SignUpViewState extends State<SignUpView> {
  int _counter = 0;
  final idController = TextEditingController();
  final pwController = TextEditingController();
  final mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /**
   * ウィジェット生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var quarterSize = size.width / 8.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // ログインID入力フォーム
                Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: Text(
                    '登録項目',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: quarterSize * 2,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 30.0,
                        left: quarterSize,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Text('ログインＩＤ'),
                    ),
                    // パスワード入力フォーム
                    Container(
                      height: 50.0,
                      width: quarterSize * 4,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: 30.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                          maxLength: 16,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: idController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '必須項目です';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: quarterSize * 2,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: quarterSize,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text('パスワード'),
                    ),
                    Container(
                      height: 50.0,
                      width: quarterSize * 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                          maxLength: 16,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: pwController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '必須項目です';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // eメール入力フォーム
                    Container(
                      height: 50.0,
                      width: quarterSize * 2,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: quarterSize,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text('eメール'),
                    ),
                    Container(
                      height: 50.0,
                      width: quarterSize * 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          controller: mailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return '必須項目です';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 登録ボタン
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: (() {
                          if (_formKey.currentState.validate()) {
                            SignUp signUp = SignUp(idController.text,
                                pwController.text, mailController.text);
                            signUp.registration().then((flg) {
                              if (!flg) {
                                _formKey.currentState.save();
                                print('ID重複');
                                Scaffold.of(context).showSnackBar(
                                  new SnackBar(
                                    content: Text(
                                      'IDが重複しています。',
                                    ),
                                  ),
                                );
                              } else {
                                _formKey.currentState.save();
                                // 登録完了ダイアログ
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
                                            onPressed: () => Navigator.of(
                                                    context)
                                                .pushReplacementNamed('/login'),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            });
                          }
                        }),
                        child: Text(
                          '登録',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // キャンセルボタン
                    Container(
                      child: RaisedButton(
                        onPressed: (() {
                          Navigator.of(context).pop();
                        }),
                        color: Colors.blue,
                        child: Text(
                          'キャンセル',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
