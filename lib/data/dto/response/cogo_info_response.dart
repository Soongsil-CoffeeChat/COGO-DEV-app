import 'package:freezed_annotation/freezed_annotation.dart';

part 'cogo_info_response.freezed.dart';
part 'cogo_info_response.g.dart';

@freezed
class CogoInfoResponse with _$CogoInfoResponse {
  const factory CogoInfoResponse({
    required int applicationId,
    required String menteeName,
    required String mentorName,
    required String applicationMemo,
    required String applicationDate,
    required String applicationStartTime,
    required String applicationEndTime,
  }) = _CogoInfoResponse;

  factory CogoInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CogoInfoResponseFromJson(json);
}
