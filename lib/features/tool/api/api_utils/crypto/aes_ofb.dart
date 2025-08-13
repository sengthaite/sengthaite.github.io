import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// Encrypts data using AES in OFB mode
///
/// Parameters:
/// - plaintext: The data to encrypt
/// - key: Must be 16, 24, or 32 bytes for AES-128, AES-192, or AES-256
/// - iv: Must be 16 bytes (128 bits) for AES block size
/// - blockSize: Feedback block size in bits (default: 128)
Uint8List aesOFB({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
  required int blockSize,
}) {
  assert([16, 24, 32].contains(key.length), 'Key must be 16, 24, or 32 bytes');
  assert(iv.length == 16, 'IV must be 16 bytes');

  final parameters = ParametersWithIV(KeyParameter(key), iv);
  final paddingParams =
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        parameters,
        null,
      );
  var cipher = OFBBlockCipher(AESEngine(), blockSize);
  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher)
    ..init(isEncrypt, paddingParams);
  return paddingCipher.process(data);
}
