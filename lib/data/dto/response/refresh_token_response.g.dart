// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefreshTokenResponseImpl _$$RefreshTokenResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RefreshTokenResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accessTokenExpiresIn: (json['accessTokenExpiresIn'] as num).toInt(),
      accountStatus: json['accountStatus'] as String?,
    );

Map<String, dynamic> _$$RefreshTokenResponseImplToJson(
        _$RefreshTokenResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpiresIn': instance.accessTokenExpiresIn,
      'accountStatus': instance.accountStatus,
    };
