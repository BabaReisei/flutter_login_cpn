import 'package:flutter/material.dart';

class TopPageView extends StatelessWidget {
  TopPageView({Key key, this.title}) : super(key: key);
  final String title;

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
