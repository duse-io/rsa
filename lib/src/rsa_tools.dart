library rsa.tools;

import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:crypto/crypto.dart' show CryptoUtils;

const DigestStringCodec DSC = const DigestStringCodec();

class DigestToStringConverter extends Converter<Uint8List, String> {
  const DigestToStringConverter() : super();
  
  String convert(Uint8List digest) {
    var base64 = CryptoUtils.bytesToBase64(digest);
    var utf = UTF8.encode(base64);
    return new String.fromCharCodes(utf);
  }
}

class StringToDigestConverter extends Converter<String, Uint8List> {
  const StringToDigestConverter() : super();
  
  Uint8List convert(String digest) {
    var base64 = UTF8.decode(digest.codeUnits);
    var bytes = CryptoUtils.base64StringToBytes(base64);
    return new Uint8List.fromList(bytes);
  }
}

class DigestStringCodec extends Codec<Uint8List, String> {
  final encoder = const DigestToStringConverter();
  final decoder = const StringToDigestConverter();
  
  const DigestStringCodec() : super();
}

class PublicEncryptionResult {
  final signature;
  final cipher;
  
  PublicEncryptionResult(this.cipher, this.signature);
}