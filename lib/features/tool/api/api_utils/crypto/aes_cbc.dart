import 'dart:typed_data';

import 'package:pointycastle/export.dart';

// Cipher Block Chaining (CBC) mode of AES encryption/decryption.
Uint8List aesCBC({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
}) {
  assert(
    [128, 192, 256].contains(key.length * 8),
    "Key length must be 128, 192, or 256 bits (16, 24, or 32 bytes).",
  );
  assert(128 == iv.length * 8, "IV length must be 128 bits (16 bytes).");

  final params = ParametersWithIV<KeyParameter>(KeyParameter(key), iv);
  final paddingParams =
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        params,
        null,
      );
  final cipher = CBCBlockCipher(AESEngine());
  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher)
    ..init(isEncrypt, paddingParams);
  return paddingCipher.process(data);
}
