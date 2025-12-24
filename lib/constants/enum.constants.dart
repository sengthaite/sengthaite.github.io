import 'dart:io';

import 'package:flutter/foundation.dart';

enum TabSection { content, tool, project }

enum CryptoType {
  aesCBC,
  aesCCM,
  aesCCMAEAD,
  aesCFB,
  aesChaCha20Poly1305,
  aesChaCha20Poly1305AEAD,
  aesCTR,
  aesECB,
  aesGCM,
  aesIGE,
  aesOFB,
  rsa,
  rsaOAEP;

  factory CryptoType.fromIndex(int index) {
    return CryptoType.values[index];
  }

  int get getIndex {
    return CryptoType.values.indexOf(this);
  }

  String get value {
    switch (this) {
      case CryptoType.aesCBC:
        return "AES-CBC";
      case CryptoType.aesCCM:
        return "AES-CCM";
      case CryptoType.aesCCMAEAD:
        return "AES-CCM-AEAD";
      case CryptoType.aesCFB:
        return "AES-CFB";
      case CryptoType.aesChaCha20Poly1305:
        return "AES-ChaCha20-Poly1305";
      case CryptoType.aesChaCha20Poly1305AEAD:
        return "AES-ChaCha20-Poly1305-AEAD";
      case CryptoType.aesCTR:
        return "AES-CTR";
      case CryptoType.aesECB:
        return "AES-ECB";
      case CryptoType.aesGCM:
        return "AES-GCM";
      case CryptoType.aesIGE:
        return "AES-IGE";
      case CryptoType.aesOFB:
        return "AES-OFB";
      case CryptoType.rsa:
        return "RSA";
      case CryptoType.rsaOAEP:
        return "RSA-OAEP";
    }
  }
}

enum CurrentPlatform {
  android,
  fuchsia,
  ios,
  linux,
  macos,
  unknown,
  web,
  windows;

  static CurrentPlatform get type {
    if (kIsWeb) return CurrentPlatform.web;
    final currentOS = Platform.operatingSystem;
    switch (currentOS) {
      case "android": return CurrentPlatform.android;
      case "fuchsia": return CurrentPlatform.fuchsia;
      case "ios": return CurrentPlatform.ios;
      case "linux": return CurrentPlatform.linux;
      case "macos": return CurrentPlatform.macos;
      case "windows": return CurrentPlatform.windows;
      default:
        return CurrentPlatform.unknown;
    }
  }
}