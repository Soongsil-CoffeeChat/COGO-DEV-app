import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_verification_response.freezed.dart';
part 'sms_verification_response.g.dart';

@freezed
class SmsVerificationResponse with _$SmsVerificationResponse {
  const factory SmsVerificationResponse({
    @JsonKey(name: 'verificationCode') required String verificationCode,
  }) = _SmsVerificationResponsee;

  factory SmsVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsVerificationResponseFromJson(json);
}
