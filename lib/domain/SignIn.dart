import 'package:login_mod/domain/Crypto.dart';
import 'package:login_mod/repository/db/LoginDao.dart';

class SignIn {
  SignIn({this.loginId, this.loginPw});

  final String loginId;
  final String loginPw;

  Future<bool> check() async {
    LoginDao dao = new LoginDao();
    Crypto crypto = new Crypto();
    var user = await dao.get(loginId.trim());
    if (user != null && user.loginPw == crypto.targetEncrypt(loginPw)) {
      return true;
    }
    return false;
  }
}
