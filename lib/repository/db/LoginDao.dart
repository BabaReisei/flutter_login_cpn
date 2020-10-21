import 'package:login_mod/repository/names/LoginNames.dart';
import 'package:sqflite/sqflite.dart';

import 'DbFactory.dart';

class LoginDao extends DbFactory {
  //コンストラクタ
  LoginDao() {}

  /**
   * Database 接続処理
   * <ul>
   *   <li>DBとの接続</li>
   *   <li>テーブル生成</li>
   *   <li>  ※テーブルが存在しない場合</li>
   * </ul>
   * @return DBインスタンスをFuture型で返却
   */
  Future<Database> connectDb() async {
    // DB接続済みのインスタンスを呼び出し元へ返却
    return await dbOpen(
        LoginNames().CREATE_TABLE_LOGIN, LoginNames().DB_FILE_NAME);
  }

  /**
   * メモの登録処理
   * <ul>
   *   <li>新規メモをDBへ登録</li>
   * </ul>
   * @param memo 新規メモ
   */
  @override
  Future<void> save(var user) async {
    // DB接続
    Database db = await connectDb();

    // 登録処理を行う
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // DB切断
    db.close();
  }

  /**
   * ログインIDの有無取得処理
   * <ul>
   *   <li>重複するログインIDの有無を確認する。</li>
   * </ul>
   * @param loginId 取得するレコードのログインID
   * @return 引数loginIdのユーザ件数をFuture型で返却
   */
  @override
  Future<int> count(var loginId) async {
    // DB接続
    Database db = await connectDb();
    return Sqflite.firstIntValue(await db
        .rawQuery("select count(*) from user where login_id = '$loginId'"));
  }

  /**
   * ログインIDの取得処理
   * <ul>
   *   <li>重複するログインんIDの有無を確認する。</li>
   *   <li>取得したメモはListに格納される</li>
   * </ul>
   * @param loginId 取得するレコードのログインID
   * @return 取得したユーザのリストをFuture型で返却
   */
  @override
  Future<User> get(var loginId) async {
    // DB接続
    Database db = await connectDb();

    // メモをMapで取得
    int num = await count(loginId);
    if (num == 0) {
      return null;
    }
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from user where login_id = '$loginId'");

    // 取得したメモのMapをVO型へ変換し呼び出し元へ返却
    return User(
      id: maps[0]['id'],
      loginId: maps[0]['login_id'],
      loginPw: maps[0]['login_pw'],
      email: maps[0]['email'],
    );
  }

  /**
   * 全ユーザの取得処理
   * <ul>
   *   <li>DBからユーザを取得</li>
   *   <li>取得したメモはListに格納される</li>
   * </ul>
   * @return 取得したメモのリストをFuture型で返却
   */
  @override
  Future<List<User>> getAll() async {
    // DB接続
    Database db = await connectDb();

    // メモをMapのListで取得
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from user");

    // 取得したメモのMapをVO型へ変換し呼び出し元へ返却
    List<User> users = List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        loginId: maps[i]['login_id'],
        loginPw: maps[i]['login_pw'],
        email: maps[i]['email'],
      );
    });
    return users;
  }

  // ユーザ情報の更新
  @override
  Future<void> update(var user) async {
    Database db = await connectDb();
    await db.update(
      'user',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  // ユーザ情報の削除
  @override
  Future<void> delete(int id) async {
    Database db = await connectDb();
    await db.delete(
      'user',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

/** Mapper */
class User {
  final int id;
  final String loginId;
  final String loginPw;
  final String email;

  User({this.id, this.loginId, this.loginPw, this.email});

  // Mapへ設定する
  Map<String, dynamic> toMap() {
    return {'id': id, 'login_id': loginId, 'login_pw': loginPw, 'email': email};
  }
}
