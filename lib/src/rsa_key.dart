library rsa.key;

import 'dart:math' show Point;

import 'package:bignum/bignum.dart';
import 'package:rsa_pkcs/rsa_pkcs.dart' show RSAPublicKey, RSAPrivateKey;

class Key {
  final BigInteger modulus;
  final BigInteger exponent;
  
  Key(this.modulus, this.exponent);
  
  Key.fromRSAPublicKey(RSAPublicKey pubKey)
      : modulus = pubKey.modulus,
        exponent = new BigInteger(pubKey.publicExponent);
  
  Key.fromRSAPrivateKey(RSAPrivateKey privKey)
      : modulus = privKey.modulus,
        exponent = privKey.privateExponent;
  
  BigInteger get n => modulus;
  BigInteger get e => exponent;
  BigInteger get d => exponent;
  
  bool get valid => true; // TODO: Validity checking
  
  int get modulusBytesize => modulus.bitLength() ~/ 8;
  
  Point toPoint() => new Point(modulus, exponent);
}