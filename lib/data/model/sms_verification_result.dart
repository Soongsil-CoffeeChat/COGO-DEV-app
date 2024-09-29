import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_verification_result.freezed.dart';
part 'sms_verification_result.g.dart';

@freezed
class SmsVerificationResult with _$SmsVerificationResult {
  const factory SmsVerificationResult.success({
    required String verificationCode,
    required String message,
  }) = Success;

  const factory SmsVerificationResult.failure({
    required String errorMessage,
  }) = Failure;

  factory SmsVerificationResult.fromJson(Map<String, dynamic> json) =>
      _$SmsVerificationResultFromJson(json);
}
