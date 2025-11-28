// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoResponseImpl _$$UserInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserInfoResponseImpl(
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNum: json['phoneNum'] as String,
      role: json['role'] as String,
      part: json['part'] as String,
      club: json['club'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$UserInfoResponseImplToJson(
        _$UserInfoResponseImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'phoneNum': instance.phoneNum,
      'role': instance.role,
      'part': instance.part,
      'club': instance.club,
      'picture': instance.picture,
    };
