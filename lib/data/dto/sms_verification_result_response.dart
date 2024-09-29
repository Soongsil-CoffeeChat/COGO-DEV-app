class SmsVerificationResult {
  final String verificationCode;
  final String message;

  SmsVerificationResult({
    required this.verificationCode,
    required this.message,
  });

  factory SmsVerificationResult.fromJson(Map<String, dynamic> json) {
    return SmsVerificationResult(
      verificationCode: json['verificationCode'].toString(),
      message: json['message'] as String,
    );
  }
}
