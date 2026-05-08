import "dart:math";
import "dart:typed_data";

import "package:pointycastle/export.dart";

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
  SecureRandom secureRandom, {
  int bitLength = 2048,
}) {
  /**
    The RSAKeyGeneratorParameters has:

    + the public exponent to use (must be an odd number)
    + bit strength (e.g. 2048 or 4096)
    + a certainty factor (the maximum number of rounds used by the Miller-Rabin primality test: larger numbers increase the probability a non-prime is correctly identified as being non-prime).
   */

  final keyGen =
      RSAKeyGenerator()..init(
        ParametersWithRandom(
          RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
          secureRandom,
        ),
      );

  final pair = keyGen.generateKeyPair();

  final myPublic = pair.publicKey;
  final myPrivate = pair.privateKey;

  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
}

SecureRandom genSecRand() {
  final secureRandom = FortunaRandom();

  final seedSource = Random.secure();
  final seeds = <int>[];
  for (int i = 0; i < 32; i++) {
    seeds.add(seedSource.nextInt(255));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  return secureRandom;
}

Uint8List rsaSign(
  RSAPrivateKey privateKey,
  Uint8List dataToSign,
  String rsaAlgorithmName,
) {
  final signer = Signer('$rsaAlgorithmName/RSA');
  signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  final sig = signer.generateSignature(dataToSign) as RSASignature;
  return sig.bytes;
}

bool rsaVerify(
  RSAPublicKey publicKey,
  Uint8List signedData,
  Uint8List signature,
  String rsaAlgorithmName,
) {
  final sig = RSASignature(signature);
  final verifier = Signer('$rsaAlgorithmName/RSA');
  verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
  try {
    return verifier.verifySignature(signedData, sig);
  } on ArgumentError {
    return false;
  }
}
