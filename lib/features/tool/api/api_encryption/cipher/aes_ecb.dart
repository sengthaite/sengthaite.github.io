import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Uint8List aesECB({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
}) {
  assert([16, 24, 32].contains(key.length), 'Key must be 16, 24, or 32 bytes');

  final parameters = KeyParameter(key);
  final paddingParams = PaddedBlockCipherParameters<KeyParameter, Null>(
    parameters,
    null,
  );
  var cipher = BlockCipher('AES/ECB');
  final paddingCipher = PaddedBlockCipherImpl(PKCS7Padding(), cipher)
    ..init(isEncrypt, paddingParams);
  return paddingCipher.process(data);
}
