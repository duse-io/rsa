library test.rsa.pkcs1;

import "dart:typed_data" show Uint8List;

import "package:bignum/bignum.dart";
import "package:rsa/rsa.dart";
import "package:unittest/unittest.dart";

b(int n) => new BigInteger(n);

pkcs1Test() {
  group("PKCS1", () {
    group("i2osp", () {
      test("Simple conversion", () {
        var str1 = i2osp(b(256), 2);
        var str2 = i2osp(b(3), 2);
        
        expect(str1, equals([1, 0]));
        expect(str2, equals([0, 3]));
      });
      
      test("Too big integer conversion", () {
        expect(() => i2osp(b(256), 1), throws);
      });
    });
    
    group("os2ip", () {
      test("Simple conversion", () {
        var i = os2ip(new Uint8List.fromList([1, 255]));
        
        expect(i, equals(b(511)));
      });
    });
    
    group("rsaep", () {
      test("Encryption", () {
        var encrypted = rsaep(new Key(b(6), b(5)), b(4));
        
        expect(encrypted, equals(b(4)));
      });
      
      test("Invalid message", () {
        expect(() => rsaep(new Key(b(6), b(5)), b(10)), throws);
        expect(() => rsaep(new Key(b(6), b(5)), b(-10)), throws);
      });
    });
    
    group("rsadp", () {
      test("Decryption", () {
        var decrypted = rsadp(new Key(b(35), b(5)), b(4));
        
        expect(decrypted, equals(b(9)));
      });
      
      test("Invalid cipher", () {
        expect(() => rsadp(new Key(b(6), b(5)), b(10)), throws);
        expect(() => rsadp(new Key(b(6), b(5)), b(-10)), throws);
      });
    });
    
    group("rsasp1", () {
      test("Encryption", () {
        var encrypted = rsasp1(new Key(b(6), b(5)), b(4));
        
        expect(encrypted, equals(b(4)));
      });
      
      test("Invalid message", () {
        expect(() => rsasp1(new Key(b(6), b(5)), b(10)), throws);
        expect(() => rsasp1(new Key(b(6), b(5)), b(-10)), throws);
      });
    });
    
    group("rsavp1", () {
      test("Decryption", () {
        var decrypted = rsavp1(new Key(b(35), b(5)), b(4));
              
        expect(decrypted, equals(b(9)));
      });
    });
    
    group("Integration", () {
      test("i2osp > os2ip", () {
        expect(os2ip(i2osp(b(256), 2)), equals(b(256)));
      });
      
      test("os2ip > i2osp", () {
        var os = new Uint8List.fromList([25, 31, 12]);
        
        expect(i2osp(os2ip(os), 3), equals(os));
      });
      
      test("rsaep > rsadp", () {
        var n = b(143);
        var e = b(23);
        var d = b(47);
        var privKey = new Key(n, d);
        var pubKey = new Key(n, e);
        
        expect(rsadp(privKey, rsaep(pubKey, b(21))), equals(b(21)));
      });
      
      test("rsasp1 > rsavp1", () {
        var n = b(143);
        var e = b(23);
        var d = b(47);
        var privKey = new Key(n, d);
        var pubKey = new Key(n, e);
        
        expect(rsavp1(privKey, rsasp1(pubKey, b(21))), equals(b(21)));
      });
    });
  });
}