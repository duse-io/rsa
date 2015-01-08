library rsa.tools;

import 'dart:convert' show UTF8, LATIN1;
import 'dart:typed_data' show Uint8List;
import 'package:crypto/crypto.dart' show CryptoUtils;

String encode(Uint8List cipher) {
  var base64 = CryptoUtils.bytesToBase64(cipher);
  var utf = UTF8.encode(base64);
  return new String.fromCharCodes(utf);
}

Uint8List decode(String cipher) {
  var base64 = UTF8.decode(cipher.codeUnits);
  var bytes = CryptoUtils.base64StringToBytes(base64);
  return new Uint8List.fromList(bytes);
}