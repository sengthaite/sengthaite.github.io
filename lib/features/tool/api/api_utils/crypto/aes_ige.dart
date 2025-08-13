import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Encrypts data using AES in IGE mode
///
/// Parameters:
/// - plaintext: The data to encrypt (must be padded to block size)
/// - key: Must be 16, 24, or 32 bytes for AES-128, AES-192, or AES-256
/// - iv: Must be 32 bytes (2 * block size for IGE mode)
Uint8List aesIGE({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
}) {
  assert([16, 24, 32].contains(key.length), 'Key must be 16, 24, or 32 bytes');
  assert(iv.length == 32, 'IV must be 32 bytes for IGE');

  final parameters = ParametersWithIV(KeyParameter(key), iv);
  final paddingParams =
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        parameters,
        null,
      );
  var cipher = BlockCipher('AES/IGE');
  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher)
    ..init(isEncrypt, paddingParams);
  return paddingCipher.process(data);
}
