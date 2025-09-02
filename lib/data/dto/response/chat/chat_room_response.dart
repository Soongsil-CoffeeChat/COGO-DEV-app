// chat_room_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_response.freezed.dart';
part 'chat_room_response.g.dart';

@freezed
class ChatRoomResponse with _$ChatRoomResponse {
  const factory ChatRoomResponse({
    @JsonKey(name: 'content') required List<ChatRoom> content,
    @JsonKey(name: 'pageNumber') required int pageNumber,
    @JsonKey(name: 'pageSize') required int pageSize,
    @JsonKey(name: 'totalElements') required int totalElements,
    @JsonKey(name: 'totalPages') required int totalPages,
    @JsonKey(name: 'last') required bool last,
  }) = _ChatRoomResponse;

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);
}

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'senderId') required int senderId,
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
