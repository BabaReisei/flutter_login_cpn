import 'package:flutter/material.dart';

/**
 * ログイン後画面
 * ※コンポーネントに無関係の画面であるため、空の画面を設定
 */
class TopPageView extends StatelessWidget {
  TopPageView({Key key, this.title}) : super(key: key);
  final String title;

  /**
   * ウィジェット生成
   * @param context ビルドコンテキスト
   * @return ウィジェット
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TopPage'),
      ),
      body: Center(),
    );
  }
}
