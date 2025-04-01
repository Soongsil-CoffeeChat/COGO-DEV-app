import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_signup_response.freezed.dart';
part 'mentor_signup_response.g.dart';

@freezed
class MentorSignupResponse with _$MentorSignupResponse {
  const factory MentorSignupResponse({
    @JsonKey(name: 'part') required String part,
    @JsonKey(name: 'club') required String club,
  }) = _MentorSignupResponse;

  factory MentorSignupResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorSignupResponseFromJson(json);
}
