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
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      lastChat: json['lastChat'] as String?,
      updatedAt: DateTime.parse(json['updateAt'] as String),
      application: json['application'] == null
          ? null
          : Application.fromJson(json['application'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastChat': instance.lastChat,
      'updateAt': instance.updatedAt.toIso8601String(),
      'application': instance.application,
      'participants': instance.participants,
    };

_$ApplicationImpl _$$ApplicationImplFromJson(Map<String, dynamic> json) =>
    _$ApplicationImpl(
      applicationId: (json['applicationId'] as num).toInt(),
    );

Map<String, dynamic> _$$ApplicationImplToJson(_$ApplicationImpl instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
    };

_$ParticipantImpl _$$ParticipantImplFromJson(Map<String, dynamic> json) =>
    _$ParticipantImpl(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$$ParticipantImplToJson(_$ParticipantImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'profileImage': instance.profileImage,
    };
