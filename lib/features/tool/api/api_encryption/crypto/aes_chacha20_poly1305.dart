import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Uint8List chacha20Poly1305IV({
  required bool isEncrypt,
  required Uint8List data,
  required Uint8List key,
  required Uint8List iv,
}) {
  assert(
    [7, 8, 9, 10, 11, 12, 13].contains(iv.length),
    "Nonce length must be between 7 and 13 bytes.",
  );
  final ChaCha20Poly1305 cipher =
      AEADCipher('ChaCha20-Poly1305') as ChaCha20Poly1305;
  cipher.init(isEncrypt, ParametersWithIV<KeyParameter>(KeyParameter(key), iv));

  final output = Uint8List(cipher.getOutputSize(data.length));
  final len = cipher.processBytes(data, 0, data.length, output, 0);
  cipher.doFinal(output, len);
  return output;
}

Uint8List chacha20Poly1305AEAD({
  required bool isEncrypt,
  required Uint8List key,
  required Uint8List nonce,
  required Uint8List data,
  required Uint8List aad,
}) {
  assert(
    [7, 8, 9, 10, 11, 12, 13].contains(nonce.length),
    "Nonce length must be between 7 and 13 bytes.",
  );
  final cipher = AEADCipher('ChaCha20-Poly1305');
  final macSize = 16 * 8;
  cipher.init(
    isEncrypt,
    AEADParameters(KeyParameter(key), macSize, nonce, aad),
  );

  final output = Uint8List(cipher.getOutputSize(data.length));
  final len = cipher.processBytes(data, 0, data.length, output, 0);
  cipher.doFinal(output, len);

  return output;
}
