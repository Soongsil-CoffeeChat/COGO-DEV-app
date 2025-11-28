import 'package:freezed_annotation/freezed_annotation.dart';

part 'linked_cogo_response.freezed.dart';
part 'linked_cogo_response.g.dart';

@freezed
class LinkedCogoResponse with _$LinkedCogoResponse {
  const factory LinkedCogoResponse({
    @JsonKey(name: 'applicationId') required int applicationId,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'startTime') required String startTime,
  }) = _LinkedCogoResponse;

  factory LinkedCogoResponse.fromJson(Map<String, dynamic> json) =>
      _$LinkedCogoResponseFromJson(json);
}
