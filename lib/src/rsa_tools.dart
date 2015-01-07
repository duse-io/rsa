library rsa.tools;

import 'dart:convert' show UTF8;
import 'package:crypto/crypto.dart' show CryptoUtils;

String utfToBinary(String binaryString) {
  var base64 = UTF8.decode(binaryString.codeUnits);
  var asciiCodes = CryptoUtils.base64StringToBytes(base64);
  return new String.fromCharCodes(asciiCodes);
}

String binaryToUtf(String utfString) {
  var base64 = CryptoUtils.bytesToBase64(utfString.codeUnits);
  var utf = new String.fromCharCodes(UTF8.encode(base64));
  return utf;
}