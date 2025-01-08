import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_mentor_detail_response.freezed.dart';
part 'edit_mentor_detail_response.g.dart';

@freezed
class EditMentorDetailResponse with _$EditMentorDetailResponse {
  const factory EditMentorDetailResponse({
    @JsonKey(name: 'mentor_name') required String mentorName,
    @JsonKey(name: 'mentor_phone_number') required String mentorPhoneNumber,
    @JsonKey(name: 'mentor_email') required String mentorEmail,
  }) = _EditMentorDetailResponse;

  factory EditMentorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EditMentorDetailResponseFromJson(json);
}
