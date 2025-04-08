import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_possible_date_response.freezed.dart';
part 'mentor_possible_date_response.g.dart';

@freezed
class MentorPossibleDateResponse with _$MentorPossibleDateResponse {
  const factory MentorPossibleDateResponse({
    required int possibleDateId,
    required String date,
    required String startTime,
    required String endTime,
    required bool active,
  }) = _MentorPossibleDateResponse;

  factory MentorPossibleDateResponse.fromJson(Map<String, dynamic> json) =>
      _$MentorPossibleDateResponseFromJson(json);
}
