import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_response.freezed.dart';
part 'user_info_response.g.dart';

@freezed
class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    required String username,
    required String name,
    required String email,
    required String role,
    required String phoneNum,
    String? picture,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
}
