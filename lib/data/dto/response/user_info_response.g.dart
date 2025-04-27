// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoResponseImpl _$$UserInfoResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$UserInfoResponseImpl(
      username: json['username'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phoneNum: json['phoneNum'] as String,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$UserInfoResponseImplToJson(
        _$UserInfoResponseImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'phoneNum': instance.phoneNum,
      'picture': instance.picture,
    };
