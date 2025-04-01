import 'package:freezed_annotation/freezed_annotation.dart';

part 'cogo_application_response.freezed.dart';
part 'cogo_application_response.g.dart';

@freezed
class CogoApplicationResponse with _$CogoApplicationResponse {
  const factory CogoApplicationResponse({
    @JsonKey(name: 'applicationId') required int applicationId,
    @JsonKey(name: 'mentorId') required int mentorId,
    @JsonKey(name: 'menteeId') required int menteeId,
    @JsonKey(name: 'applicationMemo') required String applicationMemo,
    @JsonKey(name: 'applicationDate') required String applicationDate,
    @JsonKey(name: 'applicationStartTime') required String applicationStartTime,
    @JsonKey(name: 'applicationEndTime') required String applicationEndTime,
  }) = _CogoApplicationResponse;

  factory CogoApplicationResponse.fromJson(Map<String, dynamic> json) =>
      _$CogoApplicationResponseFromJson(json);
}
