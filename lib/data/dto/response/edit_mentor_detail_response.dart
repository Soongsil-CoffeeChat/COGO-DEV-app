import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_mentor_detail_response.freezed.dart';
part 'edit_mentor_detail_response.g.dart';

@freezed
class EditMentorDetailResponse with _$EditMentorDetailResponse {
  const factory EditMentorDetailResponse({
    required String mentorName,
    required String mentorPhoneNumber,
    required String mentorEmail,
  }) = _EditMentorDetailResponse;

  factory EditMentorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EditMentorDetailResponseFromJson(json);
}
