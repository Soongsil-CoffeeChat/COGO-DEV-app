// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomDetailResponseImpl _$$ChatRoomDetailResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomDetailResponseImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => ChatParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatRoomDetailResponseImplToJson(
        _$ChatRoomDetailResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'participants': instance.participants,
    };

_$ChatParticipantImpl _$$ChatParticipantImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatParticipantImpl(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
    );

Map<String, dynamic> _$$ChatParticipantImplToJson(
        _$ChatParticipantImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'profileImage': instance.profileImage,
    };
