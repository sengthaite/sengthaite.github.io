import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// AES CFB (Cipher Feedback) mode of encryption/decryption.
Uint8List aesCFB({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
  int blockSize = 8,
}) {
  final parameters = ParametersWithIV(KeyParameter(key), iv);
  final paddingParams =
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
        parameters,
        null,
      );
  var cipher = BlockCipher('AES/CFB-$blockSize');
  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher)
    ..init(isEncrypt, paddingParams);
  return paddingCipher.process(data);
}
