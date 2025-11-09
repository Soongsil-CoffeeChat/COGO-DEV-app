import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_detail_response.freezed.dart';
part 'chat_room_detail_response.g.dart';

@freezed
class ChatRoomDetailResponse with _$ChatRoomDetailResponse {
  const factory ChatRoomDetailResponse({
    required int id,
    required String name,
    required List<ChatParticipant> participants,
  }) = _ChatRoomDetailResponse;

  factory ChatRoomDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDetailResponseFromJson(json);
}

@freezed
class ChatParticipant with _$ChatParticipant {
  const factory ChatParticipant({
    required int userId,
    required String username,
    required String profileImage,
  }) = _ChatParticipant;

  factory ChatParticipant.fromJson(Map<String, dynamic> json) =>
      _$ChatParticipantFromJson(json);
}
