library test.rsa.keypair;

import 'package:rsa/rsa.dart';
import 'package:unittest/unittest.dart';

keyPairTest(KeyPair keyPair) {
  group("RSA KeyPair", () {
    test("Integration: Public Encrypt + Decrypt", () {
      var encrypted = keyPair.publicEncrypt("This is a secret");
      var decrypt = keyPair.privateDecrypt(encrypted);
      
      expect(decrypt, equals("This is a secret"));
    });
  });
}