import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_info_response.freezed.dart';
part 'my_info_response.g.dart';

@freezed
class MyInfoResponse with _$MyInfoResponse {
  const factory MyInfoResponse({
    required String name,
    String? email,
    String? phoneNum,
    String? role,
    String? part,
    String? club,
    String? picture,
  }) = _MyInfoResponse;

  factory MyInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$MyInfoResponseFromJson(json);
}
