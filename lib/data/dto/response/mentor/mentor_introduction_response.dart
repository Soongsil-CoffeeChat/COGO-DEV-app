import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_introduction_response.freezed.dart';
part 'mentor_introduction_response.g.dart';

@freezed
class MentorIntroductionResponse with _$MentorIntroductionResponse {
  const factory MentorIntroductionResponse({
    @JsonKey(name: 'introduction_title') required String? introductionTitle,
    @JsonKey(name: 'introduction_description')
    required String? introductionDescription,
    @JsonKey(name: 'introduction_answer1') required String? introductionAnswer1,
    @JsonKey(name: 'introduction_answer2') required String? introductionAnswer2,
  }) = _MentorIntroductionResponse;

  factory MentorIntroductionResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorIntroductionResponseFromJson(json);
}
