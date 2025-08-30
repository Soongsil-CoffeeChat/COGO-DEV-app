import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_mentor_detail_response.freezed.dart';
part 'edit_mentor_detail_response.g.dart';

@freezed
class EditMentorDetailResponse with _$EditMentorDetailResponse {
  const factory EditMentorDetailResponse({
    @JsonKey(name: 'mentorId') required int mentorId,
    @JsonKey(name: 'mentorName') required String mentorName,
    @JsonKey(name: 'part') required String part,
    @JsonKey(name: 'club') required String club,
    @JsonKey(name: 'introductionTitle') required String introductionTitle,
    @JsonKey(name: 'introductionDescription')
    required String introductionDescription,
    @JsonKey(name: 'introductionAnswer1') required String introductionAnswer1,
    @JsonKey(name: 'introductionAnswer2') required String introductionAnswer2,
    @JsonKey(name: 'imageUrl') required String imageUrl,
  }) = _EditMentorDetailResponse;

  factory EditMentorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EditMentorDetailResponseFromJson(json);
}
