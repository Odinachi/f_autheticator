library two_fa_authenticator;

import 'package:otp/otp.dart';

class FAuthenticator {
  final String? secret;
  final String appName;
  final String username;
  final int keyLength;
  final int interval;
  final Algorithm algorithm;
  final bool isGoogle;

  FAuthenticator(
      {this.secret,
      this.algorithm = Algorithm.SHA1,
      this.interval = 30,
      this.isGoogle = true,
      this.keyLength = 6,
      required this.appName,
      required this.username}) {
    _internalSecret = secret ?? OTP.randomSecret();
  }
  late final String _internalSecret;

  String get getLink =>
      "otpauth://totp/$appName:$username?Algorithm=${_getAlgo(algorithm)}&digits=$keyLength&secret=$_internalSecret&issuer=$appName&period=$interval";

  String get getRandomSecret => OTP.randomSecret();

  String? get getCurrentSecret => _internalSecret;

  String get getCurrentStringCode => OTP.generateTOTPCodeString(
      _internalSecret, DateTime.now().millisecondsSinceEpoch,
      algorithm: algorithm,
      interval: interval,
      isGoogle: isGoogle,
      length: keyLength);

  int get getCurrentCode => OTP.generateTOTPCode(
      _internalSecret, DateTime.now().millisecondsSinceEpoch,
      algorithm: algorithm,
      interval: interval,
      isGoogle: isGoogle,
      length: keyLength);

  Stream<int> getCodeStream() =>
      Stream<int>.periodic(const Duration(seconds: 0), (val) => getCurrentCode)
          .asBroadcastStream();

  Stream<String> getStringCodeStream() => Stream<String>.periodic(
          const Duration(seconds: 0), (val) => getCurrentStringCode)
      .asBroadcastStream();

  String? _getAlgo(Algorithm algo) {
    return switch (algo) {
      Algorithm.SHA1 => "SHA1",
      Algorithm.SHA256 => "SHA256",
      Algorithm.SHA512 => "SHA512",
    };
  }
}
