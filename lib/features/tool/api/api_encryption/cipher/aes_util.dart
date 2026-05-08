import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';

enum AESKeyType {
  aes128,
  aes192,
  aes256;

  List<AESKeyType> get all => AESKeyType.values;

  int get byteLength {
    switch (this) {
      case AESKeyType.aes128:
        return 16; // 128 bits
      case AESKeyType.aes192:
        return 24; // 192 bits
      case AESKeyType.aes256:
        return 32; // 256 bits
    }
  }

  int get bitLength {
    switch (this) {
      case AESKeyType.aes128:
        return 128;
      case AESKeyType.aes192:
        return 192;
      case AESKeyType.aes256:
        return 256;
    }
  }

  Uint8List get key {
    switch (this) {
      case AESKeyType.aes128:
        return Uint8List(16);
      case AESKeyType.aes192:
        return Uint8List(24);
      case AESKeyType.aes256:
        return Uint8List(32);
    }
  }
}

Uint8List? generateRandomBytes(int numBytes) {
  FortunaRandom secureRandom = FortunaRandom();
  secureRandom.seed(
    KeyParameter(Platform.instance.platformEntropySource().getBytes(32)),
  );
  return secureRandom.nextBytes(numBytes);
}

String bin2hex(Uint8List bytes, {String? separator, int? wrap}) {
  var len = 0;
  final buf = StringBuffer();
  for (final b in bytes) {
    final s = b.toRadixString(16);
    if (buf.isNotEmpty && separator != null) {
      buf.write(separator);
      len += separator.length;
    }

    if (wrap != null && wrap < len + 2) {
      buf.write('\n');
      len = 0;
    }

    buf.write('${(s.length == 1) ? '0' : ''}$s');
    len += 2;
  }
  return buf.toString();
}

Uint8List hex2bin(String hexStr) {
  if (hexStr.length % 2 != 0) {
    throw const FormatException('not an even number of hexadecimal characters');
  }
  final result = Uint8List(hexStr.length ~/ 2);
  for (var i = 0; i < result.length; i++) {
    result[i] = int.parse(hexStr.substring(2 * i, 2 * (i + 1)), radix: 16);
  }
  return result;
}

Uint8List passphraseToKey(
  String passPhrase, {
  String salt = '',
  int iterations = 30000,
  required int bitLength,
}) {
  if (![128, 192, 256].contains(bitLength)) {
    throw ArgumentError.value(bitLength, 'bitLength', 'invalid for AES');
  }
  final numBytes = bitLength ~/ 8;

  final kd = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64)) // 64 for SHA-256
  ..init(Pbkdf2Parameters(utf8.encode(salt), iterations, numBytes));

  return kd.process(utf8.encode(passPhrase));
}
