import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class Crypto {
  final key = Key.fromUtf8('00000000000000000000000000000000');
  final iv = IV.fromUtf8('0123456789abcdef');

  String targetEncrypt(String target) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(target, iv: iv);
    return decToHex(encrypted.bytes);
  }

  String targetDecrypt(String target) {
    List<int> lists = hexToDec(target);
    Encrypted encrypted = Encrypted(Uint8List.fromList(lists));
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt(encrypted, iv: iv);
  }

  String decToHex(List<int> targets) {
    String hex = "";
    for (int target in targets) {
      String dec = "0" + target.toRadixString(16);
      hex += dec.substring(dec.length - 2, dec.length);
    }
    return hex;
  }

  List<int> hexToDec(String target) {
    List<int> decs = [];
    for (int i = 0; i < target.length; i += 2) {
      int dec = int.parse("0x${target.substring(i, i + 2)}");
      decs.add(dec);
    }
    return decs;
  }
}
