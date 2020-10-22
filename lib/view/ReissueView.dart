import 'package:flutter/material.dart';
import 'package:login_mod/domain/Crypto.dart';
import 'package:login_mod/domain/SignIn.dart';
import 'package:login_mod/repository/db/LoginDao.dart';

/**
 * ワンタイムパスワード入力画面
 * ※当コンポーネントではサーバ接続をしていないため、ワンタイムパスワードは画面のみ。
 * 入力値にかかわらず次画面への遷移が可能。
 */
class ReissueView extends StatefulWidget {
  ReissueView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReissueViewState createState() => _ReissueViewState();
}

/**
 * ワンタイムパスワード入力画面Stateクラス
 */
class _ReissueViewState extends State<ReissueView> {
  int _counter = 0;
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /**
   * ウィジェット生成
   * @param context　ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {
    String loginId = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ワンタイムパスワード入力'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ワンタイムパスワード入力フォーム
            Container(
              margin: EdgeInsets.only(
                top: 100.0,
                left: 50.0,
                right: 50.0,
              ),
              child: TextFormField(
                controller: otpController,
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
                  labelText: 'ワンタイムパスワード',
                ),
              ),
            ),

            // ボタン部
            // パスワード設定画面へ遷移するボタン
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: (() {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pushReplacementNamed('/setNewPw',
                          arguments: loginId);
                    }
                  }),
                  child: Text(
                    '次へ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // キャンセルボタン
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: (() {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
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
