# rsa
This library provides an easy to use interface for rsa en- and decryption.

> **Warning:** This implementation has not been tested in production nor has it
> been examined by a security audit. All uses are your own responsibility.

## Usage
To obtain a `KeyPair` instance, one can call
`KeyPair.parse(String pem, {String password})`. This parses
the given pem string and creates a `KeyPair` instance with
all keys contained in this string.

### Encryption and Decryption
`KeyPair.encrypt` and `KeyPair.decrypt` accept three input types:
* `String`
* `Uint8List` and
* `int`.

Both methods work as described in the
[PKCS1 Standard](http://en.wikipedia.org/wiki/PKCS_1), as default
they also apply the standard _PKCS1-Padding_.If you don't want to
use padding, simply set padding to `null`.
