// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accessTokenExpiresIn: (json['accessTokenExpiresIn'] as num).toInt(),
      accountStatus: json['accountStatus'] as String,
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiresIn': instance.accessTokenExpiresIn,
      'accountStatus': instance.accountStatus,
    };
