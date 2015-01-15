library test.rsa.tools;

import 'dart:typed_data' show Uint8List;

import 'package:rsa/rsa.dart';
import 'package:unittest/unittest.dart';

toolsTest() {
  group("DigestStringCodec", () {
    test("Equality", () {
      var test1 = new Uint8List.fromList([0, 0, 1, 2, 5, 8, 11]);
      var test2 = "s4ZZIPFyjMpv104mVKF8BEXyDmnN53OsI80sqWd5OJ7nB"
          + "pgfTznvqIV23k7fWgZBz6TyBsJXiqmROWhyxaZMsA==";
      
      expect(DSC.decode(DSC.encode(test1)), equals(test1));
      expect(DSC.encode(DSC.decode(test2)), equals(test2));
    });
  });
  
  group("emsaEncoding", () {
    test("Equality", () {
      var test = "s4ZZIPFyjMpv104mVKF8BEXyDmnN53OsI80sqWd5OJ7nB"
          + "pgfTznvqIV23k7fWgZBz6TyBsJXiqmROWhyxaZMsA==";
      expect(emsaEncode(DSC.decode(test), test.length),
      equals(emsaEncode(DSC.decode(test), test.length)));
    });
  });
}