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

    // 서버 응답에는 name 없음 → optional
    @JsonKey(name: 'name') String? name,

    // null 가능
    @JsonKey(name: 'lastChat') String? lastChat,

    // 서버는 updatedAt 아니라 updateAt 내려줌 → 키 변경
    @JsonKey(name: 'updateAt') required DateTime updatedAt,

    // 서버 응답에는 없음 → optional 처리
    @JsonKey(name: 'application') Application? application,
    @JsonKey(name: 'participants') List<Participant>? participants,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

@freezed
class Application with _$Application {
  const factory Application({
    @JsonKey(name: 'applicationId') required int applicationId,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) =>
      _$ApplicationFromJson(json);
}

@freezed
class Participant with _$Participant {
  const factory Participant({
    @JsonKey(name: 'userId') required int userId,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'profileImage') required String profileImage,
  }) = _Participant;

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);
}
