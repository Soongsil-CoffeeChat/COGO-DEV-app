import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_signup_response.freezed.dart';
part 'mentor_signup_response.g.dart';

@freezed
class MentorSignupResponse with _$MentorSignupResponse {
  const factory MentorSignupResponse({
    required String part,
    required String club,
    required int introductionId,
  }) = _MentorSignupResponse;

  factory MentorSignupResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorSignupResponseFromJson(json);
}
