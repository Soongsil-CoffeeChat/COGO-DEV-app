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
      senderId: (json['senderId'] as num).toInt(),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ChatRoomImplToJson(_$ChatRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
    };
