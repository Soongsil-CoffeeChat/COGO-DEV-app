import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_detail_response.freezed.dart';
part 'mentor_detail_response.g.dart';

@freezed
class MentorDetailResponse with _$MentorDetailResponse {
  const factory MentorDetailResponse({
    required int mentorId,
    String? mentorName,
    String? part,
    String? club,
    String? introductionTitle,
    String? introductionDescription,
    String? introductionAnswer1,
    String? introductionAnswer2,
    String? imageUrl,
  }) = _MentorDetailResponse;

  factory MentorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorDetailResponseFromJson(json);
}
