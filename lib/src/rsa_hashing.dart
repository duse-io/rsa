library rsa.hashing;

import 'dart:typed_data' show Uint8List;
import 'dart:math' show max;

import 'package:crypto/crypto.dart' as crypto;

abstract class HashFunction {
  List<int> get id;
  List<int> hash(List<int> data);
  
  const HashFunction();
  
  List<int> digestInfo(Uint8List data) {
    var info = []..addAll(id)..addAll(hash(data));
    return info;
  }
}

class MD5 extends HashFunction {
  List<int> get id => [0x30, 0x20, 0x30, 0x0c, 0x06, 0x08, 0x2a, 0x86, 0x48,
                       0x86, 0xf7, 0x0d, 0x02, 0x05, 0x05, 0x00, 0x04, 0x10];
  
  const MD5();
  
  List<int> hash(List<int> data) {
    var md5 = new crypto.MD5();
    md5.add(data);
    return md5.close();
  }
}

class SHA1 extends HashFunction {
  List<int> get id => [0x30, 0x21, 0x30, 0x09, 0x06, 0x05, 0x2b, 0x0e, 0x03,
                       0x02, 0x1a, 0x05, 0x00, 0x04, 0x14];
  
  const SHA1();
  
  List<int> hash(List<int> data) {
    var sha1 = new crypto.SHA1();
    sha1.add(data);
    return sha1.close();
  }
}

class SHA256 extends HashFunction {
  List<int> get id =>  [0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86, 0x48,
                        0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05, 0x00, 0x04,
                        0x20];
  
  const SHA256();
  
  List<int> hash(List<int> data) {
    var sha256 = new crypto.SHA256();
    sha256.add(data);
    return sha256.close();
  }
}


Uint8List emsaEncode(Uint8List data, int length,
                     {HashFunction hashFunction: const SHA256()}) {
  var t = hashFunction.digestInfo(data);
  if (length < t.length + 11) throw new ArgumentError.value(data);
  var ps = new List.filled(max(length - t.length -3, 8), 0xff);
  var em = [0x00, 0x01]..addAll(ps)..add(0x00)..addAll(t);
  return em;
}