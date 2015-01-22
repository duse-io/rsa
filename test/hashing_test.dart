library rsa.test.hashing;

import 'dart:typed_data' show Uint8List;

import 'package:rsa/rsa.dart';
import 'package:unittest/unittest.dart';


hashingTests() {
  group("EmsaEncode", () {
    var str = "This is a test";
    var data = new Uint8List.fromList(str.codeUnits);
    var test = emsaEncode(data, data.length);
  });
}