// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library rsa.test;

import 'dart:typed_data' show Uint8List;
import 'package:rsa/rsa.dart';
import 'package:unittest/unittest.dart';

main() {
  var pubkey =
    """-----BEGIN PUBLIC KEY-----
MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANg8PKyzt2ehAg+UfKIBIBC6SU2GvaHv
1Dc1e5HVweYbEjhM08AfYoMSpe8VzwA/YsT2uDW7s+qZQJ+H5YP6aZECAwEAAQ==
-----END PUBLIC KEY-----""";
  var privkey =
    """-----BEGIN RSA PRIVATE KEY-----
MIIBOwIBAAJBANg8PKyzt2ehAg+UfKIBIBC6SU2GvaHv1Dc1e5HVweYbEjhM08Af
YoMSpe8VzwA/YsT2uDW7s+qZQJ+H5YP6aZECAwEAAQJBAKDCL82pkrnNXu3cU8hR
k9g71pF3kfYZiik9bs/eHliF+8CnZqrKOF3Ys7FqWCAbrsOQC1wWNjIaAWfpVtX7
4AECIQDzEDobsU+I8JaYPs2Gy1H54OkyUDADm+T7tBdt4bc/kQIhAOO+eTtZPk7V
vOXbH/VjRo7rXMcVsSut8iPRlwzYj4oBAiB+Tohjq5gxCRS4uKoEydMnjoCf7JuG
xJQRWFx0dT7MgQIgaH+Ccvfs/hFWnoVf8aF+w589L+BFLgyfeU33KB7KJgECIQCS
6JXBqbe3BftpS7otUsuZAdRijbeU60OGGwhsVX0pEw==
-----END RSA PRIVATE KEY-----""";
  
  
  test("en- and decryption", () {
    var public = KeyPair.parsePem(pubkey);
    var private = KeyPair.parsePem(privkey);
    
    var encr = public.encrypt("test");
    var decr = private.decrypt(encr);
    
    print(encode(encr));
    
    expect(new String.fromCharCodes(decr), equals("test"));
  });
}
