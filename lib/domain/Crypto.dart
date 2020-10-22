import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

/**
 * 暗号化実装クラス
 */
class Crypto {
  final key = Key.fromUtf8('00000000000000000000000000000000');
  final iv = IV.fromUtf8('0123456789abcdef');

  /**
   * 暗号化処理
   * @param target 暗号化対象文字列
   * @return 暗号化済文字列
   */
  String targetEncrypt(String target) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(target, iv: iv);
    return decToHex(encrypted.bytes);
  }

  /**
   * 複合処理
   * @param 暗号化済み文字列
   * @return 複合文字列
   */
  String targetDecrypt(String target) {
    List<int> lists = hexToDec(target);
    Encrypted encrypted = Encrypted(Uint8List.fromList(lists));
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  /**
   * バイト配列-Hex文字変換処理
   * @param バイト配列
   * @return バイト配列をHex変換したもの
   */
  String decToHex(List<int> targets) {
    String hex = "";
    for (int target in targets) {
      String dec = "0" + target.toRadixString(16);
      hex += dec.substring(dec.length - 2, dec.length);
    }
    return hex;
  }

  /**
   * Hex文字-バイト配列変換処理
   * @param Hex文字列
   * @return バイト配列
   */
  List<int> hexToDec(String target) {
    List<int> decs = [];
    for (int i = 0; i < target.length; i += 2) {
      int dec = int.parse("0x${target.substring(i, i + 2)}");
      decs.add(dec);
    }
    return decs;
  }
}
