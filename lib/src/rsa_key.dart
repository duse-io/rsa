library rsa.key;

import 'dart:math' show Point;
import 'package:bignum/bignum.dart';
import 'package:rsa_pkcs/rsa_pkcs.dart' show RSAPublicKey, RSAPrivateKey;

class Key {
  final int modulus;
  final int exponent;
  
  Key(this.modulus, this.exponent);
  
  Key.fromRSAPublicKey(RSAPublicKey pubKey)
      : modulus = _bigIntToInt(pubKey.modulus),
        exponent = pubKey.publicExponent;
  
  Key.fromRSAPrivateKey(RSAPrivateKey privKey)
      : modulus = _bigIntToInt(privKey.modulus),
        exponent = _bigIntToInt(privKey.privateExponent);
  
  int get n => modulus;
  int get e => exponent;
  int get d => exponent;
  
  bool get valid => true; // TODO: Validity checking
  
  Point toPoint() => new Point(modulus, exponent);
  
  static int _bigIntToInt(BigInteger big) {
    return int.parse(big.toString());
  }
}