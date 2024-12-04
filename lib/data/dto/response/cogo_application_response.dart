import 'package:freezed_annotation/freezed_annotation.dart';

part 'cogo_application_response.freezed.dart';
part 'cogo_application_response.g.dart';

@freezed
class CogoApplicationResponse with _$CogoApplicationResponse {
  const factory CogoApplicationResponse({
    int? mentorId,
    int? possibleDateId,
    String? memo,
  }) = _CogoApplicationResponse;

  factory CogoApplicationResponse.fromJson(Map<String, dynamic> json) =>
      _$CogoApplicationResponseFromJson(json);
}
