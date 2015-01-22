library test.rsa.pkcs1;

import "dart:typed_data" show Uint8List;

import "dart:math" show pow;

import "package:rsa/rsa.dart";
import "package:unittest/unittest.dart";

pkcs1Test() {
  group("i2osp", () {
    test("Simple conversion", () {
      var str1 = i2osp(256, 2);
      var str2 = i2osp(3, 2);
      
      expect(str1, equals([1, 0]));
      expect(str2, equals([0, 3]));
    });
    
    test("Too big integer conversion", () {
      expect(() => i2osp(256, 1), throws);
    });
  });
  
  group("os2ip", () {
    test("Simple conversion", () {
      var i = os2ip(new Uint8List.fromList([1, 255]));
      
      expect(i, equals(511));
    });
  });
  
  group("rsaep", () {
    test("Encryption", () {
      var encrypted = rsaep(new Key(6, 5), 4);
      expect(encrypted, equals(pow(4, 5) % 6));
    });
    
    test("Invalid message", () {
      expect(() => rsaep(new Key(6, 5), 10), throws);
      expect(() => rsaep(new Key(6, 5), -10), throws);
    });
  });
  
  group("rsadp", () {
    test("Decryption", () {
      var decrypted = rsadp(new Key(35, 5), 4);
      expect(decrypted, equals(pow(4, 5) % 35));
    });
    
    test("Invalid cipher", () {
      expect(() => rsadp(new Key(6, 5), 10), throws);
      expect(() => rsadp(new Key(6, 5), -10), throws);
    });
  });
  
  group("Integration", () {
    test("i2osp > os2ip", () {
      expect(os2ip(i2osp(256, 2)), equals(256));
    });
    
    test("os2ip > i2osp", () {
      var os = new Uint8List.fromList([25, 31, 12]);
      
      expect(i2osp(os2ip(os), 3), equals(os));
    });
    
    test("rsaep > rsadp", () {
      var n = 143;
      var e = 23;
      var d = 47;
      var privKey = new Key(n, d);
      var pubKey = new Key(n, e);
      
      expect(rsadp(privKey, rsaep(pubKey, 21)), equals(21));
    });
  });
}