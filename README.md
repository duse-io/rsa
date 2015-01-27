# rsa
[![Build Status](https://drone.io/github.com/Adracus/rsa/status.png)](https://drone.io/github.com/Adracus/rsa/latest)
[![Coverage Status](https://coveralls.io/repos/Adracus/rsa/badge.svg?branch=master)](https://coveralls.io/r/Adracus/rsa?branch=master)

This library provides an easy to use interface for rsa en- and decryption.

> **Warning:** This implementation has not been tested in production nor has it
> been examined by a security audit. All uses are your own responsibility.

## Usage
To obtain a `KeyPair` instance, one can call
`KeyPair.parse(String pem, {String password})`. This parses
the given pem string and creates a `KeyPair` instance with
all keys contained in this string.

### Encryption and Decryption
`KeyPair.encrypt` and `KeyPair.decrypt` accept two input types:
* `String`
* `Uint8List`.

The same applies for `KeyPair.sign` and `KeyPair.verify`.
If you want to encrypt and sign something, simply call `KeyPair.publicEncrypt`.
This encrypts the given argument and signs the generated cipher. The output
is a `PublicEncryptionResult`.

To decrypt and also verify the given `PublicEncryptionResult`, call
`KeyPair.privateDecrypt`. If the signature cannot be verified, this
throws an Error. otherwise, it returns the decrypted (if possible)
message.

All methods work as described in the
[PKCS1 Standard](http://en.wikipedia.org/wiki/PKCS_1), as default
they also apply the standard _PKCS1-Padding_.If you don't want to
use padding, simply set padding to `null`. The default hash method
for *EMSA_ENCODE* is _SHA256_, currently only _SHA256_, _MD5_ and
_SHA1_ are implemented.

Help and pull requests are always appreciated!
