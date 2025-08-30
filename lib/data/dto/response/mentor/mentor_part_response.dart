import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_part_response.freezed.dart';
part 'mentor_part_response.g.dart';

@freezed
class MentorPartResponse with _$MentorPartResponse {
  const factory MentorPartResponse({
    String? picture,
    String? mentorName,
    String? part,
    String? club,
    String? username,
    required int mentorId,
    String? title,
    String? description,
  }) = _MentorPartResponse;

  factory MentorPartResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorPartResponseFromJson(json);
}
