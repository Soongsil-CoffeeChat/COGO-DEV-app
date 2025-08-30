import 'package:freezed_annotation/freezed_annotation.dart';

part 'cogo_info_response.freezed.dart';
part 'cogo_info_response.g.dart';

@freezed
class CogoInfoResponse with _$CogoInfoResponse {
  const factory CogoInfoResponse({
    @JsonKey(name: 'applicationId') required int applicationId,
    @JsonKey(name: 'menteeName') required String menteeName,
    @JsonKey(name: 'mentorName') required String mentorName,
    @JsonKey(name: 'applicationMemo') required String applicationMemo,
    @JsonKey(name: 'applicationDate') required String applicationDate,
    @JsonKey(name: 'applicationStartTime') required String applicationStartTime,
    @JsonKey(name: 'applicationEndTime') required String applicationEndTime,
  }) = _CogoInfoResponse;

  factory CogoInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CogoInfoResponseFromJson(json);
}
