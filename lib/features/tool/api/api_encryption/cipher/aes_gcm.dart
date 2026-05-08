import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Uint8List aesGCM({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
  required int macSize,
  Uint8List? aad,
}) {
  assert([16, 24, 32].contains(key.length), 'Key must be 16, 24, or 32 bytes');
  assert(iv.length == 12, 'IV must be 12 bytes for GCM');

  // Initialize GCM cipher
  final cipher = GCMBlockCipher(AESEngine())..init(
    isEncrypt,
    AEADParameters(KeyParameter(key), macSize, iv, aad ?? Uint8List(0)),
  );

  // Encrypt and include auth tag
  return cipher.process(data);
}
