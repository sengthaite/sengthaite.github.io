import "dart:typed_data";

import "package:pointycastle/export.dart";

Uint8List rsa({
  required bool isEncrypt,
  required RSAAsymmetricKey key,
  required Uint8List data,
}) {
  AsymmetricKeyParameter<RSAAsymmetricKey> keyParams;

  if (isEncrypt) {
    keyParams = PublicKeyParameter<RSAPublicKey>(key as RSAPublicKey);
  } else {
    keyParams = PrivateKeyParameter<RSAPrivateKey>(key as RSAPrivateKey);
  }

  final engine = RSAEngine()..init(isEncrypt, keyParams);

  final numBlocks = data.length ~/ engine.inputBlockSize +
      ((data.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < data.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= data.length)
        ? engine.inputBlockSize
        : data.length - inputOffset;

    outputOffset += engine.processBlock(
      data,
      inputOffset,
      chunkSize,
      output,
      outputOffset,
    );

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}

Uint8List rsaOAEP({
  required bool isEncrypt,
  required RSAAsymmetricKey key,
  required Uint8List data,
}) {
  AsymmetricKeyParameter keyParams;

  if (isEncrypt) {
    keyParams = PublicKeyParameter<RSAPublicKey>(key as RSAPublicKey);
  } else {
    keyParams = PrivateKeyParameter<RSAPrivateKey>(key as RSAPrivateKey);
  }

  final engine = OAEPEncoding(RSAEngine())..init(isEncrypt, keyParams);

  final numBlocks = data.length ~/ engine.inputBlockSize +
      ((data.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < data.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= data.length)
        ? engine.inputBlockSize
        : data.length - inputOffset;

    outputOffset += engine.processBlock(
      data,
      inputOffset,
      chunkSize,
      output,
      outputOffset,
    );

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}
