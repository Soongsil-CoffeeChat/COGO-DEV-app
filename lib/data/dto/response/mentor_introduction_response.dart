import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_introduction_response.freezed.dart';
part 'mentor_introduction_response.g.dart';

@freezed
class MentorIntroductionResponse with _$MentorIntroductionResponse {
  const factory MentorIntroductionResponse({
    String? introductionTitle,
    String? introductionDescription,
    String? introductionAnswer1,
    String? introductionAnswer2,
  }) = _MentorIntroductionResponse;

  factory MentorIntroductionResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorIntroductionResponseFromJson(json);
}
