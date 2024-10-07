class SmsVerificationResponse {
  final String verificationCode;
  final String message;

  SmsVerificationResponse({
    required this.verificationCode,
    required this.message,
  });

  factory SmsVerificationResponse.fromJson(Map<String, dynamic> json) {
    return SmsVerificationResponse(
      verificationCode: json['verificationCode'].toString(),
      message: json['message'] as String,
    );
  }
}
