import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentee_signup_response.freezed.dart';
part 'mentee_signup_response.g.dart';

@freezed
class MenteeSignupResponse with _$MenteeSignupResponse {
  const factory MenteeSignupResponse({
    required String part,
  }) = _MenteeSignupResponse;

  factory MenteeSignupResponse.fromJson(Map<String, dynamic> json) =>
      _$MenteeSignupResponseFromJson(json);
}
