import 'package:login_mod/domain/Crypto.dart';
import 'package:login_mod/repository/db/LoginDao.dart';

/**
 * 新規ユーザ登録実装クラス
 */
class SignUp {
  SignUp(this.loginId, this.loginPw, this.email);

  final String loginId;
  final String loginPw;
  final String email;

  /**
   * 新規ユーザ登録処理
   * @return 登録結果をFuture型で返却
   */
  Future<bool> registration() async {
    LoginDao dao = new LoginDao();
    var user = await dao.get(loginId.trim());
    if (user == null) {
      Crypto crypto = new Crypto();
      dao.save(User(
          loginId: loginId,
          loginPw: crypto.targetEncrypt(loginPw.trim()),
          email: email.trim()));
      return true;
    } else {
      return false;
    }
  }
}
