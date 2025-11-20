// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomResponseImpl _$$ChatRoomResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomResponseImpl(
      content: (json['content'] as List<dynamic>)
          .map((e) => ChatRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      last: json['last'] as bool,
    );

Map<String, dynamic> _$$ChatRoomResponseImplToJson(
        _$ChatRoomResponseImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
    };

_$ChatRoomImpl _$$ChatRoomImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomImpl(
      roomId: (json['roomId'] as num).toInt(),
      lastChat: json['lastChat'] as String?,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'lastChat': instance.lastChat,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'participants': instance.participants,
    };

_$ParticipantImpl _$$ParticipantImplFromJson(Map<String, dynamic> json) =>
    _$ParticipantImpl(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$$ParticipantImplToJson(_$ParticipantImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'name': instance.name,
      'profileImage': instance.profileImage,
    };
