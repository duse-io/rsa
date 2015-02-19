library rsa.pkcs1;

import 'dart:math' show pow, max;
import 'dart:typed_data' show Uint8List;

import 'package:bignum/bignum.dart';

import 'rsa_key.dart';

int _bigIntToInt(BigInteger big) {
  return int.parse(big.toString());
}

Uint8List i2osp(BigInteger x, int len) {
  if (null != len && x >= new BigInteger(256).pow(len))
    throw new ArgumentError("integer too large");
  
  var b;
  var buffer = new List<int>();
  while (x > new BigInteger(0)) {
    b = x.and(new BigInteger(0xFF));
    x = x.shiftRight(8);
    buffer.add(_bigIntToInt(b));
  }
  
  var difference = max(0, len - buffer.length);
  buffer.addAll(new List.filled(difference, 0));
  buffer = buffer.reversed.toList();
  return new Uint8List.fromList(buffer);
}

BigInteger os2ip(Uint8List x) {
  return x.fold(new BigInteger(0), (BigInteger n, b) => (n.shiftLeft(8)) + new BigInteger(b));
}

BigInteger rsaep(Key k, BigInteger m) {
  if (m < new BigInteger(0) || m >= k.n)
    throw new ArgumentError("message representative out of range");
  var c = m.modPow(k.e, k.n);
  return c;
}

BigInteger rsadp(Key k, BigInteger c) {
  if (c < new BigInteger(0) || c >= k.n)
    throw new ArgumentError("ciphertext representative out of range");
  var s = c.modPow(k.d, k.n);
  return s;
}

BigInteger rsasp1(Key k, BigInteger m) {
  if (m < new BigInteger(0) || m >= k.n)
    throw new ArgumentError("message representative out of range");
  var s = m.modPow(k.d, k.n);
  return s;
}

BigInteger rsavp1(Key k, BigInteger s) {
  if (s < new BigInteger(0) || s >= k.n)
    throw new ArgumentError("signature representative out of range");
  var m = s.modPow(k.e, k.n);
  return m;
}