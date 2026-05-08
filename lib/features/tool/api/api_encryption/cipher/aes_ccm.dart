import 'dart:typed_data';

import 'package:pointycastle/export.dart';

// AES CCM (Counter with CBC-MAC) mode of encryption/decryption.
Uint8List aesCCMIV({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
}) {
  assert(
    [7, 8, 9, 10, 11, 12, 13].contains(iv.length),
    "Nonce length must be between 7 and 13 bytes.",
  );

  final cipher = BlockCipher('AES/CCM');
  cipher.init(isEncrypt, ParametersWithIV<KeyParameter>(KeyParameter(key), iv));
  final cipherText = cipher.process(data);
  return cipherText;
}

Uint8List aesCCMAEAD({
  required bool isEncrypt,
  required Uint8List key,
  required Uint8List nonce,
  required Uint8List data,
  required Uint8List aad,
  required int authTagLength,
}) {
  assert(
    [7, 8, 9, 10, 11, 12, 13].contains(nonce.length),
    "Nonce length must be between 7 and 13 bytes.",
  );
  assert(
    [4, 6, 8, 10, 12, 14, 16].contains(authTagLength),
    "Auth tag length must be one of: 4, 6, 8, 10, 12, 14, or 16 bytes.",
  );

  final cipher = BlockCipher('AES/CCM');
  final macSize = authTagLength * 8;
  cipher.init(
    isEncrypt,
    AEADParameters(KeyParameter(key), macSize, nonce, aad),
  );
  final cipherText = cipher.process(data);
  return cipherText;
}
