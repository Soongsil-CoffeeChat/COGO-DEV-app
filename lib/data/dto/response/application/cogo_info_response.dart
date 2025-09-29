import 'package:freezed_annotation/freezed_annotation.dart';

part 'cogo_info_response.freezed.dart';
part 'cogo_info_response.g.dart';

@freezed
class CogoInfoResponse with _$CogoInfoResponse {
  const factory CogoInfoResponse({
    @JsonKey(name: 'applicationId') required int applicationId,
    @JsonKey(name: 'otherPartyName') required String otherPartyName,
    @JsonKey(name: 'applicationStatus') required String applicationStatus,
    @JsonKey(name: 'applicationDate') required String applicationDate,
  }) = _CogoInfoResponse;

  factory CogoInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CogoInfoResponseFromJson(json);
}
