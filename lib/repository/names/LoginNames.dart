import 'package:login_mod/route/Routing.dart';

class LoginNames {
  // プライベートコンストラクタ
  LoginNames _() {}

  // memoテーブルの生成
  final CREATE_TABLE_LOGIN = """
      CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      login_id TEXT,
      login_pw TEXT,
      email TEXT)
      """;

  // database名
  final String DB_FILE_NAME = "user.db";
}
