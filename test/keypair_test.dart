library test.rsa.keypair;

import 'package:rsa/rsa.dart';
import 'package:unittest/unittest.dart';

keyPairTest() {
  group("RSA KeyPair", () {
    var publicKey = new Key(3233, 17);
    var privateKey = new Key(3233, 2753);
    var keyPair = new KeyPair(privateKey, publicKey);
  });
}