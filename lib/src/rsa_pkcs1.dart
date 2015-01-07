library rsa.pkcs1;

import 'dart:math' show pow;
import 'dart:convert' show UTF8, ASCII;
import 'package:rsa/src/rsa_key.dart';
import 'package:rsa/src/rsa_math.dart' as Math;

String i2osp(int x, [int len]) {
  if (null != len && x >= pow(256, len))
    throw new ArgumentError("integer too large");
  
  var b;
  var buffer = new List<int>();
  while (x > 0) {
    b = x & 0xFF;
    x >>= 8;
    buffer.add(b);
  }
  
  var s = new String.fromCharCodes(buffer.reversed);
  if (null != len) s = s.padLeft(len, "\0");
  return s;
}

int os2ip(String x) {
  var bytes = x.codeUnits;
  return bytes.fold(0, (int n, b) => (n << 8) + b);
}

int rsaep(Key k, int m) {
  if (m < 0 || m >= k.n)
    throw new ArgumentError("message representative out of range");
  var c = Math.modPow(m, k.e, k.n);
  return c;
}

int rsadp(Key k, int c) {
  if (c < 0 || c >= k.n)
    throw new ArgumentError("ciphertext representative out of range");
  var s = Math.modPow(c, k.d, k.n);
  return s;
}

int rsasp1(Key k, int m) {
  if (m < 0 || m >= k.n)
    throw new ArgumentError("message representative out of range");
  var s = Math.modPow(m, k.d, k.n);
  return s;
}

int rsavp1(Key k, int s) {
  if (s < 0 || s >= k.n)
    throw new ArgumentError("signature representative out of range");
  var m = Math.modPow(s, k.e, k.n);
  return m;
}