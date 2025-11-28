import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_response.freezed.dart';
part 'user_info_response.g.dart';

@freezed
class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    @JsonKey(name: 'userId') required int userId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'email') required String? email,
    @JsonKey(name: 'phoneNum') required String phoneNum,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'part') required String part,
    @JsonKey(name: 'club') required String? club,
    @JsonKey(name: 'picture') required String? picture,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
}
