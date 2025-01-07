import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_response.freezed.dart';
part 'email_verification_response.g.dart';

@freezed
class EmailVerificationResponse with _$EmailVerificationResponse {
  const factory EmailVerificationResponse({
    required String code,
  }) = _EmailVerificationResponse;

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationResponseFromJson(json);
}
