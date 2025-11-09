// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyInfoResponseImpl _$$MyInfoResponseImplFromJson(Map<String, dynamic> json) =>
    _$MyInfoResponseImpl(
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNum: json['phoneNum'] as String?,
      role: json['role'] as String?,
      part: json['part'] as String?,
      club: json['club'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$$MyInfoResponseImplToJson(
        _$MyInfoResponseImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phoneNum': instance.phoneNum,
      'role': instance.role,
      'part': instance.part,
      'club': instance.club,
      'picture': instance.picture,
    };
