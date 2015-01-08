library rsa.keypar;

import 'dart:typed_data' show Uint8List;

import 'rsa_key.dart';
import 'rsa_math.dart' as Math;
import 'rsa_pkcs1.dart' as PKCS1;
import 'rsa_padding.dart';

import 'package:rsa_pkcs/rsa_pkcs.dart' show RSAPKCSParser;


class KeyPair {
  final Key privateKey;
  final Key publicKey;
  
  Key get private => privateKey;
  Key get public => publicKey;
  
  KeyPair(this.privateKey, this.publicKey);
  
  static KeyPair parsePem(String pem, [String password]) {
    var parser = new RSAPKCSParser();
    var pair = parser.parsePEM(pem, password: password);
    var private = null;
    var public = null;
    if (null != pair.private)
      private = new Key.fromRSAPrivateKey(pair.private);
    if (null != pair.public)
      public = new Key.fromRSAPublicKey(pair.public);
    return new KeyPair(private, public);
  }
  
  bool get hasPrivateKey => null != privateKey;
  bool get hasPublicKey => null != publicKey;
  
  int get modulus =>
      null != privateKey ? privateKey.modulus : publicKey.modulus;
  int get n => modulus;
  
  bool get valid => privateKey.valid && publicKey.valid;
  
  int get bytesize => Math.log256(modulus).ceil();
  
  int get bitsize => Math.log2(modulus).ceil();
  int get size => bitsize;
  
  encrypt(plainText, {Padding padding: PKCS1_PADDING}) {
    if (plainText is int) return _encryptInteger(plainText);
    if (plainText is String)
      plainText = new Uint8List.fromList(plainText.codeUnits);
    if (plainText is Uint8List) {
      if (null != padding) plainText = padding.apply(plainText, bytesize);
      return PKCS1.i2osp(_encryptInteger(PKCS1.os2ip(plainText)),
          bytesize);
    }
    throw new ArgumentError.value(plainText);
  }
  
  decrypt(cipherText, {Padding padding: PKCS1_PADDING}) {
    if (cipherText is int) return _decryptInteger(cipherText);
    if (cipherText is String)
      cipherText = new Uint8List.fromList(cipherText.codeUnits);
    if (cipherText is Uint8List) {
      cipherText = PKCS1.i2osp(_decryptInteger(PKCS1.os2ip(cipherText)),
          bytesize);
      if (null != padding) cipherText = padding.strip(cipherText);
      return cipherText;
    }
    throw new ArgumentError.value(cipherText);
  }
  
  sign(plainText) {
    if (plainText is int) return _signInteger(plainText);
    if (plainText is String)
      plainText = new Uint8List.fromList(plainText.codeUnits);
    if (plainText is Uint8List)
      return PKCS1.i2osp(_signInteger(PKCS1.os2ip(plainText)), 
          bytesize);
    throw new ArgumentError.value(plainText);
  }
  
  bool verify(signature, plainText) {
    if (signature is! int && signature is! Uint8List)
      throw new ArgumentError.value(signature);
    if (plainText is! int && plainText is! Uint8List)
      throw new ArgumentError.value(plainText);
    if (signature is Uint8List) signature = PKCS1.os2ip(signature);
    if (plainText is Uint8List) plainText = PKCS1.os2ip(plainText);
    return _verifyInteger(signature, plainText);
  }
  
  int _encryptInteger(int plainText) => PKCS1.rsaep(publicKey, plainText);
  
  int _decryptInteger(int cipherText) => PKCS1.rsadp(privateKey, cipherText);
  
  int _signInteger(int plainText) => PKCS1.rsasp1(privateKey, plainText);
  
  bool _verifyInteger(int signature, int plainText) =>
      PKCS1.rsavp1(publicKey, signature) == plainText;
}