import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Uint8List aesCTR({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
}) {
  assert([16, 24, 32].contains(key.length), 'Key must be 16, 24, or 32 bytes');
  assert(iv.length == 16, 'IV must be 16 bytes');

  final cipher = StreamCipher('AES/CTR')
    ..init(isEncrypt, ParametersWithIV(KeyParameter(key), iv));

  return cipher.process(data);
}
